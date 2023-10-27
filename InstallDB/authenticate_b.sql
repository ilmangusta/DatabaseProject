CREATE OR REPLACE PACKAGE BODY AUTHENTICATE AS
        FRESH_USER              EXCEPTION;

-----------------------------------------------------------------
--                      Javascript
-----------------------------------------------------------------
        --richiede costante url(quello di callback)
        LOGINJS                 CONSTANT VARCHAR2(3000) := 'window.addEventListener("DOMContentLoaded",()=>{let e=document.querySelector("#login");var t=document.querySelector("#uname"),n=document.querySelector("#pwd");let o=document.querySelector("#output");e.addEventListener("click",()=>{let e=new URL("'||API_LOGIN_URL||'",window.location.origin);e.searchParams.append("p_username",t.value),e.searchParams.append("p_password",n.value),fetch(e,{method:"GET",headers:{"content-type":"application/json"}}).then(e=>{if(e.ok)return e.json();throw new Error(e.statusText)}).then(e=>window.location.href=url).catch(e=>o.innerHTML=e)})});';
        --richiede costante url(quello di callback)
        LOGOUTJS                CONSTANT VARCHAR2(3000) := 'fetch("'||API_LOGOUT_URL||'",{method:"GET",headers:{"content-type":"application/json"}}).then(e=>{window.location.href=url});';
------------------------------------------------------------------
--                      Password Management
-----------------------------------------------------------------
-- MATCH(password, pepper, salt, hvalue|UserID)
-- Hash(password, pepper, salt)
        -- getOldPepper
        FUNCTION HASH_PWD(
                p_PASSWORD      IN VARCHAR2,
                p_PEPPER        IN BE_SESSIONE.PEPPER%TYPE,
                p_SALT          IN BE_UTENTE.SALT%TYPE
        ) RETURN RAW
        AS
                RAW_PWD         RAW(32);
                RAWS_CONCAT     RAW(96);
        BEGIN
                RAW_PWD := UTL_I18N.STRING_TO_RAW(p_PASSWORD, 'AL32UTF8');
                RAWS_CONCAT := UTL_RAW.CONCAT(RAW_PWD, p_PEPPER, p_SALT);
                RETURN DBMS_CRYPTO.HASH(RAWS_CONCAT, DBMS_CRYPTO.HASH_SH256);
        END HASH_PWD;
        PROCEDURE autentica( 
                p_USERNAME      IN  UTENTE.USERNAME%TYPE, 
                p_PASSWORD      IN  VARCHAR2 
        ) AS
                v_UTENTE        be_UTENTE%ROWTYPE;
                v_OLDPEP        RAW(32) := EMPTY_BLOB;
                v_HASH          RAW(32);
                v_COUNT         INTEGER;
        BEGIN
        -- recover salt, pepper and old password, can cause no_data_found
        -- if the username is invalid
                SELECT * INTO v_UTENTE
                FROM    be_UTENTE
                WHERE   
                        USERNAME = p_USERNAME;
        -- check if user is fresh
                SELECT COUNT(*) INTO v_COUNT
                FROM BE_SESSIONE
                WHERE IDUTENTE = V_UTENTE.IDUTENTE;
                IF v_COUNT > 0 THEN
        -- get latest session of user
        -- rank gives a number to each row, in this case based
        -- over idsess and the highest idsess number will give
        -- the lowest rank value (1), and that is the latest
        -- session
                        SELECT PEPPER INTO V_OLDPEP
                        FROM (
                                SELECT PEPPER, RANK() OVER (ORDER BY IDSessione DESC) AS RANGO
                                FROM BE_SESSIONE
                                WHERE IDUTENTE = V_UTENTE.IDUTENTE
                        )
                        WHERE RANGO = 1
                        ;
                END IF;
        -- hash pwd
                v_HASH := HASH_PWD(p_PASSWORD, v_OLDPEP, v_UTENTE.SALT);
        -- match the password with the saved one and return its result
                IF UTL_RAW.COMPARE(V_HASH, V_UTENTE.PASSWORD) <> 0 THEN 
                        RAISE PASSWORD_ERRATA;
                END IF;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                        RAISE UTENTE_NON_TROVATO;
        END AUTENTICA;
