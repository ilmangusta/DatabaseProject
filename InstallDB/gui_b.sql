CREATE OR REPLACE package body GUI as

-------Author: Fabiana Chericoni--------------
------------------------------------------------------------
/*
SCRIPT PER FINESTRE DI CONFERMA E DI ALLARME.
Abbiamo a disposizione DUE differenti tipi di finestre di messaggio:

1. alert - finestre di avviso che ci comunicano un messaggio: il dialogo avviene solo dal sito all'utente.

2. confirm - finestre di scelta che ci chiedono di confermare o meno il verificarsi di un evento: il dialogo è bilaterale
*/


PROCEDURE APRIPAGINASTANDARD(TITOLO VARCHAR2 DEFAULT 'ISBD Crociere',LOAD VARCHAR2 DEFAULT '', MESSAGGIO VARCHAR2 DEFAULT '') AS

BEGIN
    HTP.HTMLOPEN;
    HTP.HEADOPEN;
    
        HTP.PRINT('<script type="text/javascript">
            function mostraMessaggio() {
            window.alert("'||MESSAGGIO||'");
        }
        
                
                function selectedValue(select) {
                  //recupera il valore della option selezionata
                  return(select.options[select.selectedIndex].value);
                }

                </script>
');
    HTP.TITLE(TITOLO);
    HTP.PRINT('<link href="style.css" rel="style.css"/>');
    HTP.PRINT('<style> ' || Costanti.stile  || ' </style>');
    HTP.HEADCLOSE;
    GUI.APRINAV;
    GUI.APRICONTAINER(LOAD);
END APRIPAGINASTANDARD;

--------------------------------------------------------------------------------------------------
/* APRICONTAINER: Affinchè il footer venga posizionato in fondo alla pagina, viene aggiunto un container con altezza e larghezza 100% che racchiude tutto il corpo della pagina
   LOAD: spermette di inserire un alert al caricamento della pagina (onload) oppure in uscita (), 
 */
 -----------------------------------------------------------------------------------------------

PROCEDURE APRICONTAINER(LOAD VARCHAR2 DEFAULT '') AS

BEGIN
    HTP.PRINT('<div class="container">');
    --HTP.BODYOPEN;
    IF (LOAD = 'onload' OR LOAD='onUnLoad') THEN
        HTP.PRINT('<body ' || LOAD || '=mostraMessaggio()>');
    ELSE
        HTP.BODYOPEN;
    END IF;
END APRICONTAINER;

--------------------------------------------------------------------------------------------------
/* CHIUDICONTEINER: chiude il div del container contenente il corpo della pagina.
Dopo tale procedura si inserisce il footer della pagina.
 */
 -----------------------------------------------------------------------------------------------

PROCEDURE CHIUDICONTAINER AS
BEGIN 
    HTP.BODYCLOSE;
    HTP.PRINT('</div>');
END CHIUDICONTAINER;

--------------------------------------------------------------------------------------------------
/* APRICHIUDIFOOTER: inserisce il footer della pagina.
   creatore = verde/arancio/blu.
 */
 -----------------------------------------------------------------------------------------------

PROCEDURE FOOTER(creatore varchar default 'Interfacce') AS
BEGIN 
    HTP.PRINT('<div class="footer ' || creatore || ' "> Powered by Gruppo ' || creatore || ' © 2022-2023.</div>');
END FOOTER;

------------------------------------------------------------------------------------------------------------------------------------------------
/*  CHIUDIPAGINASTANDARD: ./* Stampa il footer, chiude il tag body precedente aperto */
-------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE CHIUDIPAGINASTANDARD(footer varchar default 'Interfacce') AS
BEGIN
    GUI.CHIUDICONTAINER;
    GUI.FOOTER(footer);
    HTP.HTMLCLOSE; 
END CHIUDIPAGINASTANDARD; 


-------------------------------------------------------------------------------------------------------------------------------------------------
/* APRIHOMEPAGE: apre l'homepage del sito, con il form di ricerca della crociera.
*/
-------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE APRIHOMEPAGE AS 
BEGIN 
    GUI.APRIPAGINASTANDARD();
    GUI.FORMCERCA;
    GUI.CHIUDIPAGINASTANDARD('Interfaccia');
END APRIHOMEPAGE;


 -------------------------------------------------------------------------------------------------------------------------------------------------
/* APRIPAGINALOGIN: apre la pagina per efettuare il login-
*/
------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE APRIPAGINALOGIN AS 
BEGIN 
    GUI.APRIPAGINASTANDARD;
    GUI.FORMLOGIN;
    GUI.CHIUDIPAGINASTANDARD('Interfaccia');
END APRIPAGINALOGIN;


  -------------------------------------------------------------------------------------------------------------------------------------------------
/* APRIHOMEPAGE_LOGIN: apre la pagina per efettuare il login-
 */
------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE HOMEPAGELOGIN AS 
BEGIN 
    GUI.APRIPAGINASTANDARD(LOAD => 'onload',MESSAGGIO => 'BENVENUTO');
    GUI.FORMGRUPPI;
    GUI.CHIUDIPAGINASTANDARD('Interfaccia');
END HOMEPAGELOGIN;

 -----------------------------------------------------------------------------------------
/* APRINAV: apre la nav bar della pagina, si distinguono due tipologie a seconda che l'utente sia identificato o meno.
   */
---------------------------------------------------------------------------------------

PROCEDURE APRINAV as
V_SESSIONE    SESSIONE%ROWTYPE;
BEGIN
    BEGIN
        V_SESSIONE := AUTHENTICATE.RECUPERA_SESSIONE;
        EXCEPTION WHEN AUTHENTICATE.SESSIONE_NON_TROVATA THEN
            NULL;
    END;
    IF (V_SESSIONE.IDSESSIONE IS NULL) THEN ---guest session
        HTP.PRINT(' <div class="nav">
                    <a class="title" href = "#home">
                        <div class = "title1">ISBD</div>
                        <div class = "title2">Crociere</div>
                    </a>
                    <div class = "buttons">
                        <div class= "sx" >');
                            -- procedura logout_url, presente nel pacchetto authenticate, permette di tornare alla home page
                            HTP.PRINT(' <a href= '|| AUTHENTICATE.LOGOUT_URL || '>');
                            GUI.BTN(TXT => 'Home');
                            HTP.PRINT(' </a>');
                            GUI.BTN(TXT => 'Contatti');
                        HTP.PRINT('</div>
                        <div class= "dx" >');
                            GUI.BTN(TXT => 'Registrazione');
                            -- procedura login_url, presente nel pacchetto authenticate, permette di accedere alla pagina di login
                            HTP.PRINT(' <a href= '|| AUTHENTICATE.LOGIN_URL || '>');
                            GUI.BTN(TXT => 'Login');
                            HTP.PRINT(' </a>');
                            HTP.PRINT('</div>
                         </div>
                    </div>');
    ELSE
        HTP.PRINT(' <div class="nav">
                        <a class="title">
                            <div class = "title1">ISBD</div>
                            <div class = "title2">Crociere</div>
                        </a>
                        <div class = "buttons">
                            <div class= "sx" >');
                                HTP.PRINT(' <a href= '||Costanti.macchina2||Costanti.radice||'GUI.HOMEPAGELOGIN>');
                                GUI.BTN(TXT => 'Homepage Operazioni');
                                HTP.PRINT(' </a>');
                                HTP.PRINT(' <a href= '|| authenticate.logout_url || '>');
                                GUI.BTN(TXT => 'Logout');
                                HTP.PRINT(' </a>');
                                GUI.BTN(TXT => 'Contatti');
                                
                                HTP.PRINT('</div> 
                            <div class= "dx ">
                                <div class="title">
                                    <div class = "title2">Benvenuto</div>
                                </div>
                            </div>
                         </div>');
                    HTP.PRINT(' </div>');
    END IF;   
END APRINAV;

-----------------------------------------------------------------------------------------
/* APRITENDINA: inserisce un bottone con tendina
   Parametri:   nome: nome del bottone,
                colore: in base al gruppo di appartenenza si deve specificare un colore
*/
---------------------------------------------------------------------------------------

PROCEDURE APRIBTNTENDINA(NOME VARCHAR2 DEFAULT 'DROPDOWN', COLORE varchar DEFAULT '') AS
BEGIN
    HTP.PRINT(' <li class="dropdown">
                <a class = "btng">' || nome || '</a>');
                IF (colore='verde') then
                    HTP.PRINT('<div class="dropdown-contentverde">');
                ELSIF (colore='arancio') then
                    HTP.PRINT('<div class="dropdown-contentarancio">');
                ELSE
                    HTP.PRINT('<div class="dropdown-contentblu">');
                END IF;
END APRIBTNTENDINA;


-----------------------------------------------------------------------------------------
/* AGGIUNGICAMPOTENDINA: aggiunge un campo a una tENDina precedentemente aperta
parametri : nome: etichetta del campo,
            url: collegamento ipertestuale a cui il campo reindirizzerà il browser.
*/
---------------------------------------------------------------------------------------

PROCEDURE AGGIUNGICAMPOTENDINA(NOME VARCHAR2 DEFAULT 'LINK',URL VARCHAR2 DEFAULT '') AS
BEGIN
    HTP.PRINT('<a href=' || url || '>' || NOME || '</a>');
END AGGIUNGICAMPOTENDINA;

-----------------------------------------------------------------------------------------
/* CHIUDITENDINA: chiude una tENDina precedente aperta
*/
---------------------------------------------------------------------------------------

PROCEDURE CHIUDIBTNTENDINA as
BEGIN
    HTP.PRINT('</div>');
END CHIUDIBTNTENDINA;


-----------------------------------------------------------------------------------------
/* APRIFORM e CHIUDIFORM: PERMOTTONO DI EPRIRE E CHIUDERE UNA DIV CON UN FORM ALL'INTERNO 
parametri : CLASSE: indica la classe di appartenenza del form .. nel css abbiamo stili diveri per form card , frm,
            METODO: get o post 
            AZIONE: indica la procedura a cui inviare gli input del form
*/
---------------------------------------------------------------------------------------

PROCEDURE APRIFORM(CLASSE VARCHAR2 DEFAULT 'FORM CARD', METODO VARCHAR2 DEFAULT '',AZIONE VARCHAR DEFAULT '', JS VARCHAR2 DEFAULT NULL) AS
BEGIN
    IF (JS IS NULL) THEN
        HTP.PRINT('<div>
                <form name="frm" class="'||CLASSE||'" method = "'||METODO||'" action ="'||Costanti.macchina2||Costanti.radice||AZIONE||'">');
    ELSE
        HTP.PRINT('<div>
                <form name="frm" class="'||CLASSE||'" method = "'||METODO||'" action ="'||Costanti.macchina2||Costanti.radice||AZIONE||'" onsubmit="'||JS||'">');
    END IF; 
END APRIFORM;

PROCEDURE CHIUDIFORM AS
BEGIN

    HTP.PRINT('
                    </form>
                </div>
                ');
                
END CHIUDIFORM;


PROCEDURE APRIFIELD (CLASSE VARCHAR2 DEFAULT 'FIELD',TESTO VARCHAR2 DEFAULT '', ALLINEAMENTO VARCHAR2 DEFAULT '') AS
BEGIN
    HTP.PRINT('<div class="'||CLASSE||'" align="'||ALLINEAMENTO||'">
                 <label>'||TESTO||'</label>');
END APRIFIELD;

PROCEDURE CHIUDIFIELD AS
BEGIN
    HTP.PRINT('</div>');
END CHIUDIFIELD;

PROCEDURE APRISELECTINPUT(NOME VARCHAR2 DEFAULT 'NAME', ID VARCHAR2 DEFAULT '',ONCHANGE VARCHAR2 DEFAULT '') AS
BEGIN

    HTP.PRINT(' <select class="input" name="'||NOME||'" id="'||ID||'" required onchange="'||onchange||'">
                    <option value="" > --- Seleziona </option>');
            
END APRISELECTINPUT;

PROCEDURE CHIUDISELECT AS
BEGIN
    HTP.PRINT('</select>');
END CHIUDISELECT;

PROCEDURE OPTION_SELECT(VALORE VARCHAR2 DEFAULT '',TESTO VARCHAR2 DEFAULT '') AS
BEGIN
    HTP.PRINT('<option value=' || VALORE || '>' || TESTO || '</option>');
END OPTION_SELECT;

-----------------------------------------------------------------------------------------
/* INPUT_FORM: serve a definire un elemento di input all' interno di un form, permettendo quindi l' inserimento dei dati da parte dell' utente.
parametri : CLASSE: definisce la classe dello stile dell'input.
            TIPO: Definisce il tipo di campo di input.
            NOME: 	Assegna un nome al campo di input.
            VALORE: Definisce un valore iniziale per il campo.
            PLACEHOLDER: Specifica un suggerimento che descrive il valore atteso per il campo.
            DISABLED: Disabilita il campo di input. Il campo non accetterà cambiamenti da parte dell' utente. e il suo valore non viene passato quando invii il form, come se il campo non esistesse.
            REQUIRED: Indica che il campo dev' essere compilato prima di inviare il form
*/
---------------------------------------------------------------------------------------
PROCEDURE INPUT_FORM(CLASSE VARCHAR2 DEFAULT 'INPUT',TIPO VARCHAR2 DEFAULT 'TEXT',ID VARCHAR2 DEFAULT '', NOME VARCHAR2 DEFAULT '',VALORE VARCHAR2 DEFAULT '', PLACEHOLDER VARCHAR2 DEFAULT '', REQUIRED VARCHAR2 DEFAULT '', DISABLED VARCHAR2 DEFAULT '') AS
BEGIN
        HTP.PRINT('<input  class="'||CLASSE||'" type="'||TIPO||'" id="'||ID||'" name="'||NOME||'" value="'||VALORE||'" placeholder="'||PLACEHOLDER||'"'||REQUIRED|| DISABLED||'>');
END INPUT_FORM;

PROCEDURE P(TESTO VARCHAR2 DEFAULT '',ID VARCHAR2 DEFAULT '') AS
BEGIN
        HTP.PRINT('<p id="'||ID||'">'||TESTO||'</p>');
END P;

PROCEDURE APRILABEL(CLASSE VARCHAR2 DEFAULT '',TESTO VARCHAR2 DEFAULT '') AS
BEGIN
    HTP.PRINT('<label class="'||CLASSE||'">'||TESTO);
END APRILABEL;

PROCEDURE CHIUDILABEL AS
BEGIN
    HTP.PRINT('</label>');
END CHIUDILABEL;




-----------------------------------------------------------------------------------------
/* APRIFORMCERCA: inserisce nella pagina un form per l'inserimento di informazioni relativi alla crociera che vogliamo ricercare
*/
---------------------------------------------------------------------------------------
PROCEDURE FORMCERCA as

    CURSOR C_NOMI_PORTI IS SELECT DISTINCT NOMEPORTO FROM PORTO;
    
BEGIN
    
        GUI.APRIFORM('FORM CARD','GET','GUI.VISUALIZZARISULTATIRICERCA');
        GUI.CARDHEADER('TROVA LA TUA CROCIERA',0);
        GUI.APRIFIELD(TESTO=>'Da quale porto vuoi partire?');
        GUI.APRISELECTINPUT('porto','porto');
        FOR NOME_PORTO IN C_NOMI_PORTI 
            LOOP
                GUI.OPTION_SELECT(NOME_PORTO.NOMEPORTO, NOME_PORTO.NOMEPORTO);
            END LOOP;
        GUI.CHIUDISELECT;
        GUI.CHIUDIFIELD;
        GUI.APRIFIELD(TESTO=> 'Quando?');
        GUI.INPUT_FORM('input','date','start','quando',to_char(sysdate, 'yyyy-MM-dd'));
        GUI.CHIUDIFIELD;
        GUI.APRIFIELD(ALLINEAMENTO =>'center');
        GUI.BTNSUBMIT(TXT =>'Cerca');
        GUI.BTNRESET(TXT =>'Cancella');
        GUI.CHIUDIFIELD;
        GUI.CHIUDIFORM;   
                    
END FORMCERCA;


-----------------------------------------------------------------------------------------
/* APRIFORMLOGIN: inserisce nella pagina un form per l'inserimento delle credenziali di accesso
*/
---------------------------------------------------------------------------------------

PROCEDURE FORMLOGIN as
BEGIN
        GUI.APRIFORM('FORM CARD',JS=>'return false;');
        GUI.CARDHEADER('Inserisci le tue credenziali',1);
        GUI.APRIFIELD(TESTO=> 'Username:');
        GUI.INPUT_FORM('input','text', 'uname', 'cf','', 'Inserisci il tuo Username');
        GUI.CHIUDIFIELD;
        GUI.APRIFIELD(TESTO=> 'Password:');
        GUI.INPUT_FORM('input','password', 'pwd', 'pwd','', 'Inserisci la tua password');
        GUI.CHIUDIFIELD;
        GUI.P(ID => 'output');
        GUI.APRIFIELD(ALLINEAMENTO => 'center');
        GUI.BTN(ID =>'login', TXT => 'Login'); 
        GUI.BTNRESET(TXT => 'Cancella');
        GUI.CHIUDIFIELD;
        GUI.CHIUDIFORM;

END FORMLOGIN;

-----------------------------------------------------------------------------------------
/* FORMGRUPPI: inserisce nella pagina un form contenente per ciascun gruppo un bottone tENDina 

*/
---------------------------------------------------------------------------------------


PROCEDURE FORMGRUPPI as
BEGIN
    GUI.APRIFORM('frm');
    GUI.HEADER('Scegli la tua operazione');
    GUI.APRILABEL('SM');
    GUI.APRIDIV;
    GUI.APRIBTNTENDINA('GRUPPO VERDE','verde');
                    GUI.AGGIUNGICAMPOTENDINA('Prenotazione Crociera', Costanti.macchina2 || Costanti.radice || 'GVERDE.CERCACROCIERE');
                    GUI.AGGIUNGICAMPOTENDINA('Prenotazione Visita', Costanti.macchina2 || Costanti.radice || 'GVERDE.MOSTRAPRENOTAZIONICLIENTE?TIPO=1'||'&'||'ELIMINA=0');
                    GUI.AGGIUNGICAMPOTENDINA('Cancella Prenotazione', Costanti.macchina2 || Costanti.radice || 'GVERDE.MOSTRAPRENOTAZIONICLIENTE'); 
                    GUI.AGGIUNGICAMPOTENDINA('Cancella Visita', Costanti.macchina2 || Costanti.radice || 'GVERDE.MOSTRAPRENOTAZIONICLIENTE?TIPO=1'||'&'||'ELIMINA=1');
                    GUI.AGGIUNGICAMPOTENDINA('Crociera con costo maggiore', Costanti.macchina2 || Costanti.radice || 'GVERDE.CROCIERACOSTOBASEMAGGIORE');
                    GUI.AGGIUNGICAMPOTENDINA('Percentuale recensioni positive per visita', Costanti.macchina2 || Costanti.radice || 'GVERDE.PERCENTUALEVOTAZIONE');
                    GUI.AGGIUNGICAMPOTENDINA('Numero di prenotazioni per crociera', Costanti.macchina2 || Costanti.radice || 'GVERDE.PRENOTAZIONIPERCROCIERA');
                    GUI.AGGIUNGICAMPOTENDINA('Clienti che non hanno prenotato visite', Costanti.macchina2 || Costanti.radice || 'GVERDE.CLIENTENOPRENOTAZIONEVISITE');
                    GUI.AGGIUNGICAMPOTENDINA('Recensisci visita', Costanti.macchina2 || Costanti.radice || 'GVERDE.RECENSISCIVISITA');
                    GUI.AGGIUNGICAMPOTENDINA('Mostra Recensioni', Costanti.macchina2 || Costanti.radice || 'GVERDE.MOSTRARECENSIONI');
                    GUI.AGGIUNGICAMPOTENDINA('Recensioni riguardanti una guida', Costanti.macchina2 || Costanti.radice || 'GVERDE.RECENSIONIGUIDA');
                    GUI.AGGIUNGICAMPOTENDINA('Voto Medio Visita', Costanti.macchina2 || Costanti.radice || 'GVERDE.VOTOVISITA');
                    GUI.AGGIUNGICAMPOTENDINA('Voto Medio tutte le visite', Costanti.macchina2 || Costanti.radice || 'GVERDE.VISUALIZZAVOTITUTTI');
                    GUI.AGGIUNGICAMPOTENDINA('Numero prenotazioni visita', Costanti.macchina2 || Costanti.radice || 'GVERDE.PRENOTAZIONIVISITA');
                    GUI.AGGIUNGICAMPOTENDINA('Numero prenotazioni tutte le visite', Costanti.macchina2 || Costanti.radice || 'GVERDE.VISUALIZZAPRENOTAZIONITUTTE');
                    GUI.AGGIUNGICAMPOTENDINA('Camere piu'' prenotate', Costanti.macchina2 || Costanti.radice || 'GVERDE.VISUALIZZARICHIESTECAMERE');
                    GUI.AGGIUNGICAMPOTENDINA('Numero prenotazioni tour', Costanti.macchina2 || Costanti.radice || 'GVERDE.NUMEROPRENOTAZIONICROCIERE');
                    GUI.AGGIUNGICAMPOTENDINA('Numero prenotazioni clienti', Costanti.macchina2 || Costanti.radice || 'GVERDE.NUMEROPRENOTAZIONICLIENTI');
                    GUI.AGGIUNGICAMPOTENDINA('Percentuale prenotazioni finalizzate', Costanti.macchina2 || Costanti.radice || 'GVERDE.PERCENTPRENOTAZIONIFINALI');
    GUI.CHIUDIBTNTENDINA;
    GUI.CHIUDIDIV;
    GUI.CHIUDILABEL;
    GUI.APRILABEL('SM');
    GUI.APRIDIV;
    GUI.APRIBTNTENDINA('GRUPPO ARANCIONE','arancio');
                    GUI.AGGIUNGICAMPOTENDINA('OPERAZIONI LUCA');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Form inserisci crociera', Costanti.macchina2 || Costanti.radice || 'ROSSO.FORMNUOVACROCIERA');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Form inserisci visita disponibile', Costanti.macchina2 || Costanti.radice || 'ROSSO.FORMNUOVAVISITADISPONIBILE');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Form costo medio', Costanti.macchina2 || Costanti.radice || 'ROSSO.FORMCOSTOMEDIOCROCIERE');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Form elimina visita', Costanti.macchina2 || Costanti.radice || 'ROSSO.VISITEDISPONIBILI?ELIMINA=1');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Crociere disponibili', Costanti.macchina2 || Costanti.radice || 'ROSSO.CROCIEREDISPONIBILI');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Visite disponibili', Costanti.macchina2 || Costanti.radice || 'ROSSO.VISITEDISPONIBILI');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Posti totali disponibili per ogni crociera', Costanti.macchina2 || Costanti.radice || 'ROSSO.POSTITOTALILIBERICROCIERE');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Informazioni itinerario', Costanti.macchina2 || Costanti.radice || 'ROSSO.ITINERARIONAVI');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Crociera piu costosa con notti', Costanti.macchina2 || Costanti.radice || 'ROSSO.CROCIERAPIUCOSTOSACONNOTTI');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Mese con piu visite', Costanti.macchina2 || Costanti.radice || 'ROSSO.MESECONPIUVISITE');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Nave col potenziale costo piu alto', Costanti.macchina2 || Costanti.radice || 'ROSSO.NAVEPIUCOSTOSA');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Crociera che effettua il numero massimo di visite', Costanti.macchina2 || Costanti.radice || 'ROSSO.CROCIERAMAXVISITE');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Crociere effettuate da una nave', Costanti.macchina2 || Costanti.radice || 'ROSSO.CROCIEREEFFETTUATEDANAVE');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('OPERAZIONI GABRIELE SOTTO');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Inserisci Navi', AUTHENTICATE.DOMINIO || Costanti.radice || 'ROSSO.inserisciNavi');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Quanti parlano una lingua', AUTHENTICATE.DOMINIO || Costanti.radice || 'ROSSO.quantiParlano');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Quanti tipologia camera', AUTHENTICATE.DOMINIO || Costanti.radice || 'ROSSO.tipologiaMigliore');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Quanti hanno prenotato un tour', AUTHENTICATE.DOMINIO || Costanti.radice || 'ROSSO.tourMigliori');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Navi', AUTHENTICATE.DOMINIO || Costanti.radice || 'ROSSO.navi');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Quante camere sono state prenotate piú di n volte', AUTHENTICATE.DOMINIO || Costanti.radice || 'ROSSO.quanteMultiple');htp.p('<br>');
                    GUI.AGGIUNGICAMPOTENDINA('Chi ha speso in media per le stanze piú della media', AUTHENTICATE.DOMINIO || Costanti.radice || 'ROSSO.quanteSopraMedia');htp.p('<br>');
    GUI.CHIUDIBTNTENDINA;
    GUI.CHIUDIDIV;
    GUI.CHIUDILABEL;
    GUI.APRILABEL('SM');
    GUI.APRIDIV;
    GUI.APRIBTNTENDINA('GRUPPO BLU','blu');
        GUI.AGGIUNGICAMPOTENDINA('Form per ricerca visite', Costanti.macchina2 || Costanti.radice || 'blu.apriformvisite');
        htp.p('<br>');
        GUI.AGGIUNGICAMPOTENDINA('Informazioni sul tour', Costanti.macchina2 || Costanti.radice || 'blu.infotour?id_tour=2');
        htp.p('<br>');
        GUI.AGGIUNGICAMPOTENDINA('Mostra le informazioni di una visita', Costanti.macchina2 || Costanti.radice || 'blu.infovisita?id_visita=2');
        htp.p('<br>');
        GUI.AGGIUNGICAMPOTENDINA('Mostra i porti di partenza e il numero di tour che partono da quei porti', Costanti.macchina2 || Costanti.radice || 'blu.portodipartenza');
        htp.p('<br>');
        GUI.AGGIUNGICAMPOTENDINA('Mostra le località raggiungibili dal porto selezionato', Costanti.macchina2 || Costanti.radice || 'blu.localitadistanza?in_porto=43.7714-11.2542');
        htp.p('<br>');
        GUI.AGGIUNGICAMPOTENDINA('Mostra la visita con le visite mediamente più costose', Costanti.macchina2 || Costanti.radice || 'blu.visitacostomax');
        htp.p('<br>');
        GUI.AGGIUNGICAMPOTENDINA('Mostra la località più lontana da un porto o le località più lontante di una distanza specificata', Costanti.macchina2 || Costanti.radice || 'blu.localitalontana?in_porto=43.7714-11.2542');
        htp.p('<br>');
        GUI.AGGIUNGICAMPOTENDINA('Mostra visite guidate effettuate in più lingue', Costanti.macchina2 || Costanti.radice || 'blu.visitaconpiulingue');
        htp.p('<br>');
        GUI.AGGIUNGICAMPOTENDINA('Mostra tutti le località con il numero di visite svolte', Costanti.macchina2 || Costanti.radice || 'blu.localitapiuvista');
        htp.p('<br>');
        GUI.AGGIUNGICAMPOTENDINA('Form per inserimento di un nuovo tour', Costanti.macchina2 || Costanti.radice || 'blu.formtour');
        htp.p('<br>');

    GUI.CHIUDIBTNTENDINA;
    GUI.CHIUDIDIV;
    GUI.CHIUDILABEL;
    GUI.CHIUDIFORM;
END FORMGRUPPI;


-----------------------------------------------------------------------------------------
/* VISUALIZZARISULTATIRICERCA: inserisce nella pagina una tabella riportante in ogni riga il risultato delle query ottenute tramite gli input del formcerca --> porto e data di partenza 
parametri : porto: porto di partenza,
            quando: data di partenza.
*/
---------------------------------------------------------------------------------------

PROCEDURE VISUALIZZARISULTATIRICERCA(porto varchar2 default null, quando varchar2 default null) as
data DATE;
BEGIN

    GUI.APRIPAGINASTANDARD('Crociere disponibili');
    GUI.APRITABELLA('Crociere disponibili', 1, tableId => 't00');
    GUI.APRIRIGATABELLA();
    GUI.CELLATABELLAHEADER('Nome Tour', 'align = center');
    GUI.CELLATABELLAHEADER('Data Crociera', 'align = center');
    GUI.CELLATABELLAHEADER('Costo Crociere', 'align = center');
    GUI.CHIUDIRIGATABELLA();
    
    IF (quando IS NOT NULL AND porto IS NOT NULL) THEN
        data := TO_DATE(quando, 'YYYY-MM-DD');
        FOR CROCIERA IN
        (
            SELECT
                IDCROCIERA,
                NOMETOUR,
                CR.DATACROCIERA,
                CR.COSTOCROCIERA
            FROM
                PORTO    P
                INNER JOIN INCLUDE I
                USING (POSGEOGRAFICA)
                INNER JOIN TOUR T
                USING (IDTOUR)
                INNER JOIN CROCIERA CR
                USING (IDTOUR)
            WHERE
                I.ORDINE='1'
                AND porto=P.NOMEPORTO
                AND CR.ISDISPONIBILE=1
                AND CR.DATACROCIERA >= data
            ORDER BY
                NOMETOUR
        )
        LOOP
            GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(CROCIERA.NOMETOUR);
                GUI.CELLATABELLA(CROCIERA.DATACROCIERA);
                GUI.CELLATABELLA(CROCIERA.COSTOCROCIERA);  
            GUI.CHIUDIRIGATABELLA();
        END LOOP;
    ELSIF (quando IS NULL AND porto IS NULL) THEN
        GUI.APRIRIGATABELLA();
            GUI.CELLATABELLA('quando e nome');
            GUI.CELLATABELLA('sono entrambi');
            GUI.CELLATABELLA('null');                   
        GUI.CHIUDIRIGATABELLA();
    ELSIF (quando IS NULL) THEN
        FOR CROCIERA IN
        (
            SELECT
                IDCROCIERA,
                NOMETOUR,
                CR.DATACROCIERA,
                CR.COSTOCROCIERA
            FROM
                PORTO    P
                INNER JOIN INCLUDE I
                USING (POSGEOGRAFICA)
                INNER JOIN TOUR T
                USING (IDTOUR)
                INNER JOIN CROCIERA CR
                USING (IDTOUR)
            WHERE
                I.ORDINE='1'
                AND porto=P.NOMEPORTO
                AND CR.ISDISPONIBILE=1
                AND CR.DATACROCIERA > sysdate
            ORDER BY
                NOMETOUR
        )
        LOOP
            GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(CROCIERA.NOMETOUR);
                GUI.CELLATABELLA(CROCIERA.DATACROCIERA);
                GUI.CELLATABELLA(CROCIERA.COSTOCROCIERA);
        
        
            GUI.CHIUDIRIGATABELLA();
        END LOOP;
    ELSE -- porto IS NULL
        data := TO_DATE(quando, 'MM-DD-YYYY');
        FOR CROCIERA IN
        (
            SELECT
                IDCROCIERA,
                NOMETOUR,
                CR.DATACROCIERA,
                CR.COSTOCROCIERA
            FROM
                PORTO    P
                INNER JOIN INCLUDE I
                USING (POSGEOGRAFICA)
                INNER JOIN TOUR T
                USING (IDTOUR)
                INNER JOIN CROCIERA CR
                USING (IDTOUR)
            WHERE
                CR.ISDISPONIBILE=1
                AND CR.DATACROCIERA >= data
            ORDER BY
                NOMETOUR
        )
        LOOP
            GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(CROCIERA.NOMETOUR);
                GUI.CELLATABELLA(CROCIERA.DATACROCIERA);
                GUI.CELLATABELLA(CROCIERA.COSTOCROCIERA);
            GUI.CHIUDIRIGATABELLA();
        END LOOP;
    
    END IF;
    GUI.CHIUDITABELLA();
    GUI.CHIUDIPAGINASTANDARD('Interfaccia');
    EXCEPTION WHEN NO_DATA_FOUND THEN
        GUI.CHIUDITABELLA();
        HTP.PRINT('NON SONO DIPONIBILI CROCIERE CON I DATI INSERITI');
        GUI.CHIUDIPAGINASTANDARD('Interfaccia');
        
END VISUALIZZARISULTATIRICERCA;

-------------------------------------------------------------------------------------------
/* 
Procedure per creare un bottone.
 BTN crea una bottone standard (quelli presenti nella nav bar).
 BTNG crea un bottone standard con stile diverso dal precedente.
 BTNRESET crea un bottone di tipo reset nel form.
 BTNSUBMIT crea un bottone di tipo submit nel form responsabile per l'invio dei dati in input.
 
PARAMETRI: ID:  Specifica un id univoco per un elemento
           NOME: Specifica un nome per il pulsante
           TXT: Specifica il testo da visualizzare sopra il pulsante
           VALORE: Indica il valore iniziale del pulsante.
           DISABLED: Indica che il pulsante dovrà essere disabilitato.
           ALERT: indica la presenza o meno di un messaggio di alert in seguito al click del bottone
           CONFERMA: indica la presenza o meno di un messaggio di conferma al passaggio della pagina a cui il bottone indirizza
           ONSUBMIT: indica l'azione da eseguire al click del bottone
*/ 
-------------------------------------------------------------------------------------------

PROCEDURE BTN(CLASSE VARCHAR2 DEFAULT 'BTN',id varchar2 default '',nome varchar2 default 'btn',VALORE VARCHAR2 DEFAULT '', TXT varchar2 default 'button standard', ONSUBMIT VARCHAR2 DEFAULT '',CONFERMA INT DEFAULT 0) as
BEGIN
    IF CONFERMA=1 THEN
        HTP.PRINT('<button class = "'||CLASSE||'" id = "'||id||'" name = '|| nome||' value="'||VALORE||'" '||ONSUBMIT||'>' || TXT || ' </button>');
    ELSE 
        HTP.PRINT('<button class = "'||CLASSE||'" id = "'||id||'" name = '|| nome||' value="'||VALORE||'" >' || TXT ||' </button>');
    END IF;
END BTN;

PROCEDURE BTNG(id varchar2 default '', nome varchar2 default 'btn', TXT varchar2 default 'button standard') as
BEGIN
    HTP.PRINT('<button id= ' || id ||' class = "btng" name = ' || nome ||'>' || TXT || '</button>');
END BTNG;

PROCEDURE BTNRESET(id varchar2 default '',nome varchar2 default 'reset', TXT varchar2 default 'Cancella dati immessi') as
BEGIN
    HTP.PRINT('<button id= ' || id ||' type = "reset" class = "cancella-button" name = ' ||nome||'>'|| TXT || '</button>');
END BTNRESET;

PROCEDURE BTNSUBMIT(nome varchar2 default 'submit', id varchar2 default '',TXT varchar2 default 'Invia',ALERT INTEGER DEFAULT 0,MESSAGGIO VARCHAR2 DEFAULT 'CIAO') as
BEGIN
    IF (ALERT = 0) THEN
        HTP.PRINT('<button align=center id= ' || id ||' type = "submit" class= "submit-button" >' || TXT || '</button>');
    
    ---CASO DEL FORM PRENOTA CROCIERE
    ELSIF (ALERT = 1) THEN

        HTP.PRINT('<button align=center id= ' || id ||' type = "submit" class= "submit-button" onclick=mostraMessaggio("'||MESSAGGIO||'")>' || TXT || '</button>');

    END IF;
END BTNSUBMIT;

-------------------------------------------------------------------------------------------
/*
PROCEDURA HEADER: crea l'header semplice di un form precedentemente aperto
TITOLO: titolo del form
*/
-------------------------------------------------------------------------------------------

PROCEDURE HEADER(TITOLO VARCHAR2 DEFAULT '') AS
BEGIN
    HTP.PRINT('<header>'||TITOLO||'</header>');
END HEADER;

-------------------------------------------------------------------------------------------
/*
PROCEDURA CARDHEADER: crea l'header del form con il logo della compagnia (o il logo del login) e il titolo dato in input
TITOLO: titolo del form
LOGO:  se logo=0 si ha il simbolo della nave se logo=1 si ha il simbolo del login
*/
-------------------------------------------------------------------------------------------

PROCEDURE CARDHEADER( TITOLO VARCHAR2 DEFAULT 'ISBD CROCIERE',LOGO INT DEFAULT 0) AS
BEGIN

HTP.PRINT('  <div class="card_header">
                    <?xml version="1.0" standalone="no"?>
                    <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 20010904//EN"
                     "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">');
                    IF (LOGO=0) THEN
                    HTP.PRINT('
                    <svg version="1.0" xmlns="http://www.w3.org/2000/svg"
                         width="130pt" height="130pt" viewBox="0 0 1300.000000 1300.000000"
                         preserveAspectRatio="xMidYMid meet">
                        <metadata>
                        Created by potrace 1.16, written by Peter Selinger 2001-2019
                        </metadata>
                        <g transform="translate(0.000000,1300.000000) scale(0.100000,-0.100000)"
                        fill="#000000" stroke="none">
                        <path d="M9630 8715 c0 -25 -4 -35 -16 -35 -8 0 -13 -3 -10 -8 2 -4 -2 -16
                        -10 -27 -13 -17 -16 -18 -24 -5 -6 9 -10 10 -10 3 0 -6 -2 -17 -5 -25 -2 -7 5
                        -24 16 -38 20 -24 21 -25 16 -2 -3 12 -1 20 3 17 5 -3 8 -18 8 -34 -1 -17 14
                        -50 39 -87 42 -62 109 -171 132 -216 8 -15 18 -25 22 -22 5 3 6 -2 3 -10 -5
                        -13 21 -76 32 -76 2 0 0 9 -6 19 -5 11 -10 23 -10 28 1 4 7 -3 14 -16 8 -14
                        12 -30 9 -36 -6 -16 63 -156 72 -147 5 4 5 -1 1 -12 -3 -10 -2 -24 4 -31 11
                        -13 25 -51 75 -192 17 -51 35 -89 39 -85 5 4 7 0 5 -8 -4 -21 11 -81 19 -76 4
                        2 7 -8 8 -22 0 -15 10 -63 23 -107 29 -106 67 -291 91 -446 17 -114 23 -191
                        34 -437 2 -45 6 -82 10 -82 12 0 44 39 38 46 -4 4 -2 5 3 2 10 -6 36 15 35 29
                        0 5 4 8 8 8 13 0 42 32 35 39 -10 10 -11 46 -1 40 5 -4 7 -12 4 -19 -2 -7 -2
                        -16 1 -19 10 -9 33 15 26 27 -3 5 -2 7 4 4 15 -9 53 39 41 51 -6 6 -1 9 14 8
                        12 0 23 5 23 12 0 6 3 12 8 12 14 0 44 35 38 45 -10 19 -7 42 5 42 9 0 10 -5
                        3 -18 -11 -21 4 -34 19 -16 6 6 11 15 11 20 1 4 3 7 6 7 15 0 41 36 33 46 -6
                        8 -1 11 14 10 14 -1 22 4 20 12 -1 7 11 20 28 30 16 11 27 22 23 26 -4 3 -7
                        15 -8 25 -1 14 5 18 29 17 37 -2 56 14 57 46 0 21 1 22 8 3 8 -20 8 -20 14 0
                        4 11 2 36 -3 55 -6 19 -10 48 -10 65 0 18 -3 25 -8 18 -4 -7 -8 18 -9 55 -2
                        87 -81 431 -96 415 -5 -4 -5 0 -2 8 3 9 0 29 -6 45 -7 16 -11 37 -10 47 1 9
                        -3 17 -8 17 -6 0 -11 12 -11 28 0 15 -5 34 -11 42 -8 11 -9 8 -4 -13 4 -20 2
                        -27 -5 -22 -7 4 -9 21 -6 44 4 23 1 46 -9 65 -8 15 -15 35 -15 42 0 8 -4 14
                        -10 14 -5 0 -7 6 -4 14 3 8 -4 33 -15 57 -12 23 -21 46 -21 50 0 4 -18 45 -39
                        91 -22 45 -43 95 -46 111 -5 17 -13 26 -23 25 -8 -2 -17 3 -20 11 -3 9 0 11 8
                        6 21 -13 2 32 -61 148 -32 59 -59 110 -59 113 0 2 -12 23 -27 47 -15 23 -32
                        52 -39 65 -11 22 -12 22 -17 2 -3 -11 -1 -18 3 -15 5 3 12 0 16 -6 4 -6 -1
                        -16 -10 -21 -22 -13 -20 -45 4 -51 11 -3 20 -1 20 4 0 5 -4 9 -9 9 -5 0 -7 9
                        -4 20 l6 21 14 -21 c8 -11 11 -25 8 -30 -4 -6 -1 -9 6 -8 7 2 15 -6 18 -17 3
                        -11 14 -32 24 -47 11 -16 16 -35 13 -46 -4 -11 -2 -30 3 -43 7 -17 10 -19 10
                        -6 1 9 4 17 9 17 19 0 28 -39 22 -97 -3 -35 -2 -63 2 -63 4 0 8 -9 8 -20 0
                        -11 7 -20 15 -20 10 0 12 6 8 18 -6 15 -5 15 10 4 9 -8 20 -11 25 -8 6 3 12
                        -4 15 -17 2 -12 7 -29 11 -37 5 -12 -1 -16 -24 -18 -16 -1 -30 2 -30 8 0 5
                        -18 10 -40 10 l-40 0 0 70 c0 63 -2 70 -20 70 -11 0 -20 5 -20 10 0 6 -13 10
                        -30 10 -26 0 -30 3 -30 29 0 31 -14 41 -60 41 -46 0 -60 -10 -60 -41 l0 -29
                        -70 0 -70 0 0 30 0 30 -80 0 c-72 0 -80 2 -80 19 0 12 -9 20 -28 24 -27 6 -52
                        48 -52 90 0 9 -6 17 -12 17 -9 0 -8 4 2 10 10 6 11 10 3 10 -9 0 -13 21 -13
                        70 0 56 -3 70 -15 70 -10 0 -15 -11 -15 -35z"/>
                        <path d="M6720 7997 l0 -637 -834 -2 -834 -3 -21 -25 c-19 -23 -20 -37 -21
                        -227 0 -199 0 -202 24 -230 l24 -28 1190 0 1190 0 26 24 26 24 0 214 0 213
                        -32 20 c-18 11 -46 20 -63 19 -16 0 -155 -1 -307 0 l-278 1 0 593 0 593 -45
                        44 -45 44 0 -637z m-1400 -897 l0 -131 -97 3 -98 3 -3 128 -3 127 101 0 100 0
                        0 -130z m340 0 l0 -130 -95 0 -95 0 0 130 0 130 95 0 95 0 0 -130z m342 18 c2
                        -62 1 -121 -1 -130 -3 -16 -16 -18 -97 -18 l-93 0 -3 126 c-2 69 -1 128 1 130
                        2 2 46 4 97 4 l93 0 3 -112z m348 -18 l0 -131 -97 3 -98 3 -3 113 c-2 63 -1
                        120 2 128 4 11 28 14 101 14 l95 0 0 -130z m340 0 l0 -130 -95 0 -95 0 0 130
                        0 130 95 0 95 0 0 -130z m340 0 l0 -130 -95 0 -95 0 0 130 0 130 95 0 95 0 0
                        -130z m348 3 l-3 -128 -95 0 -95 0 -2 115 c-2 63 -1 121 2 128 3 8 33 12 100
                        12 l96 0 -3 -127z"/>
                        <path d="M10720 6975 c-30 -31 -32 -40 -7 -36 5 1 6 -3 2 -9 -4 -6 -13 -5 -25
                        2 -17 11 -18 14 -5 28 13 15 13 17 -2 17 -24 0 -35 -18 -21 -34 13 -16 -9 -46
                        -28 -39 -7 3 -16 0 -20 -6 -4 -7 -3 -8 4 -4 7 4 12 3 12 -3 0 -5 -6 -11 -12
                        -14 -10 -3 -9 -8 2 -22 14 -17 13 -17 -15 1 -16 10 -26 14 -23 8 10 -15 -21
                        -57 -37 -51 -8 4 -12 -3 -11 -16 1 -12 8 -21 15 -19 7 1 10 -2 6 -8 -5 -8 -11
                        -8 -21 1 -11 9 -21 3 -49 -26 -29 -32 -33 -40 -23 -53 9 -10 3 -9 -17 4 -16
                        10 -26 13 -21 6 5 -8 -4 -23 -24 -42 -28 -27 -31 -32 -19 -48 12 -15 12 -16
                        -2 -4 -14 11 -22 7 -54 -23 -32 -31 -35 -38 -23 -53 12 -15 11 -16 -4 -4 -15
                        12 -22 9 -54 -25 -35 -36 -37 -42 -40 -118 -16 -344 -54 -587 -139 -894 -19
                        -71 -47 -159 -61 -197 -14 -38 -29 -80 -34 -94 -53 -157 -182 -420 -308 -630
                        -312 -516 -767 -963 -1287 -1265 -55 -32 -108 -65 -119 -74 -10 -9 -20 -15
                        -22 -14 -2 2 -50 -20 -106 -47 -156 -74 -274 -125 -363 -154 -44 -15 -89 -31
                        -100 -36 -71 -31 -406 -114 -550 -135 -210 -32 -240 -35 -345 -40 -87 -5 -156
                        -11 -225 -20 -5 -1 -15 3 -22 7 -6 5 -14 5 -16 1 -3 -5 -43 -6 -89 -2 -147 12
                        -343 21 -337 15 3 -3 61 -8 130 -12 87 -4 134 -11 159 -23 19 -10 40 -16 47
                        -14 17 6 26 -16 13 -32 -22 -26 5 -21 35 7 17 17 23 26 13 22 -11 -4 -18 -1
                        -18 6 0 6 10 11 23 10 12 -1 24 -1 27 0 25 9 42 5 50 -11 6 -10 16 -19 23 -19
                        7 0 6 4 -3 10 -8 5 -10 10 -4 10 5 0 15 -5 22 -12 9 -9 12 -9 12 0 0 10 3 10
                        14 0 17 -16 -2 -32 -20 -17 -8 7 -14 6 -19 -1 -7 -11 -5 -12 24 -14 11 0 23
                        -5 28 -10 5 -5 3 -6 -4 -2 -26 15 -12 -14 17 -35 24 -19 27 -25 17 -38 -10
                        -12 -9 -13 3 -6 22 14 39 15 47 3 3 -7 1 -8 -5 -4 -17 10 -15 -9 3 -24 8 -6
                        20 -8 26 -4 7 4 9 3 5 -4 -3 -6 1 -17 9 -25 8 -9 15 -21 15 -27 0 -6 5 -8 11
                        -5 7 5 5 13 -6 25 -13 15 -14 19 -1 29 9 8 16 8 20 2 4 -5 2 -12 -4 -16 -6 -4
                        -7 -12 -3 -18 4 -7 8 -19 8 -27 0 -11 11 -15 40 -15 l40 0 0 -40 0 -40 40 0
                        40 0 0 -40 0 -40 40 0 c40 0 40 0 38 -38 -3 -55 27 -72 99 -58 l53 10 -52 -5
                        c-30 -3 -53 -1 -53 5 0 5 30 8 68 7 37 -2 87 1 112 4 100 16 310 62 390 85
                        130 38 253 76 275 85 11 5 43 16 70 26 28 10 61 24 75 31 14 7 32 13 41 13 8
                        0 19 4 25 8 5 5 45 24 89 42 44 19 83 38 86 43 3 5 9 8 13 7 6 -1 128 53 156
                        70 8 5 47 26 85 46 84 44 245 143 352 216 96 65 87 59 153 110 31 24 85 65
                        120 93 36 27 81 64 100 81 19 17 62 55 95 84 33 30 80 73 105 97 l45 43 -175
                        177 -175 178 178 -175 177 -175 53 56 c195 207 338 387 489 614 125 189 189
                        305 182 330 -4 15 -3 16 4 6 11 -16 15 -10 89 143 177 359 297 730 371 1142
                        15 86 15 93 -1 118 -10 14 -21 25 -25 23 -4 -1 -7 1 -7 4 0 3 -6 13 -14 23
                        -11 13 -17 14 -30 4 -13 -10 -14 -10 -4 1 9 11 8 17 -4 30 -9 9 -20 16 -25 16
                        -4 0 -8 5 -9 10 0 6 -5 16 -11 23 -9 10 -14 10 -27 0 -14 -11 -14 -11 -4 3 11
                        13 9 19 -8 35 -12 10 -23 18 -25 17 -2 -2 -3 -1 -1 0 1 2 -4 11 -12 21 -11 13
                        -17 14 -30 4 -13 -10 -14 -10 -4 1 9 11 8 17 -4 30 -9 9 -21 16 -27 16 -6 0
                        -11 5 -11 10 0 6 -4 16 -9 23 -6 10 -11 11 -24 0 -14 -10 -15 -10 -5 1 9 11 8
                        17 -4 30 -9 9 -21 16 -27 16 -6 0 -11 5 -11 10 0 6 -4 16 -9 23 -6 10 -11 11
                        -24 0 -14 -10 -15 -10 -5 1 9 11 8 17 -4 30 -9 9 -21 16 -27 16 -6 0 -11 5
                        -11 10 0 19 -16 35 -27 29 -6 -4 -9 -3 -6 2 7 10 -17 35 -26 28 -3 -2 -4 -1
                        -1 3 3 3 0 12 -6 20 -6 7 -9 13 -5 13 3 0 38 -32 77 -71 62 -62 72 -69 87 -57
                        15 12 16 11 4 -4 -11 -14 -4 -26 64 -93 66 -66 78 -74 93 -63 14 11 14 11 3
                        -3 -10 -14 -7 -22 23 -54 31 -32 38 -35 53 -23 15 11 16 11 4 -3 -11 -14 -7
                        -22 24 -53 31 -31 39 -35 53 -24 14 11 14 11 3 -4 -11 -14 -9 -20 14 -43 14
                        -14 28 -24 30 -22 12 12 36 303 41 492 6 227 -11 590 -28 611 -5 6 -6 14 -2
                        17 3 4 4 7 2 7 -3 0 -20 -16 -39 -35z"/>
                        <path d="M4707 6749 c-40 -23 -47 -60 -47 -248 0 -99 4 -191 10 -205 22 -60
                        -74 -56 1595 -54 l1527 3 24 29 25 28 -3 204 c-3 196 -4 204 -26 226 l-23 23
                        -506 3 -506 3 -31 -28 -31 -28 24 28 24 27 -248 0 -249 0 30 -32 29 -33 -35
                        33 -36 32 -764 0 c-501 -1 -771 -4 -783 -11z m263 -239 c0 -66 0 -123 0 -127
                        0 -5 -43 -9 -95 -11 l-95 -3 0 131 0 130 95 0 95 0 0 -120z m350 -10 l0 -130
                        -100 0 -101 0 2 130 1 130 99 0 99 0 0 -130z m340 0 l0 -130 -95 0 -95 0 0
                        130 0 130 95 0 95 0 0 -130z m340 0 l0 -130 -95 0 -95 0 0 130 0 130 95 0 95
                        0 0 -130z m350 0 l0 -131 -97 3 -98 3 -3 114 c-1 63 0 121 2 128 4 9 31 13
                        101 13 l95 0 0 -130z m340 0 l0 -130 -95 0 -95 0 0 130 0 130 95 0 95 0 0
                        -130z m340 0 l0 -130 -95 0 -95 0 0 130 0 130 95 0 95 0 0 -130z m348 -2 l3
                        -128 -101 0 -100 0 0 123 c0 68 3 127 7 131 4 4 48 5 98 4 l90 -3 3 -127z
                        m342 2 l0 -130 -95 0 -95 0 0 130 0 130 95 0 95 0 0 -130z"/>
                        <path d="M4540 6149 c-148 -28 -275 -123 -340 -252 -41 -83 -51 -144 -48 -302
                        l3 -140 95 -12 c52 -6 196 -21 320 -33 954 -88 1747 -5 2500 260 96 34 181 63
                        189 66 11 3 8 11 -10 32 l-24 27 26 -22 c31 -28 40 -28 132 -4 192 51 536 85
                        800 80 l167 -4 0 57 c0 100 -61 193 -155 235 -38 17 -130 18 -1825 19 -982 1
                        -1805 -2 -1830 -7z m110 -231 c108 -55 130 -190 46 -274 -44 -44 -102 -61
                        -158 -45 -54 15 -69 26 -102 75 -54 80 -24 197 63 243 55 29 95 29 151 1z
                        m539 -13 c48 -33 71 -78 71 -139 0 -60 -25 -110 -69 -139 -48 -32 -82 -39
                        -132 -28 -54 12 -88 38 -116 87 -89 154 99 321 246 219z m491 13 c105 -53 129
                        -182 52 -269 -27 -30 -132 -74 -142 -59 -3 4 -18 10 -34 14 -158 39 -156 278
                        3 326 45 14 75 11 121 -12z m514 2 c57 -27 96 -89 96 -152 0 -183 -237 -240
                        -320 -77 -25 49 -25 99 0 149 45 88 139 122 224 80z"/>
                        <path d="M7850 5753 c-170 -16 -252 -28 -360 -49 -69 -14 -126 -29 -128 -34
                        -2 -5 -9 -7 -15 -4 -7 2 -57 -11 -112 -30 -55 -19 -166 -57 -247 -84 -261 -89
                        -605 -169 -913 -211 -278 -38 -421 -46 -820 -46 -429 0 -556 8 -1080 70 -176
                        20 -191 20 -220 -10 -48 -47 -41 -65 153 -354 97 -146 186 -284 197 -306 11
                        -22 58 -78 105 -125 68 -69 102 -94 170 -127 160 -78 73 -74 1635 -71 l1390 3
                        80 28 c100 35 195 86 260 140 47 39 77 66 220 198 33 31 164 149 290 264 127
                        114 277 251 335 305 58 53 134 123 170 155 108 98 111 102 108 148 -5 64 -27
                        74 -218 98 -304 37 -490 49 -730 47 -129 -1 -251 -3 -270 -5z"/>
                        <path d="M6495 2730 c-32 -34 -30 -50 3 -20 31 29 40 25 12 -5 -13 -14 -30
                        -23 -38 -20 -8 3 -24 -5 -36 -19 -22 -22 -22 -24 -4 -35 10 -6 43 -11 73 -11
                        48 0 55 -2 55 -20 0 -11 5 -20 10 -20 6 0 10 -9 10 -20 0 -13 7 -20 20 -20 16
                        0 20 7 20 30 0 17 5 30 13 30 8 0 7 4 -3 10 -13 8 -12 10 3 10 15 0 12 7 -15
                        40 -29 35 -59 56 -43 30 3 -5 1 -10 -5 -10 -7 0 -10 7 -6 15 3 8 -5 26 -18 40
                        l-23 24 -28 -29z"/>
                        </g>
                    </svg>');
                ELSE
                    HTP.PRINT('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
                                  <path fill="none" d="M0 0h24v24H0z"></path>
                                  <path fill="currentColor" d="M4 15h2v5h12V4H6v5H4V3a1 1 0 0 1 1-1h14a1 1 0 0 1 1 1v18a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1v-6zm6-4V8l5 4-5 4v-3H2v-2h8z"></path>
                                </svg>');
                END IF;
                HTP.PRINT('
                             <h1 class="form_heading"> ' || Titolo ||' </h1>
                </div>');
END CARDHEADER;



PROCEDURE CHIUDIDIV AS
BEGIN
    HTP.PRINT('</div>');
END CHIUDIDIV;

PROCEDURE APRIDIV(CLASSE VARCHAR2 DEFAULT '') AS
BEGIN
    HTP.PRINT('<div class='||CLASSE||'>');
END APRIDIV;

PROCEDURE MESSIMPORTANTE(TESTO VARCHAR2 DEFAULT '',LINKTO VARCHAR2 DEFAULT '') AS
BEGIN
    IF (LINKTO='') THEN
        HTP.PRINT('<div class="mess_importante">'||TESTO||'</div>');
    ELSE 
        HTP.PRINT('<div class="mess_importante"><a  href= ' || Costanti.macchina2 || Costanti.radice || LINKTO ||'>'||TESTO||'</a></div>');
    END IF;
END MESSIMPORTANTE;

PROCEDURE APRICARD(INTESTAZIONE VARCHAR2 DEFAULT '',CLASSEHEADER varchar2 DEFAULT 'card1-header') AS
BEGIN
    HTP.PRINT('<div class="card1">
                <div class="'||CLASSEHEADER||' title3">'||INTESTAZIONE||'</div>
                ');
END APRICARD;

PROCEDURE CORPOCARD AS
BEGIN
     HTP.PRINT(' <div class="card1-body">
                    <blockquote class="blockquote1 mb-0">');

END CORPOCARD;

PROCEDURE CHIUDICARD(FOOTER VARCHAR2 DEFAULT '') AS
BEGIN
    HTP.PRINT(' <footer class="blockquote1-footer">'||FOOTER||'</footer>
                </blockquote>
                </div>
                </div>');
END CHIUDICARD;

PROCEDURE ESITOPERAZIONE(ESITO varchar2, MESSAGGIO varchar2 DEFAULT '',BTN VARCHAR2 DEFAULT 'NO',LINKTO VARCHAR2 DEFAULT '',TESTOBTN VARCHAR2 DEFAULT '') AS
    BEGIN
        IF (ESITO='SUCCESSO') THEN
            IF BTN='NO' THEN
                GUI.APRICARD('OPERAZIONE ESEGUITA CON SUCCESSO');
                GUI.CORPOCARD;
                    GUI.P(MESSAGGIO);
                GUI.CHIUDICARD;
            ELSE
                GUI.APRICARD('OPERAZIONE ESEGUITA CON SUCCESSO');
                GUI.CORPOCARD;
                    GUI.P(MESSAGGIO);
                    HTP.PRINT(' <a href= '||Costanti.macchina2 || Costanti.radice || LINKTO||'>');
                            GUI.BTN(TXT => TESTOBTN);
                            HTP.PRINT(' </a>');
                GUI.CHIUDICARD;
            END IF;
        ELSE
            GUI.APRICARD('OPERAZIONE FALLITA','card1-REDheader');
            GUI.CORPOCARD;
                GUI.P(MESSAGGIO);
            GUI.CHIUDICARD;
        END IF; 
    END ESITOPERAZIONE;


PROCEDURE APRITABELLA(titolo VARCHAR2 default '', dimTitolo int default 1, attributi varchar2 default '', tableId VARCHAR2 default 't00') as
BEGIN
    HTP.PRINT('<h' || dimTitolo || ' align="center"> <div class = "card1-header"> '|| titolo||'</div> </h' || dimTitolo || '>');
    HTP.PRINT('<table align=center id="' || tableId || '">');
END APRITABELLA;

PROCEDURE CHIUDITABELLA as
BEGIN
    HTP.PRINT('</table>');
END CHIUDITABELLA;

PROCEDURE APRIRIGATABELLA(attributi VARCHAR2 default '') as
BEGIN
    HTP.PRINT('<tr '||attributi||'>');
END APRIRIGATABELLA;

PROCEDURE CHIUDIRIGATABELLA as
BEGIN
    HTP.PRINT('</tr>');
END CHIUDIRIGATABELLA;

PROCEDURE CELLATABELLA(val varchar2 default '', attributi varchar2 default '') as
BEGIN
    HTP.PRINT('<td ' || attributi || '>' || val || '</td>');
END CELLATABELLA;

PROCEDURE CELLATABELLAHEADER(val varchar2 default '', scopo varchar default 'col', attributi varchar2 default '') as
BEGIN
    HTP.PRINT('<th ' || attributi || ' scope= "'|| scopo ||' ">' || val || '</th>');
END CELLATABELLAHEADER;


-------------------------------------------------------------------------------------------
/*
CELLATABELLALINK: crea la cella di una tabella precedentemente aperta con testo avente un collegamento ipertestuale
CELLATABELLABOTTONE: crea un bottone con collegamento ipertestuale all'interno di una cella.

PARAMETRI: TXT: testo visualizzato all'interno del bottone
           ATTRIBUTI: eventuali caratteristiche che si vuole aggiungere alla cella
           LINKTO: link a cui si viene reindirizzati.

*/
-------------------------------------------------------------------------------------------

PROCEDURE CELLATABELLALINK(TXT VARCHAR2 DEFAULT '', ATTRIBUTI VARCHAR2 DEFAULT '', LINKTO VARCHAR2 DEFAULT '') AS
begin
                htp.print(' <td ' || ATTRIBUTI || '> <a href="'|| LINKTO || '"> '||TXT||' </a> </td> ');
end CELLATABELLALINK; 

PROCEDURE CELLATABELLABTN(TXT VARCHAR2 DEFAULT '', ATTRIBUTI VARCHAR2 DEFAULT '',LINKTO VARCHAR2 DEFAULT '',ONSUBMIT VARCHAR2 DEFAULT '', CONFERMA INTEGER DEFAULT 0) AS 

begin
                HTP.PRINT(' <td ' ||  ATTRIBUTI || '>'); 
                    IF CONFERMA = 1 THEN
                    GUI.BTN(TXT => TXT, ONSUBMIT=>ONSUBMIT, CONFERMA=>1);
                    ELSE
                        HTP.PRINT('<a href="'||LINKTO||'">');
                        GUI.BTN(TXT=>TXT);
                        HTP.PRINT('</a>');
                     END IF;  
                HTP.PRINT('</td> ');
end CELLATABELLABTN;

END;