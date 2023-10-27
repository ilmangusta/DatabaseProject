CREATE OR REPLACE PACKAGE AUTHENTICATE AS

 -- @Author : Gabriele
-----------------------------------------------------------------
--                      COSTANTI
-----------------------------------------------------------------
        COOKIE_NAME             CONSTANT VARCHAR2(100) := 'CrociereSessione';

        DOMINIO                 CONSTANT CHAR(38) := 'http://oracle01.polo2.ad.unipi.it:8080';
        DB_UTENTE               CONSTANT VARCHAR2(30)  := 'testUTENTE2223';

        API_LOGIN_URL           CONSTANT CHAR(LENGTH(DB_UTENTE)+52) := '/apex/'||DB_UTENTE||'.authenticate.CREA_SESSIONE';
        API_REFRESH_URL         CONSTANT CHAR(LENGTH(DB_UTENTE)+37) := '/apex/'||DB_UTENTE||'.authenticate.AGGIORNA_SESSIONE';
        API_LOGOUT_URL          CONSTANT CHAR(LENGTH(DB_UTENTE)+37) := '/apex/'||DB_UTENTE||'.authenticate.CANCELLA_SESSIONE';
        
        LOGIN_URL               CONSTANT CHAR(LENGTH(DB_UTENTE)+30) := '/apex/'||DB_UTENTE||'.authenticate.login';
        LOGOUT_URL              CONSTANT CHAR(LENGTH(DB_UTENTE)+31) := '/apex/'||DB_UTENTE||'.authenticate.logout';
        
        LISTA_SESSIONI_URL      CONSTANT CHAR(LENGTH(DB_UTENTE)+34) := '/apex/'||DB_UTENTE||'.authenticate.lista_sessioni';
        HOMEPAGE_URL            CONSTANT CHAR(LENGTH(DB_UTENTE)+23) := '/apex/'||DB_UTENTE||'.gui.aprihomepage';
        HOMEPAGELOGIN_URL       CONSTANT CHAR(LENGTH(DB_UTENTE)+30) := '/apex/'||DB_UTENTE||'.gui.homepagelogin';
        API_SHOW_SESSIONS_URL   CONSTANT CHAR(LENGTH(DB_UTENTE)+33) := '/apex/'||DB_UTENTE||'.authenticate.show_sessions';
-----------------------------------------------------------------
--                      ECCEZIONI
-----------------------------------------------------------------
        UTENTE_NON_TROVATO      EXCEPTION;
        SESSIONE_NON_TROVATA    EXCEPTION;
        PASSWORD_ERRATA         EXCEPTION;
        
        ERRORE_PASSWORD         CONSTANT CHAR(15) := 'Password errata';
        ERRORE_SESSIONE         CONSTANT CHAR(15) := 'Login Richiesto';
        ERRORE_UTENTE           CONSTANT CHAR(21) := 'Utente Non Registrato';
-----------------------------------------------------------------
--                      Funzioni Utility
-----------------------------------------------------------------

        --dato il codice fiscale di un utente restituisce la riga
        FUNCTION UTENTE_DA_USERNAME(
                p_USERNAME      IN UTENTE.USERNAME%TYPE
        )
        RETURN UTENTE%ROWTYPE;
        
        --data la sessione restituisce la riga dell'utente corrispondente
        FUNCTION UTENTE_DA_SESSIONE(
                p_SESSIONE      IN SESSIONE%ROWTYPE
        )
        RETURN UTENTE%ROWTYPE;
        
        FUNCTION RECUPERA_SESSIONE
        RETURN SESSIONE%ROWTYPE;
---------------------------------------------------------------------------
--                      API autenticazione (si dovrebbero usare con fetch)
---------------------------------------------------------------------------

        PROCEDURE CREA_SESSIONE(
                p_username      IN BE_UTENTE.USERNAME%TYPE,
                p_password      IN VARCHAR2
        );
        PROCEDURE AGGIORNA_SESSIONE;
        PROCEDURE CANCELLA_SESSIONE;
-----------------------------------------------------------------
--                      API test
-----------------------------------------------------------------
        -- PROCEDURE SHOW_SESSIONS(
        --         p_nome          IN VARCHAR2 DEFAULT NULL,
        --         p_cognome       IN VARCHAR2 DEFAULT NULL
        -- );
-----------------------------------------------------------------
--                      Procedure Autenticazione
-----------------------------------------------------------------

        PROCEDURE LOGIN(
                p_CALLBACK      IN VARCHAR2 DEFAULT DOMINIO||HOMEPAGELOGIN_URL
        );
        PROCEDURE LOGOUT(
                p_CALLBACK      IN VARCHAR2 DEFAULT DOMINIO||HOMEPAGE_URL
        );
-----------------------------------------------------------------
--                      PROCEDURA DI TEST
-----------------------------------------------------------------
        -- PROCEDURE HELLO_WORLD;
        -- PROCEDURE PRINT_SESSIONTABLE;
-----------------------------------------------------------------
--                      ESEMPIO PROCEDURA
-----------------------------------------------------------------
        -- PROCEDURE LISTA_SESSIONI;
END AUTHENTICATE;