------------------------------------------------------------------
--                      Funzioni Utility
-----------------------------------------------------------------
        -- da cambiare con utente da username
        FUNCTION UTENTE_DA_USERNAME(
                p_USERNAME      IN UTENTE.USERNAME%TYPE
        )
        RETURN UTENTE%ROWTYPE
        IS
                v_RES           UTENTE%ROWTYPE;
        BEGIN
                SELECT * INTO v_RES FROM UTENTE WHERE UTENTE.USERNAME = p_USERNAME;
                RETURN v_RES;
        EXCEPTION
                WHEN no_data_found THEN
                        RAISE UTENTE_NON_TROVATO;
        END UTENTE_DA_USERNAME;

        FUNCTION UTENTE_DA_SESSIONE(
                p_SESSIONE      IN SESSIONE%ROWTYPE
        )
        RETURN UTENTE%ROWTYPE
        IS
                v_USERNAME      UTENTE.USERNAME%TYPE;
                v_RES           UTENTE%ROWTYPE;
        BEGIN
                SELECT USERNAME INTO v_USERNAME FROM be_UTENTE WHERE IDUtente = p_SESSIONE.IDUTENTE;
                SELECT * INTO v_RES FROM UTENTE WHERE UTENTE.USERNAME = v_USERNAME;
                return v_RES;
        EXCEPTION
                WHEN no_data_found THEN RAISE SESSIONE_NON_TROVATA;
        END UTENTE_DA_SESSIONE;

        FUNCTION RECUPERA_SESSIONE
        RETURN SESSIONE%ROWTYPE
        IS
                v_COOKIE        OWA_COOKIE.cookie;
                v_RES           SESSIONE%ROWTYPE;
                v_IDFOUND       SESSIONE.IDSESSIONE%TYPE;
        BEGIN
                v_COOKIE := OWA_COOKIE.GET(COOKIE_NAME);
                v_IDFOUND := TO_NUMBER(v_COOKIE.vals(1));
                UPDATE SESSIONE SET TSTAMP = SYSTIMESTAMP WHERE IDSESSIONE = v_IDFOUND;
                SELECT * INTO v_RES FROM SESSIONE WHERE SESSIONE.IDSESSIONE = v_IDFOUND;
                return v_RES;
        EXCEPTION
                WHEN no_data_found THEN RAISE SESSIONE_NON_TROVATA;
        END RECUPERA_SESSIONE;

---------------------------------------------------------------------------
--                      API autenticazione (si dovrebbero usare con fetch)
---------------------------------------------------------------------------
        PROCEDURE CREA_SESSIONE(
                p_username      IN BE_UTENTE.USERNAME%TYPE,
                p_password      IN VARCHAR2
        )
        IS
                v_UTENTE        be_UTENTE%ROWTYPE;
                v_IDSESSIONE    SESSIONE.IDSESSIONE%TYPE;
                v_freshPwd      RAW(32);
                v_freshPep      RAW(32);
        BEGIN
                autentica(p_username, p_password);
                SELECT * into v_utente FROM be_utente where username=p_username;
                v_IDSESSIONE := IDSESSIONE_SEQ.NEXTVAL;

                v_freshPep := DBMS_CRYPTO.RANDOMBYTES(32);
                v_freshPwd := hash_pwd(p_password, v_freshPep, v_utente.salt);

                UPDATE be_utente 
                SET password = v_freshPwd
                WHERE IDUTENTE = v_utente.IDUTENTE;
                INSERT INTO be_sessione
                VALUES(
                        v_IDSESSIONE, 
                        v_utente.IDUTENTE, 
                        v_utente.EPrivilegiato, 
                        SYSTIMESTAMP, 
                        v_freshPep
                );

                OWA_UTIL.MIME_HEADER('application/json', FALSE);
                OWA_COOKIE.SEND(COOKIE_NAME,TO_CHAR(v_IDSESSIONE));
                OWA_UTIL.HTTP_HEADER_CLOSE;
                HTP.P('{"sessionID":"'||v_IDSESSIONE||'"}');
        EXCEPTION
                WHEN UTENTE_NON_TROVATO THEN
                        OWA_UTIL.STATUS_LINE(400, ERRORE_UTENTE, TRUE);
                        HTP.P('{"message":"'||ERRORE_UTENTE||'"}');
                WHEN PASSWORD_ERRATA THEN
                        OWA_UTIL.STATUS_LINE(400, ERRORE_PASSWORD, TRUE);
                        HTP.P('{"message":"'||ERRORE_PASSWORD||'"}');
        END CREA_SESSIONE;

        PROCEDURE AGGIORNA_SESSIONE
        IS
                v_RES           SESSIONE%ROWTYPE;
        BEGIN
                v_RES := RECUPERA_SESSIONE;
                OWA_UTIL.MIME_HEADER('application/json', TRUE);
                HTP.P('{"message":"successo"}');
        EXCEPTION
                WHEN SESSIONE_NON_TROVATA THEN
                        OWA_UTIL.STATUS_LINE(400, ERRORE_SESSIONE, TRUE);
                        HTP.P('{"message":"'||ERRORE_SESSIONE||'"}');
        END AGGIORNA_SESSIONE;

        PROCEDURE CANCELLA_SESSIONE
        IS      
                v_RES           SESSIONE%ROWTYPE;
        BEGIN
                v_RES := RECUPERA_SESSIONE;
                
                OWA_UTIL.MIME_HEADER('application/json', FALSE);
                OWA_COOKIE.REMOVE(COOKIE_NAME, v_RES.IDSESSIONE);
                OWA_UTIL.HTTP_HEADER_CLOSE;
                
                HTP.P('{"message":"successo"}');
        EXCEPTION
                WHEN SESSIONE_NON_TROVATA THEN 
                        OWA_UTIL.STATUS_LINE(400, ERRORE_SESSIONE, TRUE);
                        HTP.P('{"message":"'||ERRORE_SESSIONE||'"}');
        END CANCELLA_SESSIONE;

-----------------------------------------------------------------
--                      Procedure Autenticazione
-----------------------------------------------------------------

        PROCEDURE LOGIN(
                p_CALLBACK      IN VARCHAR2 DEFAULT DOMINIO||HOMEPAGELOGIN_URL
        )
        IS
        BEGIN
                HTP.HTMLOPEN;
                HTP.HEADOPEN;
                htp.print('<link href="style.css" rel="style.css"/>');
                htp.print('<style> ' || Costanti.stile || ' </style>');
                HTP.TITLE('Log In');
                HTP.P('<script type="text/javascript">const url="'||p_CALLBACK||'"</script>');
                HTP.P('<script type="text/javascript">'||LOGINJS||'</script>');
                HTP.HEADCLOSE;
                HTP.BODYOPEN;
                GUI.APRIPAGINALOGIN;
                HTP.BODYCLOSE;
                HTP.HTMLCLOSE;
        END LOGIN;

        PROCEDURE LOGOUT(
                p_CALLBACK      IN VARCHAR2 DEFAULT DOMINIO||HOMEPAGE_URL
        )
        IS
        BEGIN
                HTP.P('<script type="text/javascript">const url="'||p_CALLBACK||'"</script>');
                HTP.P('<script type="text/javascript">'||LOGOUTJS||'</script>');
        END LOGOUT;
----------------------------------------------------------------------
--      DEBUG
----------------------------------------------------------------------

        PROCEDURE HELLO_WORLD IS BEGIN HTP.P('<p>Hello, World!</p>'); END HELLO_WORLD;
        PROCEDURE PRINT_SESSIONTABLE
        IS BEGIN
                HTP.HTMLOPEN;
                HTP.BODYOPEN;
                FOR R_SESSIONE IN (
                        SELECT * FROM BE_SESSIONE
                )
                LOOP
                        HTP.P('<p>'||R_SESSIONE.IDSESSIONE||' '||R_SESSIONE.IDUTENTE||' '||R_SESSIONE.EPRIVILEGIATO||' '||R_SESSIONE.TSTAMP||' '||R_SESSIONE.PEPPER||'</p>');
                END LOOP;
                HTP.BODYCLOSE;
                HTP.HTMLCLOSE;
        END PRINT_SESSIONTABLE;

-----------------------------------------------------------------
END AUTHENTICATE;