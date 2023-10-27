CREATE OR REPLACE package body GVERDE as

-------Author: Fabiana Chericoni--------------

---------------------------------------------------------------------------------------
/*
CERCA CROCIERE: APRE UNA PAGINA STANDARD E VI INSERISCE IL FORM PER LA RICERCA DELLE CROCIERE DISPONIBILI DATO IL PORTO E LA DATA DI PARTENZA.
*/
--------------------------------------------------------------------------------------
PROCEDURE CERCACROCIERE IS

CURSOR C_NOMI_PORTI IS SELECT DISTINCT NOMEPORTO FROM PORTO;

BEGIN
        GUI.APRIPAGINASTANDARD('Cerca crociere');
        GUI.APRIFORM('FORM CARD','GET','GVERDE.VISUALIZZACROCIERE');
        GUI.CARDHEADER('PRENOTA LA TUA CROCIERA',0);
        GUI.APRIFIELD(TESTO=>'Da quale porto vuoi partire?');
        GUI.APRISELECTINPUT('porto','porto');
        FOR NOME_PORTO IN C_NOMI_PORTI 
            LOOP
                GUI.OPTION_SELECT(NOME_PORTO.NOMEPORTO, NOME_PORTO.NOMEPORTO);
            END LOOP;
        GUI.CHIUDISELECT;
        GUI.CHIUDIFIELD;
        GUI.APRIFIELD(TESTO=>'Quando?');
        GUI.INPUT_FORM('input','date','start','datapartenza',to_char(sysdate, 'yyyy-MM-dd'));
        GUI.CHIUDIFIELD;
        GUI.APRIFIELD(ALLINEAMENTO =>'center');
        GUI.BTNSUBMIT(TXT =>'Cerca');
        GUI.BTNRESET(TXT =>'Cancella');
        GUI.CHIUDIFIELD;
        GUI.CHIUDIFORM;  
        GUI.CHIUDIPAGINASTANDARD('Verde');
        
end CERCACROCIERE;


---------------------------------------------------------------------------------------
/*
VISUALIZZA CROCIERE: APRE UNA PAGINA STANDARD E VI INSERISCE LA TABELLA CON LE CROCIERE DISPONIBILI DATO IL PORTO E LA DATA DI PARTENZA.
*/
--------------------------------------------------------------------------------------
PROCEDURE VISUALIZZACROCIERE(DATAPARTENZA VARCHAR2 DEFAULT NULL, PORTO PORTO.NOMEPORTO%TYPE) is
    data DATE;
begin
            GUI.APRIPAGINASTANDARD('Crociere disponibili');
            GUI.APRITABELLA('Crociere disponibili', 1, tableId => 't01');
            GUI.APRIRIGATABELLA();
                GUI.CELLATABELLAHEADER('Nome Tour', 'align = center');
                GUI.CELLATABELLAHEADER('Data Crociera', 'align = center');
                GUI.CELLATABELLAHEADER('Costo Crociere', 'align = center');
            GUI.CHIUDIRIGATABELLA();

            IF (DATAPARTENZA IS NOT NULL AND porto IS NOT NULL)
            THEN
                data := TO_DATE(DATAPARTENZA, 'YYYY-MM-DD');
                FOR CROCIERA IN
                (
                    SELECT
                        IDTOUR,
                        IDCROCIERA,
                        NOMETOUR,
                        CR.DATACROCIERA,
                        CR.COSTOCROCIERA,
                        CR.IDNAVE
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
                        GUI.CELLATABELLALINK(CROCIERA.NOMETOUR,LINKTO => Costanti.macchina2 || Costanti.radice || 'BLU.INFOTOUR?id_tour=' || CROCIERA.IDTOUR);
                        GUI.CELLATABELLA(CROCIERA.DATACROCIERA);
                        GUI.CELLATABELLA(CROCIERA.COSTOCROCIERA);
                        GUI.CELLATABELLABTN(TXT =>'Prenota',LINKTO => Costanti.macchina2 || Costanti.radice || 'GVERDE.APRIPAGINAPRENOTAZIONI?Idcr='|| crociera.idcrociera ||'&'|| 'IdNave='|| CROCIERA.IDNAVE||'&'||'Ntour='||CROCIERA.NOMETOUR||'&'||'DataC='|| CROCIERA.DATACROCIERA);
                    GUI.CHIUDIRIGATABELLA();
                END LOOP;
            ELSIF (DATAPARTENZA IS NULL AND porto IS NULL)
            THEN
                GUI.APRICARD('Errore');
                GUI.CORPOCARD();
                GUI.P('Selezionare almeno una data o un porto');
                GUI.CHIUDICARD();
            ELSIF (DATAPARTENZA IS NULL)
            THEN
                FOR CROCIERA IN
                (
                    SELECT
                        IDTOUR,
                        IDCROCIERA,
                        NOMETOUR,
                        CR.DATACROCIERA,
                        CR.COSTOCROCIERA,
                        CR.IDNAVE
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
                        GUI.CELLATABELLALINK(CROCIERA.NOMETOUR,LINKTO => Costanti.macchina2 || Costanti.radice || 'BLU.INFOTOUR?id_tour=' || CROCIERA.IDTOUR);
                        GUI.CELLATABELLA(CROCIERA.DATACROCIERA);
                        GUI.CELLATABELLA(CROCIERA.COSTOCROCIERA);
                        GUI.CELLATABELLABTN(TXT =>'Prenota',LINKTO=> Costanti.macchina2 || Costanti.radice || 'GVERDE.APRIPAGINAPRENOTAZIONI?Idcr='|| crociera.idcrociera || '&'||'IdNave= '|| CROCIERA.IDNAVE|| '&'||'Ntour='||CROCIERA.NOMETOUR||'&'||'DataC='|| CROCIERA.DATACROCIERA);

                    GUI.CHIUDIRIGATABELLA();
                END LOOP;
            ELSE -- porto IS NULL
                data := TO_DATE(DATAPARTENZA, 'MM-DD-YYYY');
                FOR CROCIERA IN
                (
                    SELECT
                        IDTOUR,
                        IDCROCIERA,
                        NOMETOUR,
                        CR.DATACROCIERA,
                        CR.COSTOCROCIERA,
                        CR.IDNAVE
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
                        GUI.CELLATABELLALINK(CROCIERA.NOMETOUR,LINKTO => Costanti.macchina2 || Costanti.radice || 'BLU.INFOTOUR?id_tour=' || CROCIERA.IDTOUR);
                        GUI.CELLATABELLA(CROCIERA.DATACROCIERA);
                        GUI.CELLATABELLA(CROCIERA.COSTOCROCIERA);
                        GUI.CELLATABELLABTN(TXT=>'Prenota',LINKTO => Costanti.macchina2 || Costanti.radice || 'GVERDE.APRIPAGINAPRENOTAZIONI?Idcr='|| crociera.idcrociera ||'&'||'IdNave='||CROCIERA.IDNAVE||'&'||'Ntour='||CROCIERA.NOMETOUR||'&'||'DataC='||CROCIERA.DATACROCIERA);


                    GUI.CHIUDIRIGATABELLA();
                END LOOP;
            END IF;
            gui.chiuditabella();
        GUI.CHIUDIPAGINASTANDARD('Verde');
end VISUALIZZACROCIERE;


---------------------------------------------------------------------------------------
/*
APRIPAGINAPRENOTAZIONI: APRE UNA PAGINA STANDARD E VI INSERISCE IL FORM PER COMPLETARE LA PRENOTAZIONE CON LA SCELTA DELLE CAMERE
PARAMETRI: IDC: IDCROCIERA SELEZIONATA
           IDNAVE: IDNAVE SELEZIONATA
           NTOUR: NOME DEL TOUR CHE SI INTENDE PRENOTARE
           DATAC: DATA DI PARTENZA CROCIERA 
           
*/
--------------------------------------------------------------------------------------

PROCEDURE APRIPAGINAPRENOTAZIONI(IDCR CROCIERA.IDCROCIERA%TYPE,IDNAVE NAVE.IDNAVE%TYPE, NTOUR TOUR.NOMETOUR%TYPE, DATAC varchar2 default null) IS
    CONTATORE NUMBER(2):= 0;
    SINGOLE TIPOCAMERA.TIPOLOGIA%TYPE;
    DOPPIE TIPOCAMERA.TIPOLOGIA%TYPE;
    TRIPLE TIPOCAMERA.TIPOLOGIA%TYPE;
    TOTALEDISPONIBILE TIPOCAMERA.TIPOLOGIA%TYPE;
    BEGIN
            GUI.APRIPAGINASTANDARD;
            GUI.APRIFORM('form card','get','GVERDE.PAGAMENTO');
            GUI.CARDHEADER('Prenotazione Crociera');
            GUI.APRIFIELD(TESTO=>'Tour');
            GUI.INPUT_FORM('INPUT','TEXT','START','Ntour',NTOUR,'','disabled');
            GUI.CHIUDIFIELD;
            GUI.APRIFIELD(TESTO=>'Data di partenza');
            GUI.INPUT_FORM('INPUT','TEXT','START','DataC', DATAC,'','disabled');
            GUI.CHIUDIFIELD;
            GUI.INPUT_FORM('input','hidden','IdNave','IdNave', IDNAVE);
            GUI.INPUT_FORM('input','hidden','Idcr','Idcr', IDCR);
            GUI.APRIFIELD(TESTO=>'PERSONE');
            GUI.APRISELECTINPUT('persone','persone');
            LOOP
                CONTATORE:=CONTATORE+1;
                GUI.OPTION_SELECT(CONTATORE, CONTATORE);
                EXIT WHEN CONTATORE >= 10; 
            END LOOP;
            GUI.CHIUDISELECT;
            GUI.CHIUDIFIELD;
                            
            SELECT NUMEROPOSTILIBERI 
            INTO SINGOLE
            FROM DISPONIBILITACAMERE
            WHERE IDCROCIERA=IDCR and TIPOLOGIA='Singola'; 
            
            IF (SINGOLE=0) THEN 
                
                GUI.APRIFIELD(CLASSE=>'col-md-4 mb-3',TESTO=>'CAMERA SINGOLA');
                GUI.INPUT_FORM(CLASSE=>'input', NOME=>'singola', ID=>'singola', placeholder=>'Terminata disponibilità Singole',disabled=>'disabled');
                GUI.INPUT_FORM(CLASSE=>'input', NOME=>'singola', ID=>'singola', TIPO=>'hidden', VALORE=>0);

                GUI.CHIUDIFIELD;
                
            ELSE
                GUI.APRIFIELD(CLASSE=>'col-md-4 mb-3',TESTO=>'CAMERA SINGOLA');
                GUI.INPUT_FORM(CLASSE=>'input', NOME=>'singola', ID=>'singola', placeholder=>'Disponibilità Max Singole:'||SINGOLE);
                GUI.CHIUDIFIELD;     
                          
            END IF;
                            
            SELECT NUMEROPOSTILIBERI 
            INTO DOPPIE
            FROM DISPONIBILITACAMERE
            WHERE IDCROCIERA=IDCR and TIPOLOGIA='Doppia'; 
            
            IF (DOPPIE=0) THEN
                            
                GUI.APRIFIELD(CLASSE=>'col-md-4 mb-3',TESTO=>'CAMERA DOPPIA');
                GUI.INPUT_FORM(CLASSE=>'input', NOME=>'doppia', ID=>'doppia', placeholder=>'Terminata disponibilità Doppie',disabled=>'disabled');
                GUI.INPUT_FORM(CLASSE=>'input', NOME=>'doppia', ID=>'doppia', TIPO=>'hidden', VALORE=>0);
                GUI.CHIUDIFIELD;
                
            ELSE
                GUI.APRIFIELD(CLASSE=>'col-md-4 mb-3',TESTO=>'CAMERA DOPPIA');
                GUI.INPUT_FORM(CLASSE=>'input', NOME=>'doppia', ID=>'doppia', placeholder=>'Disponibilità Max Doppie:'||DOPPIE);
                GUI.CHIUDIFIELD;     
                          
            END IF;
                    
                            
                            
            SELECT NUMEROPOSTILIBERI
            INTO TRIPLE
            FROM DISPONIBILITACAMERE
            WHERE IDCROCIERA=IDCR and TIPOLOGIA='Tripla'; 
            
            TOTALEDISPONIBILE:=SINGOLE+DOPPIE+TRIPLE;
            IF (TRIPLE=0) THEN
                            
                GUI.APRIFIELD(CLASSE=>'col-md-4 mb-3',TESTO=>'CAMERA TRIPLA');
                GUI.INPUT_FORM(CLASSE=>'input', NOME=>'tripla', ID=>'tripla', placeholder=>'Terminata disponibilità Triple',disabled=>'disabled');
                GUI.INPUT_FORM(CLASSE=>'input', NOME=>'tripla', ID=>'tripla', TIPO=>'hidden', VALORE=>0);

                GUI.CHIUDIFIELD;
                
            ELSE
            
                GUI.APRIFIELD(CLASSE=>'col-md-4 mb-3',TESTO=>'CAMERA TRIPLA');
                GUI.INPUT_FORM(CLASSE=>'input', NOME=>'tripla', ID=>'tripla', placeholder=>'Disponibilità Max Triple:'||TRIPLE);
                GUI.CHIUDIFIELD; 

                          
            END IF;         
                        
            IF (TOTALEDISPONIBILE=0) THEN
            
                GUI.MESSIMPORTANTE('CROCIERA AL COMPLETO');
                GUI.MESSIMPORTANTE('Effetua una nuova ricerca','GVERDE.CERCACROCIERE');
                GUI.CHIUDIFORM;
                            
            ELSE
            
                GUI.APRIFIELD(ALLINEAMENTO =>'center');
                GUI.BTNSUBMIT(TXT =>'Prenota');
                GUI.BTNRESET(TXT =>'Cancella');
                GUI.CHIUDIFIELD;
                GUI.CHIUDIFORM;
            END IF;  
            
            GUI.CHIUDIPAGINASTANDARD('VERDE');
            
            --STIAMO SUPPONENDO CHE ESISTONO ALMENO DUE TIPOLOGIE DI CAMERA PER OGNI CROCIERA: SINGOLO E DOPPIE
            --L'UNICO CASO DI TIPOLOGIA NULL è LA TRIPLA PER ALCUNE CROCIERE
            ----- esempio idcr=8
            EXCEPTION WHEN NO_DATA_FOUND THEN
                TRIPLE:=-1;
                GUI.INPUT_FORM(CLASSE=>'input', NOME=>'tripla"', ID=>'tripla', TIPO=>'hidden', VALORE=>TRIPLE);
         
                TOTALEDISPONIBILE := SINGOLE+DOPPIE;
                
                IF (TOTALEDISPONIBILE=0) THEN
                
                    GUI.MESSIMPORTANTE('CROCIERA AL COMPLETO');
                    GUI.MESSIMPORTANTE('Effetua una nuova ricerca','GVERDE.CERCACROCIERE');
                    GUI.CHIUDIFORM;
        
                 ELSE
                 
                    GUI.APRIFIELD(ALLINEAMENTO =>'center');
                    GUI.BTNSUBMIT(TXT =>'Prenota', ALERT => 1);
                    GUI.BTNRESET(TXT =>'Cancella');
                    GUI.CHIUDIFIELD;
                    GUI.CHIUDIFORM;
                    
                END IF;
        
                GUI.CHIUDIPAGINASTANDARD('VERDE');

        
end APRIPAGINAPRENOTAZIONI;

        
---------------------------------------------------------------------------------------
/*
PAGAMENTO:  PAGINA STANDARD CON UN FORM RELATIVO AL RIEPILOGO DEL TOUR SELEZIONATO E DEL PAGAMENTO .. È POSSIBILE PAGARE L'INTERO COSTO O UN ACCONTO DEL 30%.
PARAMETRI: IDCR: IDCROCIERA SELEZIONATA
           IDNAVE: IDNAVE SELEZIONATA
           PERSONE: INDICA IL NUMERO DI PERSONE SELEZIONATE
           SINGOLA : NUMEO DI CAMERE SINGOLE SELEZIONATE
           DOPPIA: NUMERO DI CAMERE DOPPIE SELEZIONATE
           TRIPLE: NUMERO DI CAMERE TRIPLE SELEZIONATE
           
*/
--------------------------------------------------------------------------------------

PROCEDURE PAGAMENTO(IDNAVE NAVE.IDNAVE%TYPE,IDCR CROCIERA.IDCROCIERA%TYPE, PERSONE INT DEFAULT 0, SINGOLA TIPOCAMERA.TIPOLOGIA%TYPE, DOPPIA TIPOCAMERA.TIPOLOGIA%TYPE, TRIPLA TIPOCAMERA.TIPOLOGIA%TYPE) IS
    TYPE COSTICAMERA IS VARRAY(3) OF NUMBER;
    COSTI COSTICAMERA;
    COSTOBASE PRENOTAZIONE.COSTOBASE%TYPE;
    COSTOTOTALE PRENOTAZIONE.COSTOBASE%TYPE;
    NOMETOUR TOUR.NOMETOUR%TYPE;
    NUMERONOTTI TOUR.NUMERONOTTI%TYPE;
    NUMEROTAPPE TOUR.NUMEROTAPPE%TYPE;
    MSG VARCHAR2(1000) DEFAULT 'Attenzione il numero di posti camera supera il numero di persone per cui si sta prenotando';

    
    BEGIN
        
        IF PERSONE < SINGOLA+2*DOPPIA+3*TRIPLA THEN
            GUI.APRIPAGINASTANDARD(LOAD=>'onload',MESSAGGIO=>MSG);
        ELSE
            GUI.APRIPAGINASTANDARD;
        END IF;
        SELECT COSTOCROCIERA
        INTO COSTOBASE
        FROM CROCIERA 
        WHERE IDCROCIERA=IDCR;
        
        COSTOBASE:=PERSONE*COSTOBASE;
        
        SELECT NOMETOUR,NUMERONOTTI,NUMEROTAPPE
        INTO NomeTour, NumeroNotti, NumeroTappe
        FROM
            CROCIERA  C
            INNER JOIN Tour T
            USING (IDTOUR)  
        WHERE C.IDCROCIERA=IDCR;
     
        
        SELECT COSTO
        bulk collect INTO COSTI
        FROM
            DISPONIBILITACAMERE  DC
            INNER JOIN TipoCamera TC
            USING (TIPOLOGIA)  
        WHERE DC.IDCROCIERA=IDCR
        ORDER BY TIPOLOGIA;
        
        GUI.APRIFORM('form card','get','GVERDE.INSERIMENTOPRENOTAZIONE');
        GUI.CARDHEADER('RIEPILOGO E PAGAMENTO');
        GUI.INPUT_FORM(CLASSE=>'input', NOME=>'IDCROCIERA', TIPO=>'hidden', VALORE=>IDCR);
        GUI.INPUT_FORM(CLASSE=>'input', NOME=>'COSTOBASE', TIPO=>'hidden', VALORE=>COSTOBASE);
        GUI.INPUT_FORM(CLASSE=>'input', NOME=>'QUANTITASALDATA', TIPO=>'hidden', VALORE=>COSTOBASE);
        GUI.INPUT_FORM(CLASSE=>'input', NOME=>'PERSONE', TIPO=>'hidden', VALORE=>PERSONE); 
        GUI.APRIFIELD(TESTO=>'Caratteristiche del Tour');
        HTP.PRINT('<textarea class="input" id="NTour" name="NTour" style="width: 217px; height: 62px;" disabled>Nome: '|| NomeTour||' Numero Notti: '|| NumeroNotti||'  NUmero Tappe: '|| NumeroTappe||' </textarea>');
        GUI.CHIUDIFIELD;
        GUI.APRIFIELD('card checkout','Pagamento');
        GUI.APRIDIV('details');
        HTP.PRINT('
                    <span>Costo base crociera:</span>
                    <span>'||COSTOBASE||'€</span>
                    <span>Costo camere singole:</span>
                    <span>'||SINGOLA||'x'||COSTI(2)||'= '|| SINGOLA*COSTI(2)||'€</span>
                    <span>Costo camere doppie:</span>
                    <span>'||DOPPIA||'x'||COSTI(1)||'= '|| DOPPIA*COSTI(1)||'€</span>'); 

        IF (TRIPLA <> -1) THEN
        
            HTP.PRINT(' <span>Costo camere triple:</span>
                        <span>'||tripla||'x'||COSTI(3)||'= '|| TRIPLA*COSTI(3)||'€</span>');
            COSTOTOTALE:= COSTOBASE*PERSONE+SINGOLA*COSTI(1)+DOPPIA*COSTI(2)+TRIPLA*COSTI(3);
            
        ELSE
            
            COSTOTOTALE:= COSTOBASE*PERSONE+SINGOLA*COSTI(1)+DOPPIA*COSTI(2);
    
       END IF;
    
       GUI.CHIUDIDIV;
       GUI.APRIDIV('checkout--footer');
       HTP.PRINT('<label class="price">'||costototale||'€</label>');
       GUI.BTN(TXT => 'PAGA',NOME=>'ACCONTO',VALORE=>0);
       GUI.BTN(TXT => 'ACCONTO(30%)',NOME=>'ACCONTO',VALORE=>1);
       GUI.INPUT_FORM(TIPO =>'hidden', NOME=> 'SINGOLA', VALORE=> SINGOLA);
       GUI.INPUT_FORM(TIPO =>'hidden', NOME=> 'DOPPIA', VALORE=> DOPPIA);
       GUI.INPUT_FORM(TIPO =>'hidden', NOME=> 'TRIPLA', VALORE=> TRIPLA);
       GUI.CHIUDIDIV;
       GUI.CHIUDIDIV;
       GUI.CHIUDIFORM;
       GUI.CHIUDIPAGINASTANDARD('verde');
END PAGAMENTO;

---------------------------------------------------------------------------------------
/*
INSERIMENTO PRENOTAZIONE: RECUPERA L'IDCLIENTE DALLA SESSIONE CORRENTE E INSERISCE NELLA TABELLA PRENOTAZIONEUN NUOVO RECORD CON LE CARATTERISTICHE SELEZIONATE DALL'UTENTE NELLE PAGINE PRECEDENTI
PARAMETRI: IDCROCIERA: IDCROCIERA SELEZIONATA
           COSTOBASE: IDNAVE SELEZIONATA
           QUANTITASALDATA: INDICA IL NUMERO DI PERSONE
           ACCONTO : 0 SE VIENE PAGATO L'INTERO IMPORTO  1 
                     1 SE VIENE PGATAO UN ACCONTO DEL 30%
           SINGOLA: NUMERO DI CAMERE SINGOLE SELEZIONATE
           DOPPIA: NUMERO DI CAMERE DOPPIE SELEZIONATE
           TRIPLE: NUMERO DI CAMERE TRIPLE SELEZIONATE
           
*/
--------------------------------------------------------------------------------------

PROCEDURE INSERIMENTOPRENOTAZIONE(IDCROCIERA CROCIERA.IDCROCIERA%TYPE, COSTOBASE PRENOTAZIONE.COSTOBASE%TYPE, QUANTITASALDATA PRENOTAZIONE.QUANTITASALDATA%TYPE,PERSONE INTEGER,ACCONTO NUMBER,singola TIPOCAMERA.TIPOLOGIA%TYPE, doppia TIPOCAMERA.TIPOLOGIA%TYPE, tripla TIPOCAMERA.TIPOLOGIA%TYPE) IS
V_SESSIONE    sessione%rowtype;
DATAPRENOTAZIONE date;
TOTALEPAGATO number;
ID_PRENOTAZIONE_CORRENTE PRENOTAZIONE.IDPRENOTAZIONE%TYPE;
IDCLIENTE BE_SESSIONE.IDUTENTE%TYPE;
BEGIN
    
            BEGIN
                V_SESSIONE := AUTHENTICATE.RECUPERA_SESSIONE;
                EXCEPTION 
                    WHEN AUTHENTICATE.SESSIONE_NON_TROVATA THEN
                        NULL;
            END;
            
    DATAPRENOTAZIONE := SYSDATE; 
    IDCLIENTE:=V_SESSIONE.IDUTENTE;
    
    INSERT INTO PRENOTAZIONE(IDPRENOTAZIONE,IDCLIENTE,IDCROCIERA,COSTOBASE,DATAPRENOTAZIONE, QUANTITASALDATA)
    VALUES(IdPrenotazioneseq.NEXTVAL,IDCLIENTE,IDCROCIERA,COSTOBASE,DATAPRENOTAZIONE,0);
    
    ID_PRENOTAZIONE_CORRENTE := IDPRENOTAZIONESEQ.CURRVAL;
    
    IF SINGOLA>0 THEN
        INSERT INTO PREPRENOTAZIONE(IDPRENOTAZIONE,TIPOLOGIA,QUANTITA)
        VALUES(ID_PRENOTAZIONE_CORRENTE,'Singola',SINGOLA);
    END IF;
    
    IF DOPPIA >0 THEN
        INSERT INTO PREPRENOTAZIONE(IDPRENOTAZIONE,TIPOLOGIA,QUANTITA)
        VALUES(ID_PRENOTAZIONE_CORRENTE,'Doppia',DOPPIA);
    END IF;
    
    IF TRIPLA>0 THEN
        INSERT INTO PREPRENOTAZIONE(IDPRENOTAZIONE,TIPOLOGIA,QUANTITA)
        VALUES(ID_PRENOTAZIONE_CORRENTE,'Tripla',TRIPLA);   
    END IF;
    
    IF (ACCONTO=1) THEN
        TOTALEPAGATO:=0.3*QUANTITASALDATA;
    ELSE
        TOTALEPAGATO:=QUANTITASALDATA;
    END IF;
    
    GUI.APRIPAGINASTANDARD;                                                                                                                                                                                                                                                                                                                                                                                                                                           
    GUI.ESITOPERAZIONE('SUCCESSO', 'RECORD INSERITO NELLA TABELLA PRENOTAZIONE: <br> <br> IDPRENOTAZIONE: ' || ID_PRENOTAZIONE_CORRENTE || ' <br> IDCLIENTE:'||IDCLIENTE||' <br> IDCROCIERA: '||IDCROCIERA||' <br> COSTOBASE: '||COSTOBASE||' <br> DATAPRENOTAZIONE: '||DATAPRENOTAZIONE||' <br> QUANTITASALDATA: '||QUANTITASALDATA,'SI','GVERDE.INSERISCICLIENTI?IDPRENOTAZIONE='||ID_PRENOTAZIONE_CORRENTE||'&'||'PERSONE='||PERSONE ||'&'||'TOTALEPAGATO=' || TOTALEPAGATO,'INSERISCI DATI CLIENTI');
    GUI.CHIUDIPAGINASTANDARD('Verde');
    
    EXCEPTION WHEN OTHERS THEN
        GUI.APRIPAGINASTANDARD;
        GUI.ESITOPERAZIONE('KO','TENTATIVO DI INSERIMENTO FALLITO');
        GUI.CHIUDIPAGINASTANDARD('Verde');
    
END INSERIMENTOPRENOTAZIONE;

---------------------------------------------------------------------------------------
/*
INSERISCICLIENTI: INSERISCICLIENTI apre un form per l'inserimento dei clienti che collega alla procedura CONTROLLOCLIENTI in cui si controlla se tale cliente esista all'interno della tabella cliente (in caso contrario si  mostra un messaggio di errore in quanto la registrazione del cliente esula dagli obbiettivi del progetto) e infine inserisce l'associazione cliente-prenotazione in associazione cliente 
CONTROLLOCLIENTE
INSERIMENTOCLIENTE

PARAMETRI: IDPRENOTAZIONE: IDCROCIERA SELEZIONATA
           PERSONE: numero di persone per cui si sta prenotando che decrementa nel momento in cui inseriamo  .
*/
--------------------------------------------------------------------------------------

PROCEDURE INSERISCICLIENTI(IDPRENOTAZIONE PRENOTAZIONE.IDPRENOTAZIONE%TYPE,PERSONE INTEGER, TOTALEPAGATO NUMBER) IS
BEGIN
    GUI.APRIPAGINASTANDARD;
    GUI.APRIFORM('form card','get','GVERDE.CONTROLLOCLIENTE', JS=>'return confirm(`Confermi di inviare i dati selezionati?`);');
            GUI.CARDHEADER('Inserisci i dati dei clienti');
            GUI.APRIFIELD(TESTO=>'Codice Fiscale:');
            GUI.INPUT_FORM(classe=>'INPUT', tipo=>'TEXT', id=>'CF', nome=>'CFISCALE',  placeholder=>'Inserisci codice fiscale cliente',required=>'required');
            GUI.CHIUDIFIELD;
            GUI.APRIFIELD(TESTO=>'Nome:');
            GUI.INPUT_FORM(classe=>'INPUT', tipo=>'TEXT', id=>'Nome', nome=>'nome',  placeholder=>'Inserisci nome cliente',required=>'required');
            GUI.CHIUDIFIELD;
            GUI.APRIFIELD(TESTO=>'Cognome:');
            GUI.INPUT_FORM(classe =>'INPUT', tipo=>'TEXT', id=>'Cognome', nome=>'cognome',  placeholder=>'Inserisci cognome cliente',required=>'required');
            GUI.CHIUDIFIELD;
            GUI.APRIFIELD(TESTO=>'Numero di Telefono:');
            GUI.INPUT_FORM(classe =>'INPUT', tipo=>'number', id=>'Telfono', nome=>'telefono',  placeholder=>'Inserisci numero di telefono cliente',required=>'required');
            GUI.CHIUDIFIELD;
            GUI.APRIFIELD(TESTO=>'e-mail:');
            GUI.INPUT_FORM(classe =>'INPUT', tipo=>'email', id=>'email', nome=>'email',  placeholder=>'Inserisci e-mail cliente',required=>'required',DISABLED=>'disabled');
            GUI.CHIUDIFIELD;
            GUI.APRIFIELD(TESTO=>'Informazioni del pagamento:');
            GUI.INPUT_FORM(classe =>'INPUT', tipo=>'TEXT', id=>'infopag', nome=>'infopag',  placeholder=>'Inserisci informazioni sul pagamento',required=>'required');
            GUI.CHIUDIFIELD;
            GUI.INPUT_FORM(CLASSE=>'input', NOME=>'IDPRENOTAZIONE', TIPO=>'hidden', VALORE=>IDPRENOTAZIONE);
            GUI.INPUT_FORM(CLASSE=>'input', NOME=>'PERSONE', TIPO=>'hidden', VALORE=>PERSONE);
            GUI.INPUT_FORM(CLASSE=>'input', NOME=>'TOTALEPAGATO', TIPO=>'hidden', VALORE=>TOTALEPAGATO);

            GUI.APRIFIELD(ALLINEAMENTO =>'center');
                GUI.BTNSUBMIT(TXT =>'INSERISCI');
                GUI.BTNRESET(TXT =>'CANCELLA');
                GUI.CHIUDIFIELD;
    GUI.CHIUDIFORM;
    GUI.CHIUDIPAGINASTANDARD('Verde');
END INSERISCICLIENTI;

PROCEDURE CONTROLLOCLIENTE(CFISCALE be_UTENTE.CF%TYPE, NOME be_UTENTE.NOME%TYPE, COGNOME be_UTENTE.COGNOME%TYPE, TELEFONO NUMBER, EMAIL VARCHAR2, INFOPAG be_UTENTE.InformazioniPagamento%TYPE,IDPRENOTAZIONE PRENOTAZIONE.IDPRENOTAZIONE%TYPE,PERSONE INTEGER, TOTALEPAGATO NUMBER) IS
    IDCLIENTERIFERIMENTO NUMBER;
    BEGIN
        
        
        SELECT IDUTENTE
        INTO IDCLIENTERIFERIMENTO
        FROM BE_UTENTE
        WHERE CF=CFISCALE;
        
        GVERDE.INSERIMENTOCLIENTE(IDPRENOTAZIONE,IDCLIENTERIFERIMENTO,PERSONE,TOTALEPAGATO);
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
            GUI.APRIPAGINASTANDARD;
            GUI.ESITOPERAZIONE('KO','UTENTE NON TROVATO');
            GUI.CHIUDIPAGINASTANDARD('Verde');
            
        GUI.CHIUDIPAGINASTANDARD('Verde');
    END CONTROLLOCLIENTE;
   
PROCEDURE INSERIMENTOCLIENTE(IDPRENOTAZIONE_P PRENOTAZIONE.IDPRENOTAZIONE%TYPE,IDCLIENTE INTEGER,PERSONE INTEGER, TOTALEPAGATO INTEGER) IS
PERSONEMANCANTI INTEGER := PERSONE;
BEGIN
    
    INSERT INTO CLIENTERIFERIMENTO VALUES(IDPRENOTAZIONE_P,IDCLIENTE);
    PERSONEMANCANTI := PERSONEMANCANTI - 1;
    GUI.APRIPAGINASTANDARD;
    IF PERSONEMANCANTI <> 0 THEN
        GUI.ESITOPERAZIONE('SUCCESSO', 'Devi ancora inserire i dati di '||PERSONEMANCANTI||' clienti/e','SI','GVERDE.INSERISCICLIENTI?IDPRENOTAZIONE='||IDPRENOTAZIONE_P||'&'||'PERSONE='||PERSONEMANCANTI||'&'||'TOTALEPAGATO='||TOTALEPAGATO,'INSERISCI DATI');
        
    ELSE
        GUI.ESITOPERAZIONE('SUCCESSO', 'Sono stati inseriti i dati di tutti i clienti');

        UPDATE PRENOTAZIONE SET QUANTITASALDATA = TOTALEPAGATO
        WHERE IDPRENOTAZIONE = IDPRENOTAZIONE_P;

    END IF;
    GUI.CHIUDIPAGINASTANDARD('Verde');
    
    
    EXCEPTION WHEN OTHERS THEN
            GUI.APRIPAGINASTANDARD;
            GUI.ESITOPERAZIONE('KO','CLIENTE GIÀ ASSOCIATO A QUESTA PRENOTAZIONE ' );
            GUI.CHIUDIPAGINASTANDARD('Verde');
END INSERIMENTOCLIENTE;



---------------------------------------------------------------------------------------
/*

MOSTRAPRENOTAZIONICLIENTE : RECUPERA L'IDCLIENTE E MOSTRA LE CROCIEREASSOCIATE A TALE ID 
ELIMINAZIONE PRENOTAZIONE CROCIERA: DATO L'IDCLIENTE E L'ID PRENOTAZIONE DALLA PROCEDURA PRECEDENTE ELIMINA IL CORRISPONDENTE RECORD DALLA TABELLA PRENOTAZIONE
PARAMETRI: TIPO: 0 mostra la tabella con la prenotazioni effettuate dal cliente con il bottone cancella per l'operazione di cancellazione
                 1 inserisce il bottone mostra visita
           ELIMINA: è un parametro che serve per la procedura VISUALIZZAVISITE
                    0 MOSTRA LE VISITE DISPONIBILI PER UNA DETERMINATA CROCIERA
                    1 MOSTRA LE VISITE PRENOTATE 
*/
--------------------------------------------------------------------------------------
PROCEDURE MOSTRAPRENOTAZIONICLIENTE(TIPO INT DEFAULT 0,ELIMINA INT DEFAULT 0) IS
V_SESSIONE    sessione%rowtype;
V_UTENTE     utente%rowtype;
IDC NUMBER;
BEGIN
        begin
            V_SESSIONE := AUTHENTICATE.RECUPERA_SESSIONE;
            EXCEPTION 
                when AUTHENTICATE.SESSIONE_NON_TROVATA then
                    null;
        end;
        IDC:= V_SESSIONE.IDUTENTE;
        GUI.APRIPAGINASTANDARD;
        GUI.APRITABELLA('Crociere Prenotate', 1, tableId => 't01');
            GUI.APRIRIGATABELLA();
                GUI.CELLATABELLAHEADER('Nome Tour', 'align = center');
                GUI.CELLATABELLAHEADER('Data Crociera', 'align = center');
            GUI.CHIUDIRIGATABELLA();
        
        FOR CROCIERA IN (SELECT IDTOUR, NOMETOUR, DATACROCIERA,IDPRENOTAZIONE, IDCROCIERA FROM PRENOTAZIONE P INNER JOIN CROCIERA C USING (IDCROCIERA) INNER JOIN TOUR T USING (IDTOUR) WHERE P.IDCLIENTE=IDC)
        LOOP
            GUI.APRIRIGATABELLA();
                GUI.CELLATABELLALINK(CROCIERA.NOMETOUR,LINKTO => Costanti.macchina2 || Costanti.radice || 'BLU.INFOTOUR?id_tour=' || CROCIERA.IDTOUR);
                GUI.CELLATABELLA(CROCIERA.DATACROCIERA);
                IF TIPO=0 THEN
                    GUI.CELLATABELLABTN(TXT=>'CANCELLA',LINKTO => Costanti.macchina2 || Costanti.radice || 'GVERDE.ELIMINAZIONEPRENOTAZIONE?IDPRENOTAZIONE_P='||CROCIERA.IDPRENOTAZIONE||'&'||'IDCLIENTE_P='||IDC);
                ELSE
                    GUI.CELLATABELLABTN(TXT=>'MOSTRA VISITE',LINKTO => Costanti.macchina2 || Costanti.radice || 'GVERDE.VISUALIZZAVISITE?IDPRENOTAZIONE_P='||CROCIERA.IDPRENOTAZIONE||'&'||'IDCLIENTE='||IDC||'&'||'IDC='||CROCIERA.IDCROCIERA||'&'||'ELIMINA='||ELIMINA);
                END IF;
            GUI.CHIUDIRIGATABELLA();
        END LOOP;
        GUI.CHIUDITABELLA;
        GUI.CHIUDIPAGINASTANDARD('Verde');
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
            GUI.ESITOPERAZIONE('KO','NON SONO DISPONIBILI VISITE GUIDATE PER TALE CROCIERA');
            GUI.CHIUDIPAGINASTANDARD('Verde');
END MOSTRAPRENOTAZIONICLIENTE;


---------------------------------------------------------------------------------------
/*

ELIMINAZIONEPRENOTAZIONE: DATO L'IDCLIENTE E L'ID PRENOTAZIONE DALLA PROCEDURA PRECEDENTE ELIMINA IL CORRISPONDENTE RECORD DALLA TABELLA PRENOTAZIONE
*/

PROCEDURE ELIMINAZIONEPRENOTAZIONE(IDPRENOTAZIONE_P PRENOTAZIONE.IDPRENOTAZIONE%TYPE, IDCLIENTE_P PRENOTAZIONE.IDCLIENTE%TYPE) is
BEGIN
        GUI.APRIPAGINASTANDARD;
        DELETE FROM PREPRENOTAZIONE WHERE (IDPRENOTAZIONE=IDPRENOTAZIONE_P);
    
        DELETE FROM IMBARCO WHERE (IDPRENOTAZIONE=IDPRENOTAZIONE_P);
    
        DELETE FROM CLIENTERIFERIMENTO WHERE (IDPRENOTAZIONE=IDPRENOTAZIONE_P);
    
        DELETE FROM PRENOTAZIONEVISITA WHERE (IDPRENOTAZIONE=IDPRENOTAZIONE_P);
    
        DELETE FROM PRENOTAZIONE WHERE (IDPRENOTAZIONE=IDPRENOTAZIONE_P AND IDCLIENTE=IDCLIENTE_P);
        
        GUI.ESITOPERAZIONE('SUCCESSO','ELIMINAZIONE AVVENUTA CON SUCCESSO');
        GUI.CHIUDIPAGINASTANDARD('Verde');
        EXCEPTION WHEN OTHERS THEN
            GUI.ESITOPERAZIONE('KO','PRENOTAZIONE NON ELIMINATA');
            GUI.CHIUDIPAGINASTANDARD('Verde');
END ELIMINAZIONEPRENOTAZIONE;


    
   
    


---------------------------------------------------------------------------------------
/*

VISUALIZZAVISITE : VISUALIZZE LE VISITE DISPONIBILI PER UNA DETERMINATA CROCIERA O LE VISITE PRENOTATE 
PARAMETRI: IDPRENOTAZIONA: IDPRENOTAZIONE SELEZIONATA
           IDCLIENTE: CHIAVE UNIVOCA CHE SI RIFERISCE AL CLIENTE A CUI è ASSOCIATA LA PRENOTAZIONE
           IDCROCIERA: IDCROCIERA IDENTIFICA LA CROCIERA PRENOTATA
           ELIMINA: 0 MOSTRA LE VISITE DISPONIBILI PER UNA DETERMINATA CROCIERA
                    1 MOSTRA LE VISITE PRENOTATE 
*/
--------------------------------------------------------------------------------------

PROCEDURE VISUALIZZAVISITE(IDPRENOTAZIONE_P PRENOTAZIONE.IDPRENOTAZIONE%TYPE, IDCLIENTE PRENOTAZIONE.IDCLIENTE%TYPE, IDC CROCIERA.IDCROCIERA%TYPE, ELIMINA INT DEFAULT 0) IS
BEGIN
        GUI.APRIPAGINASTANDARD;
        
    
            IF (ELIMINA = 0) THEN
                GUI.APRITABELLA('VISITE DISPONIBILI PER LA TUA CROCIERA', 1, tableId => 't01');
                GUI.APRIRIGATABELLA;
                GUI.CELLATABELLAHEADER('Nome Visita', 'align = center');
                GUI.CELLATABELLAHEADER('Data Visita', 'align = center');
                GUI.CELLATABELLAHEADER('Costo Visita', 'align = center');
                GUI.CHIUDIRIGATABELLA;
                FOR VISITA IN (SELECT IDVISITA,NOMEVISITA,DATAVISITA,COSTOVISITA 
                            FROM VISITEDISPONIBILI VD INNER JOIN VISITAGUIDATA VG USING (IDVISITA) 
                            WHERE VD.IDCROCIERA=IDC and VG.ISDISPONIBILE=1)
                LOOP
                        GUI.APRIRIGATABELLA;
                        GUI.CELLATABELLALINK(VISITA.NOMEVISITA, LINKTO => Costanti.macchina2 || Costanti.radice || 'BLU.INFOVISITA?id_visita=' || VISITA.IDVISITA);
                        GUI.CELLATABELLA(VISITA.DATAVISITA);
                        GUI.CELLATABELLA(VISITA.COSTOVISITA);
                        GUI.CELLATABELLABTN(TXT=>'PRENOTA',LINKTO => Costanti.macchina2 || Costanti.radice || 'GVERDE.PAGINAPRENOTAZIONIVISITE?IdPrenotazione= '||IDPRENOTAZIONE_P|| '&'||'IdVisita=' ||VISITA.IDVISITA ||'&'||'nomevisita=' ||VISITA.NOMEVISITA||'&'||'datavisita=' ||VISITA.DATAVISITA||'&'||'costovisita=' ||VISITA.COSTOVISITA);
                        GUI.CHIUDIRIGATABELLA;
                END LOOP;
                GUI.CHIUDITABELLA;
            ELSE 
                GUI.APRITABELLA('VISITE PRENOTATE', 1, tableId => 't01');
                GUI.APRIRIGATABELLA;
                GUI.CELLATABELLAHEADER('Nome Visita', 'align = center');
                GUI.CELLATABELLAHEADER('Data Visita', 'align = center');
                GUI.CELLATABELLAHEADER('Costo Visita', 'align = center');
                GUI.CHIUDIRIGATABELLA;
                FOR VISITA IN (SELECT IDVISITA,NOMEVISITA,DATAVISITA,COSTOVISITA 
                                FROM PRENOTAZIONEVISITA PV 
                                JOIN VISITAGUIDATA VG USING (IDVISITA) 
                                JOIN VISITEDISPONIBILI USING (IDVISITA)
                                JOIN CROCIERA USING (IDCROCIERA)
                                JOIN PRENOTAZIONE USING (IDCROCIERA)
                                WHERE PV.IDPRENOTAZIONE=IDPRENOTAZIONE_P and VG.ISDISPONIBILE=1)
                LOOP
                        GUI.APRIRIGATABELLA;
                        GUI.CELLATABELLALINK(VISITA.NOMEVISITA, LINKTO => Costanti.macchina2 || Costanti.radice || 'BLU.INFOVISITA?id_visita=' || VISITA.IDVISITA);
                        GUI.CELLATABELLA(VISITA.DATAVISITA);
                        GUI.CELLATABELLA(VISITA.COSTOVISITA);
                        GUI.CELLATABELLABTN(TXT=>'ELIMINA',CONFERMA=>1,ONSUBMIT => 'onclick="if(confirm(`vuoi eliminare la riga`)){location.href=`'||Costanti.macchina2 || Costanti.radice || 'GVERDE.ELIMINAZIONEVISITA?IDPRENOTAZIONE_P='||IDPRENOTAZIONE_P|| '&'||'amp;'||'IDVISITA_P=' ||VISITA.IDVISITA||'`}"');
                        GUI.CHIUDIRIGATABELLA;
                END LOOP;
                GUI.CHIUDITABELLA;
        END IF;
        
        GUI.CHIUDIPAGINASTANDARD('verde');
        
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
            GUI.ESITOPERAZIONE('ko','NON SONO DISPONIBILI VISITE GUIDATE PER TALE CROCIERA <br> <div> <a  href= ' || Costanti.macchina2 || Costanti.radice || 'GVERDE.CERCACROCIERE> Prenota ora la tua crociera </a></div>');
            --HTP.PRINT('<div class="mess_importante"> NON SONO DISPONIBILI VISITE GUIDATE PER TALE CROCIERA </div>');
            --HTP.PRINT('<div class="mess_importante"> <a  href= ' || Costanti.macchina2 || Costanti.radice || 'GVERDE.CERCACROCIERE> Prenota ora la tua crociera </a></div>');

            GUI.CHIUDIPAGINASTANDARD('verde');
            
    END VISUALIZZAVISITE;

---------------------------------------------------------------------------------------
/*

PAGINAPRENOTAZIONIVISITE : APRE UNA PAGINA STANDAR INSERENDO UN FORM PER IL RIEPILOGO DELLA VISITA SELEZIONATA E PER SCEGLIEE IL NUMERO DI PERSONE CHE PARTECIPERANNO
FORMPAGAMENTOVISITE
PARAMETRI: IDPRENOTAZIONE: IDPRENOTAZIONE SELEZIONATA
           IVISITA: IDVISITA SELEZIONATA
           NOMEVISITA DATAVSITA COSTOVISITA: INDICANO LE CARATTERISTICHE DEL TOUR SELEZIONATO
           
*/
--------------------------------------------------------------------------------------
PROCEDURE FORMPAGAMENTOVISITE(TITOLO VARCHAR2 DEFAULT '',IDPRENOTAZIONE PRENOTAZIONE.IDPRENOTAZIONE%TYPE, IDVISITA VISITAGUIDATA.IDVISITA%TYPE, NOMEVISITA VISITAGUIDATA.NOMEVISITA%TYPE, DATAVISITA VARCHAR2 DEFAULT '', COSTOVISITA VISITAGUIDATA.COSTOVISITA%TYPE) IS
CONTATORE INT :=1;

    cursor c_lingue (IDVISITA_P VISITAGUIDATA.IDVISITA%TYPE) IS
        SELECT DISTINCT G.LINGUA
        FROM VISITAGUIDATA V
        JOIN GESTISCE G
        USING (IDVISITA)            
        WHERE IDVISITA = IDVISITA_P;
BEGIN

        HTP.PRINT('
                    
                    <SCRIPT type="text/javascript">
                     function aggiornaHidden(sel){
                      var f = document.frm;
                      f.sel_value.value = sel.options[sel.selectedIndex].value;
                      f.sel_text.value = sel.options[sel.selectedIndex].text;}
                    </SCRIPT>');
                    
        GUI.APRIFORM('form card','get','GVERDE.INSERIMENTOVISITA',JS=>'return confirm(`Confermi di inviare i dati selezionati?`);');
        GUI.APRIDIV(CLASSE=>'master-container');
        GUI.APRIDIV(CLASSE=>'card cart');
        GUI.APRILABEL('TITLE2',TITOLO);
        GUI.CHIUDILABEL;
        GUI.APRIDIV('products');
        GUI.APRIDIV('product');
        GUI.APRIDIV;
        HTP.PRINT('
         <span>'||NOMEVISITA||'</span>
          <p>'||DATAVISITA||'</p>
          <label class="price small">'||COSTOVISITA||'€</label>
        </div>
        ');
        GUI.CHIUDIDIV;
        GUI.CHIUDIDIV;
        GUI.CHIUDIDIV;
        GUI.APRIDIV('card checkout');
        GUI.APRILABEL('title','PAGAMENTO');
        GUI.CHIUDILABEL;
        GUI.APRIDIV('checkout--footer1');
        GUI.APRIFIELD(TESTO=>'Persone');
        GUI.APRISELECTINPUT('costototale','costotale','aggiornaHidden(this)');
        LOOP
            EXIT WHEN CONTATORE > 10; 
            GUI.OPTION_SELECT(CONTATORE*COSTOVISITA, CONTATORE);
            CONTATORE:=CONTATORE+1;
        END LOOP;
        GUI.CHIUDISELECT;
        gui.CHIUDIFIELD();
        GUI.APRIFIELD(TESTO=>'Lingua');
        GUI.APRISELECTINPUT('lingua','lingua');
        FOR lingua IN c_lingue(IDVISITA)
        LOOP
            GUI.OPTION_SELECT(lingua.lingua, lingua.lingua);
        END LOOP;
        GUI.CHIUDISELECT;
        GUI.CHIUDIFIELD;
        GUI.APRILABEL(TESTO=>'COSTO TOTALE');
        GUI.CHIUDILABEL;
        HTP.PRINT('   <INPUT type="number" name="sel_value" disabled>
                      <INPUT type="hidden" name="sel_text" disabled>');
        GUI.APRIDIV('checkout--footer');
        GUI.BTN(TXT => 'PAGA',NOME=>'ACCONTO',VALORE=>0);
        GUI.BTN(TXT => 'ACCONTO(30%)',NOME=>'ACCONTO',VALORE=>1);
        GUI.CHIUDIDIV;
        GUI.CHIUDIDIV;
        GUI.CHIUDIDIV;
        GUI.CHIUDIDIV;
        GUI.INPUT_FORM(TIPO =>'hidden', NOME=> 'IDPRENOTAZIONE', VALORE=> IDPRENOTAZIONE);
        GUI.INPUT_FORM(TIPO =>'hidden', NOME=> 'IDVISITA', VALORE=> IDVISITA);
        GUI.INPUT_FORM(TIPO =>'hidden', NOME=> 'COSTOUNITARIO', VALORE=> COSTOVISITA);
        
        GUI.CHIUDIFORM;
       
END FORMPAGAMENTOVISITE;


PROCEDURE PAGINAPRENOTAZIONIVISITE(IDPRENOTAZIONE PRENOTAZIONE.IDPRENOTAZIONE%TYPE, IDVISITA VISITAGUIDATA.IDVISITA%TYPE, NOMEVISITA VISITAGUIDATA.NOMEVISITA%TYPE, DATAVISITA VARCHAR2 DEFAULT '', COSTOVISITA VISITAGUIDATA.COSTOVISITA%TYPE) IS
BEGIN
    GUI.APRIPAGINASTANDARD;
    GVERDE.FORMPAGAMENTOVISITE('RIEPILOGO VISITA',IDPRENOTAZIONE,IDVISITA,NOMEVISITA, DATAVISITA, COSTOVISITA);
    GUI.CHIUDIPAGINASTANDARD('verde'); 
END PAGINAPRENOTAZIONIVISITE;

---------------------------------------------------------------------------------------
/*

INSERIMENTOVISITA : INSERISCE LA PRENOTAZIONE DELLA VISITA SCELTA NELLA TABELLA PRENOTAZIONE VISITA

PARAMETRI: PERSONE:
        ACCONTO NUMBER DEFAULT 0, IDPRENOTAZIONE NUMBER DEFAULT 0, IDVISITA NUMBER DEFAULT 0, COSTOUNITARIO NUMBER DEFAULT 0
           
*/
--------------------------------------------------------------------------------------

PROCEDURE INSERIMENTOVISITA(COSTOTOTALE NUMBER DEFAULT 0, ACCONTO NUMBER DEFAULT 0, LINGUA GESTISCE.LINGUA%TYPE, IDPRENOTAZIONE PRENOTAZIONE.IDPRENOTAZIONE%TYPE, IDVISITA VISITAGUIDATA.IDVISITA%TYPE, COSTOUNITARIO VISITAGUIDATA.COSTOVISITA%TYPE) IS
NUMEROBIGLIETTI NUMBER;
COSTOTOTALEORDINE NUMBER;
QUANTITASALDATA NUMBER;
BEGIN
    NUMEROBIGLIETTI :=COSTOTOTALE/COSTOUNITARIO;
    IF (ACCONTO=0) THEN
        QUANTITASALDATA:=COSTOTOTALE;
    ELSE
        QUANTITASALDATA:=COSTOTOTALE*0.3;
    END IF;

    INSERT INTO PRENOTAZIONEVISITA
    VALUES(IDPRENOTAZIONE,IDVISITA,NUMEROBIGLIETTI,COSTOTOTALE,QUANTITASALDATA, LINGUA);
    
    GUI.APRIPAGINASTANDARD;
    GUI.ESITOPERAZIONE('SUCCESSO','PRENOTAZIONE VISITA ANDATA A BUON FINE');
    GUI.CHIUDIPAGINASTANDARD('Verde');
    EXCEPTION WHEN OTHERS THEN
            GUI.APRIPAGINASTANDARD;
            GUI.ESITOPERAZIONE('KO','<div> <a  href= '|| Costanti.macchina2 || Costanti.radice || 'GVERDE.MOSTRAPRENOTAZIONICLIENTE?TIPO=1'||'&'||'ELIMINA=0> Scopri nuove visite guidate </a></div>');
            GUI.CHIUDIPAGINASTANDARD('Verde');
END INSERIMENTOVISITA;

---------------------------------------------------------------------------------------
/*

ELIMINAZIONEVISITA : ELIMINA LA VISITA SELEZIONATA, PRECEDENTEMENTE PRENOTATA 

PARAMETRI: IDPRENOTAZIONE
           IDVISITA
*/
--------------------------------------------------------------------------------------


PROCEDURE ELIMINAZIONEVISITA(IDPRENOTAZIONE_P PRENOTAZIONE.IDPRENOTAZIONE%TYPE, IDVISITA_P VISITAGUIDATA.IDVISITA%TYPE) IS
BEGIN
    GUI.APRIPAGINASTANDARD;
    DELETE FROM PRENOTAZIONEVISITA WHERE (IDPRENOTAZIONE=IDPRENOTAZIONE_P AND IDVISITA=IDVISITA_P);
    GUI.ESITOPERAZIONE('SUCCESSO','ELIMINAZIONE VISITA AVVENUTA CON SUCCESSO');
    GUI.CHIUDIPAGINASTANDARD('Verde');
    
    EXCEPTION WHEN OTHERS THEN
            GUI.ESITOPERAZIONE('KO','ELIMINAIONE PRENOTAZIONE VISITA NON AVVENUTA');
            GUI.CHIUDIPAGINASTANDARD('Verde');
END ELIMINAZIONEVISITA;

---------------------------------------------------------------------------------------
/*
RISULTATI STATISTICI

PROCEDURE STATISTICHE PER ANALISI DATI:

PERCENTUALEVOTAZIONE: MOSTRA PER OGNI VISITA LA PERCENTUALE DI RECENSIONI CON VOTAZIONE MAGGIORE DI 5 EFFETTUATE DA PARTE DEGLI UTENTI 
CLIENTENOPRENOTAZIONEVISITE: MOSTRA I CLIENTI (TRA QUELLI CHE HANNO UNA PRENOTAZIONE CROCIERA A PROPRIO NOME) CHE NON HANNO EFFETTUATO PRENOTAZIONI A VISITE GUIDATE 
PRENOTAZIONIPERCROCIERA: MOSTRA IL NUMERO DI PRENOTAZIONI PER CIASCUNA CROCIERA  (per ogni crociera con almeno una prenotazione)
CROCIERACOSTOBASEMAGGIORE: MOSTRA LE CROCIERE CON IL COSTO BASE MAGGIORE
*/
--------------------------------------------------------------------------------------

PROCEDURE PERCENTUALEVOTAZIONE AS

PERCENTUALEPOSITIVI NUMBER;
CURSOR CURSORE IS   SELECT IDVISITA,NOMEVISITA, COUNT(CASE WHEN voto>5 THEN voto END) AS NO_RECENSIONIPOSITIVE, COUNT(*) AS NO_RECENSIONI 
                    FROM CLIENTEVISITARECENSIONE INNER JOIN VISITAGUIDATA USING (IDVISITA)
                    GROUP BY IDVISITA, NOMEVISITA;

BEGIN

    GUI.APRIPAGINASTANDARD;
        GUI.APRITABELLA(' PERCENTUALE DI RECENSIONI POSITIVE PER VISITA', 1, tableId => 't01');
            GUI.APRIRIGATABELLA;
                GUI.CELLATABELLAHEADER('NOME VISITA', 'align = center');
                GUI.CELLATABELLAHEADER('PERCENTUALE REC. POSITIVE', 'align = center');
            GUI.CHIUDIRIGATABELLA;
            
    FOR VISITA IN CURSORE
    LOOP

        PERCENTUALEPOSITIVI:= 100*VISITA.NO_RECENSIONIPOSITIVE/VISITA.NO_RECENSIONI;
        GUI.APRIRIGATABELLA;
        GUI.CELLATABELLA(VISITA.IDVISITA);
        GUI.CELLATABELLA(VISITA.NOMEVISITA);
        GUI.CELLATABELLA(PERCENTUALEPOSITIVI);
        GUI.CHIUDIRIGATABELLA;
        
    END LOOP;
    GUI.CHIUDITABELLA;
    GUI.CHIUDIPAGINASTANDARD('Verde');
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            GUI.ESITOPERAZIONE('KO','NESSUNA VISITA TROVATA CON ALMENO UNA RECENSIONE');
            GUI.CHIUDIPAGINASTANDARD('Verde');

END PERCENTUALEVOTAZIONE;


PROCEDURE CLIENTENOPRENOTAZIONEVISITE AS
BEGIN
    GUI.APRIPAGINASTANDARD;

    IF AUTHORIZE.HAPERMESSO(PERMESSO_P  => 'stat')  = false then 
        raise AUTHORIZE.SENZA_PERMESSO;
    END IF;

        GUI.APRITABELLA(' CLIENTI CHE NON HANNO PRENOTATO  VISITE', 1, tableId => 't01');
            GUI.APRIRIGATABELLA;
                GUI.CELLATABELLAHEADER('IDCLIENTE', 'align = center');
                GUI.CELLATABELLAHEADER('Nome CLIENTE', 'align = center');
                GUI.CELLATABELLAHEADER('Cognome CLIENTE', 'align = center');
            GUI.CHIUDIRIGATABELLA;
        FOR C IN (SELECT IDUTENTE, NOME, COGNOME
                        FROM BE_UTENTE 
                        WHERE IDUTENTE NOT IN (SELECT DISTINCT IDCLIENTE FROM VISITECLIENTE))
        LOOP
            GUI.APRIRIGATABELLA;
            GUI.CELLATABELLA(C.IDUTENTE);
            GUI.CELLATABELLA(C.NOME);
            GUI.CELLATABELLA(C.COGNOME);
            GUI.CHIUDIRIGATABELLA;
        END LOOP;
        GUI.CHIUDITABELLA;
        GUI.CHIUDIPAGINASTANDARD('Verde');            

        EXCEPTION
            when authorize.SENZA_PERMESSO then gui.ESITOPERAZIONE(ESITO  => 'fallimento' /*IN VARCHAR2*/,
                    MESSAGGIO  => 'non hai i permessi necessari per eseguire questa operazione' /*IN VARCHAR2*/);
            GUI.CHIUDIPAGINASTANDARD('Verde');

END CLIENTENOPRENOTAZIONEVISITE;

PROCEDURE PRENOTAZIONIPERCROCIERA AS
BEGIN
    GUI.APRIPAGINASTANDARD;

    IF AUTHORIZE.HAPERMESSO(PERMESSO_P  => 'stat')  = false then 
        raise AUTHORIZE.SENZA_PERMESSO;
    END IF;

    GUI.APRITABELLA('CONTEGGIO PRENOTAZIONI PER IDCROCIERA ', 1, tableId => 't01');
            GUI.APRIRIGATABELLA;
                GUI.CELLATABELLAHEADER('IDCROCIERA', 'align = center');
                GUI.CELLATABELLAHEADER('NUMERO DI PRENOTAZIONI', 'align = center');
            GUI.CHIUDIRIGATABELLA;
            
    FOR CROCIERA IN (SELECT IDCROCIERA,COUNT(*) AS NO_PRENOTAZIONI
                     FROM PRENOTAZIONE 
                     GROUP BY IDCROCIERA)
        LOOP
            GUI.APRIRIGATABELLA;
            GUI.CELLATABELLA(CROCIERA.IDCROCIERA);
            GUI.CELLATABELLA(CROCIERA.NO_PRENOTAZIONI);
            GUI.CHIUDIRIGATABELLA;
        END LOOP;
    GUI.CHIUDITABELLA;  
    
    GUI.CHIUDIPAGINASTANDARD('Verde');

    EXCEPTION
        when authorize.SENZA_PERMESSO then gui.ESITOPERAZIONE(ESITO  => 'fallimento' /*IN VARCHAR2*/,
                MESSAGGIO  => 'non hai i permessi necessari per eseguire questa operazione' /*IN VARCHAR2*/);
            GUI.CHIUDIPAGINASTANDARD('Verde');
END PRENOTAZIONIPERCROCIERA;

PROCEDURE CROCIERACOSTOBASEMAGGIORE AS
BEGIN
    GUI.APRIPAGINASTANDARD;

    IF AUTHORIZE.HAPERMESSO(PERMESSO_P  => 'stat')  = false then 
        raise AUTHORIZE.SENZA_PERMESSO;
    END IF;

    GUI.APRICARD('CROCIERA CON IL COSTO BASE MAGGIORE');
    GUI.CORPOCARD;
    FOR CURSORE IN (SELECT * 
                    FROM CROCIERA INNER JOIN TOUR USING (IDTOUR)
                    WHERE COSTOCROCIERA= (SELECT MAX(COSTOCROCIERA)
                                      FROM CROCIERA))
    LOOP
        GUI.P('IDCROCIERA: '||CURSORE.IDCROCIERA||' | IDTOUR: '||CURSORE.IDTOUR||' | COSTO CROCIERA: ' ||CURSORE.COSTOCROCIERA);
    END LOOP;
    GUI.CHIUDICARD();
    GUI.CHIUDIPAGINASTANDARD('Verde');

    EXCEPTION
        when authorize.SENZA_PERMESSO then gui.ESITOPERAZIONE(ESITO  => 'fallimento' /*IN VARCHAR2*/,
                MESSAGGIO  => 'non hai i permessi necessari per eseguire questa operazione' /*IN VARCHAR2*/);
            GUI.CHIUDIPAGINASTANDARD('Verde');
END CROCIERACOSTOBASEMAGGIORE;

-------Author: Samuele Boldrini---------------

---------------------------------------------------------------------------------------
/*
RECENSIONIGUIDA : 
FORMPAGAMENTOVISITE
PARAMETRI: IDPRENOTAZIONE: IDPRENOTAZIONE SELEZIONATA
           IVISITA: IDVISITA SELEZIONATA
           NOMEVISITA DATAVSITA COSTOVISITA: INDICANO LE CARATTERISTICHE DEL TOUR SELEZIONATO
*/
--------------------------------------------------------------------------------------

procedure RECENSIONIGUIDA is 
    GUIDACF GUIDA.CF%TYPE;
    idutente BE_SESSIONE.IDUTENTE%TYPE;
    cursor c_nomi_visite (guidaCF UTENTE.CF%TYPE) is
                 SELECT idvisita, nomevisita 
                 FROM 
                    guida gu
                    JOIN gestisce ge
                    USING (idguida)
                    JOIN visitaguidata v 
                    USING (idvisita)
                 WHERE 
                    gu.CF = guidaCF;
begin 
    idutente := AUTHENTICATE.RECUPERA_SESSIONE().IDUTENTE;
    SELECT GUIDA.CF
    INTO GUIDACF
    FROM UTENTE, GUIDA
    WHERE UTENTE.CF = GUIDA.CF;

    GUI.APRIPAGINASTANDARD('Recensioni');
        GUI.APRIFORM( METODO  => 'get', AZIONE  => 'GVERDE.VISUALIZZARECENSIONIGUIDA');
        GUI.CARDHEADER('Trova la visita');
        GUI.APRIFIELD( TESTO  => 'Seleziona la visita:', ALLINEAMENTO  => 'center');
        GUI.APRISELECTINPUT('visita', 'visita');
            for nome_visita in c_nomi_visite(GUIDACF) -- TODO: Repalce with session
            loop
                GUI.OPTION_SELECT(nome_visita.idvisita, nome_visita.nomevisita);
            end loop;
        GUI.CHIUDISELECT();
        GUI.CHIUDIFIELD();
        
        GUI.APRIFIELD(ALLINEAMENTO  => 'center');
            GUI.BTNSUBMIT(id => 'submit', txt => 'Cerca');
        GUI.CHIUDIFIELD();
        GUI.CHIUDIFORM();
    GUI.CHIUDIPAGINASTANDARD('Verde');
end RECENSIONIGUIDA;

---------------------------------------------------------------------------------------
/*
VISUALIZZARECENSIONIGUIDA : DATA UNA VISITA VISUALIZZA LE RECENSIONI
PARAMETRI: VISITA: ID DELLA VISITA
*/
--------------------------------------------------------------------------------------

procedure VISUALIZZARECENSIONIGUIDA(visita visitaguidata.idvisita%TYPE) is
    nome_visita visitaguidata.nomevisita%TYPE;
    cursor recensioni (id_visita visitaguidata.idvisita%TYPE) is
        SELECT voto from recensione where idvisita = id_visita;
begin
    SELECT nomevisita into nome_visita from visitaguidata where idvisita = visita;
    
    GUI.APRIPAGINASTANDARD('Recensioni ' || nome_visita);
        GUI.APRITABELLA('Recensioni ' || nome_visita, 1, tableId => 't01');
            GUI.APRIRIGATABELLA();
                GUI.CELLATABELLAHEADER('Voto', 'align = center');
            GUI.CHIUDIRIGATABELLA();
        for recensione in recensioni(visita)
        loop
            GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(recensione.voto);
            GUI.CHIUDIRIGATABELLA();
        end loop;
        GUI.CHIUDITABELLA();
    GUI.CHIUDIPAGINASTANDARD('Verde');        
end VISUALIZZARECENSIONIGUIDA;

---------------------------------------------------------------------------------------
/*
VOTOVISITA : PERMETTE DI SELEZIONARE UNA VISITA GUIDATA
*/
--------------------------------------------------------------------------------------

procedure VOTOVISITA is 
    cursor c_nomi_visite is
                SELECT idvisita, nomevisita 
                FROM visitaguidata;
begin
    GUI.APRIPAGINASTANDARD('Seleziona la visita');
        GUI.APRIFORM( METODO  => 'get', AZIONE  => 'GVERDE.VISUALIZZAVOTOVISITA');
        GUI.CARDHEADER('Seleziona la visita');
        GUI.APRIFIELD( TESTO  => 'Seleziona la visita:', ALLINEAMENTO  => 'center');
        GUI.APRISELECTINPUT('visita', 'visita');
            for nome_visita in c_nomi_visite
            loop
                GUI.OPTION_SELECT(nome_visita.idvisita, nome_visita.nomevisita);
            end loop;

        GUI.CHIUDISELECT();
        GUI.CHIUDIFIELD();
        
        GUI.APRIFIELD(ALLINEAMENTO  => 'center');
            GUI.BTNSUBMIT(id => 'submit', txt => 'Cerca');
        GUI.CHIUDIFIELD();
        GUI.CHIUDIFORM();
    GUI.CHIUDIPAGINASTANDARD('Verde');
end VOTOVISITA;

---------------------------------------------------------------------------------------
/*
VISUALIZZAVOTOVISITA : DATA UNA VISITA VISUALIZZA IL VOTO MEDIO DELLA STESSA
PARAMETRI: VISITA: ID DELLA VISITA
*/
--------------------------------------------------------------------------------------

procedure VISUALIZZAVOTOVISITA(visita visitaguidata.idvisita%TYPE) is
    nome_visita visitaguidata.nomevisita%TYPE;
    voto_medio INT;
begin
    SELECT nomevisita into nome_visita from visitaguidata where idvisita = visita;
    SELECT avg(voto) into voto_medio from recensione where idvisita = visita;
    
    GUI.APRIPAGINASTANDARD('Voto medio ' || nome_visita);
        GUI.APRICARD('Voto medio ' || nome_visita);
        GUI.CORPOCARD();
        GUI.P(voto_medio);
        GUI.CHIUDICARD();
    GUI.CHIUDIPAGINASTANDARD('Verde');        
end VISUALIZZAVOTOVISITA;

---------------------------------------------------------------------------------------
/*
VISUALIZZAVOTITUTTI : VISUALIZZA I VOTI MEDI DI TUTTE LE VISITE
*/
--------------------------------------------------------------------------------------

procedure VISUALIZZAVOTITUTTI IS
    v_max INT;
    v_min INT;
    cursor c_visite IS
        SELECT *
        FROM VOTOVISITA
        ORDER BY VOTO_MEDIO DESC;
BEGIN
    GUI.APRIPAGINASTANDARD('Voto medio visite');

    SELECT MAX(VOTO_MEDIO)
    INTO v_max
    FROM VOTOVISITA;

    SELECT MIN(VOTO_MEDIO)
    INTO v_min
    FROM VOTOVISITA;
    
    GUI.APRICARD('Statistiche visite');
    GUI.CORPOCARD();
    GUI.P('Massimo voto medio: ' || v_max);
    GUI.P('Minimo voto medio: ' || v_min);
    GUI.CHIUDICARD();

    GUI.APRITABELLA('Voto medio visite', 1, tableId => 't01');
        GUI.APRIRIGATABELLA();
            GUI.CELLATABELLAHEADER('Nome Visita', 'align = center');
            GUI.CELLATABELLAHEADER('Voto Medio', 'align = center');
        GUI.CHIUDIRIGATABELLA();
        FOR visita IN c_visite
        LOOP
            GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(visita.nomevisita);
                GUI.CELLATABELLA(visita.voto_medio);
            GUI.CHIUDIRIGATABELLA();
        END LOOP;
    GUI.CHIUDITABELLA();
    GUI.CHIUDIPAGINASTANDARD('Verde');
end VISUALIZZAVOTITUTTI;

---------------------------------------------------------------------------------------
/*
PRENOTAZINIVISITA : PERMETTE DI SELEZIONARE UNA VISITA PER MOSTRARE IL NUMERO 
                    MEDIO DI PRENOTAZIONI
*/
--------------------------------------------------------------------------------------

PROCEDURE PRENOTAZIONIVISITA IS
    cursor c_nomi_visite is
                SELECT idvisita, nomevisita 
                FROM visitaguidata;
BEGIN
    GUI.APRIPAGINASTANDARD('Seleziona la visita');

    IF AUTHORIZE.HAPERMESSO(PERMESSO_P  => 'stat')  = false then 
        raise AUTHORIZE.SENZA_PERMESSO;
    END IF;

        GUI.APRIFORM( METODO  => 'get', AZIONE  => 'GVERDE.VISUALIZZAPRENOTAZIONIVISITA');
        GUI.CARDHEADER('Selezione la visita');
        GUI.APRIFIELD( TESTO  => 'Seleziona la visita:', ALLINEAMENTO  => 'center');
        GUI.APRISELECTINPUT('visita', 'visita');
            for nome_visita in c_nomi_visite
            loop
                GUI.OPTION_SELECT(nome_visita.idvisita, nome_visita.nomevisita);
            end loop;

        GUI.CHIUDISELECT();
        GUI.CHIUDIFIELD();
        
        GUI.APRIFIELD(ALLINEAMENTO  => 'center');
            GUI.BTNSUBMIT(id => 'submit', txt => 'Cerca');
        GUI.CHIUDIFIELD();
        GUI.CHIUDIFORM();
    GUI.CHIUDIPAGINASTANDARD('Verde');

    EXCEPTION
        when authorize.SENZA_PERMESSO then gui.ESITOPERAZIONE(ESITO  => 'fallimento' /*IN VARCHAR2*/,
                MESSAGGIO  => 'non hai i permessi necessari per eseguire questa operazione' /*IN VARCHAR2*/);
            GUI.CHIUDIPAGINASTANDARD('Verde');
END PRENOTAZIONIVISITA;

---------------------------------------------------------------------------------------
/*
PRENOTAZIONIVISITA : DATA UNA VISITA VISUALIZZA IL NUMERO MEDIO DI PRENOTAZIONI
PARAMETRI: VISITA : ID DELLA VISITA
*/
--------------------------------------------------------------------------------------

PROCEDURE VISUALIZZAPRENOTAZIONIVISITA(visita visitaguidata.idvisita%TYPE) IS
    nome_visita visitaguidata.nomevisita%TYPE;
    n_prenotazioni INT;
BEGIN
    GUI.APRIPAGINASTANDARD('Numero Prenotazioni Medio ' || nome_visita);

    IF AUTHORIZE.HAPERMESSO(PERMESSO_P  => 'stat')  = false then 
        raise AUTHORIZE.SENZA_PERMESSO;
    END IF;

    SELECT nomevisita into nome_visita from visitaguidata where idvisita = visita;
    SELECT AVG(tmp.my_sum)
    INTO n_prenotazioni
    FROM 
    (
        SELECT SUM(P.NUMEROBIGLIETTI) AS my_sum
        FROM VISITEDISPONIBILI VS
        JOIN VISITAGUIDATA V
        USING (IDVISITA)
        JOIN PRENOTAZIONEVISITA P
        USING (IDVISITA)
        WHERE IDVISITA = visita
        AND P.COSTOTOTALEORDINE = P.QUANTITASALDATA
        GROUP BY VS.IDCROCIERA
    ) tmp;

        GUI.APRICARD('Numero Prenotazioni Medio');
        GUI.CORPOCARD();
        GUI.P(n_prenotazioni);
        GUI.CHIUDICARD();
    GUI.CHIUDIPAGINASTANDARD('Verde');        

    EXCEPTION
        when authorize.SENZA_PERMESSO then gui.ESITOPERAZIONE(ESITO  => 'fallimento' /*IN VARCHAR2*/,
                MESSAGGIO  => 'non hai i permessi necessari per eseguire questa operazione' /*IN VARCHAR2*/);
            GUI.CHIUDIPAGINASTANDARD('Verde');
END VISUALIZZAPRENOTAZIONIVISITA;

---------------------------------------------------------------------------------------
/*
VISUALIZZAPRENOTAZIONITUTTE : VISUALIZZA IL NUMERO MEDIO DI PRENOTAZIONI PER TUTTE VISITE
*/
--------------------------------------------------------------------------------------

PROCEDURE VISUALIZZAPRENOTAZIONITUTTE IS
    cursor c_visite IS
        SELECT V.NOMEVISITA, AVG(tmp.somma) AS media
        FROM 
        (
            SELECT V1.IDVISITA, VS.IDCROCIERA, SUM(PV.NUMEROBIGLIETTI) AS somma
            FROM VISITEDISPONIBILI VS,
                 VISITAGUIDATA V1,
                 PRENOTAZIONEVISITA PV,
                 PRENOTAZIONE P
            WHERE VS.IDVISITA = V1.IDVISITA
            AND V1.IDVISITA = PV.IDVISITA
            AND PV.IDPRENOTAZIONE = P.IDPRENOTAZIONE
            AND P.IDCROCIERA = VS.IDCROCIERA
            AND PV.COSTOTOTALEORDINE = PV.QUANTITASALDATA
            GROUP BY V1.IDVISITA, VS.IDCROCIERA
        ) tmp
        JOIN VISITAGUIDATA V
        USING (IDVISITA)
        GROUP BY IDVISITA, V.NOMEVISITA
        ORDER BY AVG(tmp.somma) DESC;
BEGIN
    GUI.APRIPAGINASTANDARD('Numero Di Prenotazioni Medio');

    IF AUTHORIZE.HAPERMESSO(PERMESSO_P  => 'stat')  = false then 
        raise AUTHORIZE.SENZA_PERMESSO;
    END IF;

    GUI.APRITABELLA('Numero Di Prenotazioni Medio', 1, tableId => 't01');
        GUI.APRIRIGATABELLA();
            GUI.CELLATABELLAHEADER('Nome Visita', 'align = center');
            GUI.CELLATABELLAHEADER('Numero Di Prenotazioni Medio', 'align = center');
        GUI.CHIUDIRIGATABELLA();
        FOR visita IN c_visite
        LOOP
            GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(visita.nomevisita);
                GUI.CELLATABELLA(visita.media);
            GUI.CHIUDIRIGATABELLA();
        END LOOP;
    GUI.CHIUDITABELLA();
    GUI.CHIUDIPAGINASTANDARD('Verde');

    EXCEPTION
        when authorize.SENZA_PERMESSO then gui.ESITOPERAZIONE(ESITO  => 'fallimento' /*IN VARCHAR2*/,
                MESSAGGIO  => 'non hai i permessi necessari per eseguire questa operazione' /*IN VARCHAR2*/);
            GUI.CHIUDIPAGINASTANDARD('Verde');
END VISUALIZZAPRENOTAZIONITUTTE;

---------------------------------------------------------------------------------------
/*
VISUALIZZARICHIESTECAMERE : VISUALIZZA LE TIPOLOGIE DI CAMERA PIU' RICHIESTE
*/
--------------------------------------------------------------------------------------

PROCEDURE VISUALIZZARICHIESTECAMERE IS
    cursor c_tipologie IS
        SELECT TIPOLOGIA, SUM(P.QUANTITA) AS somma
        FROM TIPOCAMERA T
        LEFT JOIN PREPRENOTAZIONE P
        USING (TIPOLOGIA)
        GROUP BY TIPOLOGIA
        ORDER BY SUM(P.QUANTITA) DESC;
BEGIN
    GUI.APRIPAGINASTANDARD('Tipologie di camere più richieste');

    IF AUTHORIZE.HAPERMESSO(PERMESSO_P  => 'stat')  = false then 
        raise AUTHORIZE.SENZA_PERMESSO;
    END IF;

        GUI.APRITABELLA('Tipologie di camere più richieste', 1, tableId => 't01');
            GUI.APRIRIGATABELLA();
                GUI.CELLATABELLAHEADER('Tipologia', 'align = center');
                GUI.CELLATABELLAHEADER('Numero Richieste', 'align = center');
            GUI.CHIUDIRIGATABELLA();
            FOR tipologia IN c_tipologie
            LOOP
                GUI.APRIRIGATABELLA();
                    GUI.CELLATABELLA(tipologia.tipologia);
                    IF tipologia.somma IS NULL
                    THEN
                        GUI.CELLATABELLA('0');
                    ELSE
                        GUI.CELLATABELLA(tipologia.somma);
                    END IF;
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        GUI.CHIUDITABELLA();
    GUI.CHIUDIPAGINASTANDARD('Verde');

    EXCEPTION
        when authorize.SENZA_PERMESSO then gui.ESITOPERAZIONE(ESITO  => 'fallimento' /*IN VARCHAR2*/,
                MESSAGGIO  => 'non hai i permessi necessari per eseguire questa operazione' /*IN VARCHAR2*/);
            GUI.CHIUDIPAGINASTANDARD('Verde');
END VISUALIZZARICHIESTECAMERE;

---------------------------------------------------------------------------------------
/*
MOSTRARECENSIONI : VISUALIZZA LE RECENSIONI EFFETTUATE DALL'UTENTE LOGGATO
*/
--------------------------------------------------------------------------------------

PROCEDURE MOSTRARECENSIONI IS
    cursor c_recensioni(idutente_p BE_SESSIONE.IDUTENTE%TYPE) IS
        SELECT IDTOUR, T.NOMETOUR, IDVISITA, V.NOMEVISITA, IDIMBARCO, R.VOTO
        FROM CLIENTERIFERIMENTO CR
        JOIN PRENOTAZIONE P
        USING (IDPRENOTAZIONE)
        JOIN CROCIERA C
        USING (IDCROCIERA)
        JOIN TOUR T
        USING (IDTOUR)
        JOIN IMBARCO I
        USING (IDPRENOTAZIONE)
        JOIN RECENSIONE R
        USING (IDIMBARCO)
        JOIN VISITAGUIDATA V
        USING (IDVISITA)
        WHERE CR.IDCLIENTE = idutente_p;

        idutente BE_SESSIONE.IDUTENTE%TYPE;
BEGIN
    idutente := AUTHENTICATE.RECUPERA_SESSIONE().IDUTENTE;
    GUI.APRIPAGINASTANDARD('Recensioni Effettuate');
        GUI.APRITABELLA('Recensioni Effettuate', 1, tableId => 't01');
            GUI.APRIRIGATABELLA();
                GUI.CELLATABELLAHEADER('Nome Tour' , 'align = center');
                GUI.CELLATABELLAHEADER('Nome Visita', 'align = center');
                GUI.CELLATABELLAHEADER('Voto', 'align = center');
                GUI.CELLATABELLAHEADER('', 'align = center');
            GUI.CHIUDIRIGATABELLA();
            FOR recensione IN c_recensioni(idutente)
            LOOP
                GUI.APRIRIGATABELLA();
                    GUI.CELLATABELLALINK(recensione.NOMETOUR, LINKTO => Costanti.macchina2 || Costanti.radice || 'BLU.INFOTOUR?id_tour=' || RECENSIONE.IDTOUR);
                    GUI.CELLATABELLALINK(recensione.NOMEVISITA, LINKTO => Costanti.macchina2 || Costanti.radice || 'BLU.INFOVISITA?id_visita=' || RECENSIONE.IDVISITA);
                    GUI.CELLATABELLA(recensione.VOTO);
                    GUI.CELLATABELLABTN(txt => 'Modifica', linkto => Costanti.macchina2 || Costanti.radice || 'GVERDE.SELEZIONAVOTO?visita=' || recensione.idvisita || '&imbarco=' || recensione.idimbarco || '&aggiorna=1');
                    GUI.CELLATABELLABTN(txt => 'Elimina',CONFERMA=>1,ONSUBMIT => 'onclick="if(confirm(`vuoi eliminare la recensione`)){location.href=`'||Costanti.macchina2 || Costanti.radice || 'GVERDE.ELIMINARECENSIONE?visita='|| recensione.idvisita || '&amp;imbarco=' || recensione.idimbarco||'`}"');
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        GUI.CHIUDITABELLA();
    GUI.CHIUDIPAGINASTANDARD('Verde');
END MOSTRARECENSIONI;

---------------------------------------------------------------------------------------
/*
RECENSISCIVISITA : VISUALIZZA LE VISITE DELL'UTENTE LOGGATO CHE NON SONO ANCORA STATE
                   RECENSITE E PERMETTE DI AGGIUNGERE UNA RECENSIONE
*/
--------------------------------------------------------------------------------------

PROCEDURE RECENSISCIVISITA IS
    cursor c_visite(idutente_p BE_SESSIONE.IDUTENTE%TYPE) IS
        SELECT IDTOUR, T.NOMETOUR, V.IDVISITA, V.NOMEVISITA, I.IDIMBARCO
        FROM CLIENTERIFERIMENTO CR
        JOIN PRENOTAZIONE P
        USING (IDPRENOTAZIONE)
        JOIN CROCIERA C
        USING (IDCROCIERA)
        JOIN TOUR T
        USING (IDTOUR)
        JOIN IMBARCO I
        USING (IDPRENOTAZIONE)
        JOIN PRENOTAZIONEVISITA PV
        USING (IDPRENOTAZIONE)
        JOIN VISITAGUIDATA V
        ON PV.IDVISITA = V.IDVISITA
        LEFT JOIN RECENSIONE R
        ON V.IDVISITA = R.IDVISITA
        LEFT JOIN IMBARCO
        ON R.IDIMBARCO = R.IDIMBARCO
        WHERE CR.IDCLIENTE = idutente_p
        AND R.IDVISITA IS NULL
        AND R.IDIMBARCO IS NULL;
        
        idutente BE_SESSIONE.IDUTENTE%TYPE;
BEGIN
    idutente := AUTHENTICATE.RECUPERA_SESSIONE().IDUTENTE;
    GUI.APRIPAGINASTANDARD('Recensici Una Visita');
        GUI.APRITABELLA('Recensisci Una Visita', 1, tableId => 't01');
            GUI.APRIRIGATABELLA();
                GUI.CELLATABELLAHEADER('Nome Tour' , 'align = center');
                GUI.CELLATABELLAHEADER('Nome Visita', 'align = center');
                GUI.CELLATABELLAHEADER('', 'align = center');
            GUI.CHIUDIRIGATABELLA();
            FOR visita IN c_visite(idutente)
            LOOP
                GUI.APRIRIGATABELLA();
                    GUI.CELLATABELLALINK(visita.NOMETOUR, LINKTO => Costanti.macchina2 || Costanti.radice || 'BLU.INFOTOUR?id_tour=' || visita.IDTOUR);
                    GUI.CELLATABELLALINK(visita.NOMEVISITA, LINKTO => Costanti.macchina2 || Costanti.radice || 'BLU.INFOVISITA?id_visita=' || visita.IDVISITA);
                    GUI.CELLATABELLABTN(txt => 'Recensisci', linkto => Costanti.macchina2 || Costanti.radice || 'GVERDE.SELEZIONAVOTO?visita=' || visita.idvisita || '&imbarco=' || visita.idimbarco || '&aggiorna=0');
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        GUI.CHIUDITABELLA();
    GUI.CHIUDIPAGINASTANDARD('Verde');
END RECENSISCIVISITA;

---------------------------------------------------------------------------------------
/*
SELEZIONAVOTO : RICHIEDE ALL'UTENTE L'INSERIMENTO DEL VOTO
PARAMETRI: VISITA : ID DELLA VISITA A CUI SI RIFERISCE IL VOTO
           IMBARCO : ID DELL'IMBARCO
           AGGIORNA : 0 SE SI STA CREANDO UNA NUOVA RECENSIONE
                      1 SE SI STA AGGIORNANDO UNA RECENSIONE
*/
--------------------------------------------------------------------------------------

PROCEDURE SELEZIONAVOTO(visita NUMBER, imbarco NUMBER, aggiorna VARCHAR2) IS
    nome_visita VISITAGUIDATA.NOMEVISITA%TYPE;
    i INT := 1;
BEGIN
    SELECT NOMEVISITA 
    INTO nome_visita
    FROM VISITAGUIDATA
    WHERE IDVISITA = visita;

    GUI.APRIPAGINASTANDARD('Seleziona il voto per la visita ' || nome_visita);
        IF aggiorna = '0'
        THEN
            GUI.APRIFORM( METODO  => 'get', AZIONE  => 'GVERDE.INSERISCIRECENSIONE');
        ELSIF aggiorna = '1'
        THEN
            GUI.APRIFORM( METODO  => 'get', AZIONE  => 'GVERDE.AGGIORNARECENSIONE');
        END IF;
        GUI.CARDHEADER('Inserisci il voto');
        GUI.INPUT_FORM(tipo => 'hidden', id => 'visita', nome => 'visita', valore => visita);
        GUI.INPUT_FORM(tipo => 'hidden', id => 'imbarco', nome => 'imbarco', valore => imbarco);
        GUI.APRIFIELD( TESTO  => 'Inserisci il voto:', ALLINEAMENTO  => 'center');
        GUI.APRISELECTINPUT('voto_i', 'voto');
            while i <= 10
            loop
                GUI.OPTION_SELECT(i, i);
                i := i + 1;
            end loop;
        GUI.CHIUDISELECT();
        GUI.CHIUDIFIELD();
        
        GUI.APRIFIELD(ALLINEAMENTO  => 'center');
            GUI.BTNSUBMIT(id => 'submit', txt => 'Ok');
        GUI.CHIUDIFIELD();
        GUI.CHIUDIFORM();
    GUI.CHIUDIPAGINASTANDARD('Verde');
END SELEZIONAVOTO;

---------------------------------------------------------------------------------------
/*
INSERISCIRECENSIONE : INSERISCE UNA NUOVA RECENSIONE
PARAMETRI: VISITA : ID DELLA VISITA
           IMBARCO : ID DELL'IMBARCO
           VOTO : VOTO DELLA RECENSIONE
*/
--------------------------------------------------------------------------------------

PROCEDURE INSERISCIRECENSIONE(visita NUMBER, imbarco NUMBER, voto_i NUMBER) IS
BEGIN
    GUI.APRIPAGINASTANDARD('Inserimento recensione');
    INSERT INTO RECENSIONE VALUES (imbarco, visita, voto_i);

        GUI.ESITOPERAZIONE('SUCCESSO', 'Recensione aggiunta');
    GUI.CHIUDIPAGINASTANDARD('Verde');
    
    EXCEPTION WHEN OTHERS THEN
            GUI.ESITOPERAZIONE('KO', 'Recensione non inserita');
        GUI.CHIUDIPAGINASTANDARD('Verde');
END INSERISCIRECENSIONE;

---------------------------------------------------------------------------------------
/*
AGGIORNARECENSIONE : AGGIORNA UNA RECENSIONE
PARAMETRI: VISITA : ID DELLA VISITA
           IMBARCO : ID DELL'IMBARCO
           VOTO : VOTO DELLA RECENSIONE
*/
--------------------------------------------------------------------------------------

PROCEDURE AGGIORNARECENSIONE(visita NUMBER, imbarco NUMBER, voto_i NUMBER) IS
BEGIN
    GUI.APRIPAGINASTANDARD('Modifica recensione');

    UPDATE RECENSIONE SET VOTO = voto_i WHERE RECENSIONE.IDIMBARCO = imbarco AND RECENSIONE.IDVISITA = visita;

        GUI.ESITOPERAZIONE('SUCCESSO', 'Recensione modificata');
    GUI.CHIUDIPAGINASTANDARD('Verde');
    
    EXCEPTION WHEN OTHERS THEN
            GUI.ESITOPERAZIONE('KO', 'Recensione non modificata');
        GUI.CHIUDIPAGINASTANDARD('Verde');
END AGGIORNARECENSIONE;

---------------------------------------------------------------------------------------
/*
ELIMINARECENSIONE : ELIMINA UNA RECENSIONE
PARAMETRI: VISITA : ID DELLA VISITA
           IMBARCO : ID DELL'IMBARCO
*/
--------------------------------------------------------------------------------------

PROCEDURE ELIMINARECENSIONE(visita NUMBER, imbarco NUMBER) IS
BEGIN
    GUI.APRIPAGINASTANDARD('Elimina recensione');
    DELETE FROM RECENSIONE WHERE RECENSIONE.IDIMBARCO = imbarco AND RECENSIONE.IDVISITA = visita;

        GUI.ESITOPERAZIONE('SUCCESSO', 'Recensione eliminata');
    GUI.CHIUDIPAGINASTANDARD('Verde');
    
    EXCEPTION WHEN OTHERS THEN
            GUI.ESITOPERAZIONE('KO', 'Recensione non eliminata');
        GUI.CHIUDIPAGINASTANDARD('Verde');
END ELIMINARECENSIONE;

---------------------------------------------------------------------------------------
/*
NUMEROPRENOTAZIONICROCIERE: VISUALIZZA IL NUMERO MEDIO DI PRENOTAZIONI MEDIO PER OGNI TOUR
*/
--------------------------------------------------------------------------------------

PROCEDURE NUMEROPRENOTAZIONICROCIERE IS
    cursor c_tour IS
        SELECT T.NOMETOUR, AVG(tmp.somma) AS media
        FROM 
        (
            SELECT C.IDTOUR, C.IDCROCIERA, COUNT(*) AS somma
            FROM CROCIERA C,
                 PRENOTAZIONE P
            WHERE C.IDCROCIERA = P.IDCROCIERA
            GROUP BY C.IDTOUR, C.IDCROCIERA
        ) tmp
        JOIN TOUR T
        USING (IDTOUR)
        GROUP BY IDTOUR, T.NOMETOUR
        ORDER BY AVG(tmp.somma) DESC;
BEGIN
    GUI.APRIPAGINASTANDARD('Numero di prenotazioni medio per tour');

    IF AUTHORIZE.HAPERMESSO(PERMESSO_P  => 'stat')  = false then 
        raise AUTHORIZE.SENZA_PERMESSO;
    END IF;

        GUI.APRITABELLA('Numero di prenotazioni medio per tour', 1, tableId => 't01');
            GUI.APRIRIGATABELLA();
                GUI.CELLATABELLAHEADER('Nome Tour', 'align = center');
                GUI.CELLATABELLAHEADER('Numero Medio Prenotazioni', 'align = center');
            GUI.CHIUDIRIGATABELLA();
            FOR tour IN c_tour
            LOOP
                GUI.APRIRIGATABELLA();
                    GUI.CELLATABELLA(tour.NOMETOUR);
                    GUI.CELLATABELLA(tour.media);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        GUI.CHIUDITABELLA();
    GUI.CHIUDIPAGINASTANDARD('Verde');

    EXCEPTION
        when authorize.SENZA_PERMESSO then gui.ESITOPERAZIONE(ESITO  => 'fallimento' /*IN VARCHAR2*/,
                MESSAGGIO  => 'non hai i permessi necessari per eseguire questa operazione' /*IN VARCHAR2*/);
            GUI.CHIUDIPAGINASTANDARD('Verde');
END NUMEROPRENOTAZIONICROCIERE;

---------------------------------------------------------------------------------------
/*
NUMEROPRENOTAZIONICLIENTI: VISUALIZZA IL NUMERO DI CROCIERE PRENOTATE DAI CLIENTI
*/
--------------------------------------------------------------------------------------

PROCEDURE NUMEROPRENOTAZIONICLIENTI IS
    cursor c_max_clienti IS
        SELECT *
        FROM PRENCLIENTE
        WHERE QUANTITA >= ALL (SELECT QUANTITA FROM PRENCLIENTE)
        ORDER BY QUANTITA DESC;
    cursor c_clienti IS
        SELECT *
        FROM PRENCLIENTE
        WHERE QUANTITA < ANY (SELECT QUANTITA FROM PRENCLIENTE)
        ORDER BY QUANTITA DESC;
BEGIN
    GUI.APRIPAGINASTANDARD('Numero di prenotazioni effettuate dai clienti');

    IF AUTHORIZE.HAPERMESSO(PERMESSO_P  => 'stat')  = false then 
        raise AUTHORIZE.SENZA_PERMESSO;
    END IF;

        GUI.APRITABELLA('Clienti con il numero massimo di prenotazioni', 1, tableId => 't01');
            GUI.APRIRIGATABELLA();
                GUI.CELLATABELLAHEADER('Nome', 'align = center');
                GUI.CELLATABELLAHEADER('Cognome', 'align = center');
                GUI.CELLATABELLAHEADER('Numero Prenotazioni', 'align = center');
            GUI.CHIUDIRIGATABELLA();
            FOR cliente IN c_max_clienti
            LOOP
                GUI.APRIRIGATABELLA();
                    GUI.CELLATABELLA(cliente.NOME);
                    GUI.CELLATABELLA(cliente.COGNOME);
                    GUI.CELLATABELLA(cliente.quantita);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        GUI.CHIUDITABELLA();

        GUI.APRITABELLA('Numero di prenotazioni effettuate dai restanti clienti', 1, tableId => 't01');
            GUI.APRIRIGATABELLA();
                GUI.CELLATABELLAHEADER('Nome', 'align = center');
                GUI.CELLATABELLAHEADER('Cognome', 'align = center');
                GUI.CELLATABELLAHEADER('Numero Prenotazioni', 'align = center');
            GUI.CHIUDIRIGATABELLA();
            FOR cliente IN c_clienti
            LOOP
                GUI.APRIRIGATABELLA();
                    GUI.CELLATABELLA(cliente.NOME);
                    GUI.CELLATABELLA(cliente.COGNOME);
                    GUI.CELLATABELLA(cliente.quantita);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        GUI.CHIUDITABELLA();
    GUI.CHIUDIPAGINASTANDARD('Verde');

    EXCEPTION
        when authorize.SENZA_PERMESSO then gui.ESITOPERAZIONE(ESITO  => 'fallimento' /*IN VARCHAR2*/,
                MESSAGGIO  => 'non hai i permessi necessari per eseguire questa operazione' /*IN VARCHAR2*/);
            GUI.CHIUDIPAGINASTANDARD('Verde');
END NUMEROPRENOTAZIONICLIENTI;

---------------------------------------------------------------------------------------
/*
PERCENTPRENOTAZIONIFINALI: VISUALIZZA LA PERCENTUALE MEDIA DI PRENOTAZIONI FINALIZZATE
                           PER OGNI TOUR
*/
--------------------------------------------------------------------------------------

PROCEDURE PERCENTPRENOTAZIONIFINALI IS
    cursor c_tour is
        SELECT T.NOMETOUR, AVG(tmp3.percentuale) AS media
        FROM 
        (
            SELECT IDTOUR, IDCROCIERA, 
            CASE
                WHEN tmp1.finalizzate IS NULL THEN 0
                WHEN tmp1.finalizzate IS NOT NULL THEN (tmp1.finalizzate/tmp2.totali * 100) 
            END AS percentuale            
            FROM
            (
                SELECT IDTOUR, IDCROCIERA, COUNT(*) AS finalizzate
                FROM TOUR T1
                JOIN CROCIERA C
                USING(IDTOUR)
                JOIN PRENOTAZIONE P
                USING (IDCROCIERA)
                JOIN IMBARCO I
                USING (IDPRENOTAZIONE)
                GROUP BY IDTOUR, IDCROCIERA
            ) tmp1
            RIGHT JOIN
            (
                SELECT IDTOUR, IDCROCIERA, COUNT(*) AS totali
                FROM TOUR T1
                JOIN CROCIERA C
                USING(IDTOUR)
                JOIN PRENOTAZIONE P
                USING (IDCROCIERA)
                GROUP BY IDTOUR, IDCROCIERA
            ) tmp2
            USING (IDTOUR, IDCROCIERA)
        ) tmp3
        JOIN TOUR T
        USING (IDTOUR)
        GROUP BY IDTOUR, T.NOMETOUR
        ORDER BY AVG(tmp3.percentuale) ASC;

    percentuale INT;
BEGIN
    GUI.APRIPAGINASTANDARD('Numero di prenotazioni finalizzate per tour');

    IF AUTHORIZE.HAPERMESSO(PERMESSO_P  => 'stat')  = false then 
        raise AUTHORIZE.SENZA_PERMESSO;
    END IF;

        GUI.APRITABELLA('Numero di prenotazioni finalizzate per tour', 1, tableId => 't01');
            GUI.APRIRIGATABELLA();
                GUI.CELLATABELLAHEADER('Nome Tour', 'align = center');
                GUI.CELLATABELLAHEADER('Percentuale Prenotazioni Finalizzate', 'align = center');
            GUI.CHIUDIRIGATABELLA();
            FOR tour IN c_tour
            LOOP
                GUI.APRIRIGATABELLA();
                    GUI.CELLATABELLA(tour.NOMETOUR);
                    GUI.CELLATABELLA(tour.media);
                GUI.CHIUDIRIGATABELLA();
            END LOOP;
        GUI.CHIUDITABELLA();
    GUI.CHIUDIPAGINASTANDARD('Verde');

    EXCEPTION
        when authorize.SENZA_PERMESSO then gui.ESITOPERAZIONE(ESITO  => 'fallimento' /*IN VARCHAR2*/,
                MESSAGGIO  => 'non hai i permessi necessari per eseguire questa operazione' /*IN VARCHAR2*/);
            GUI.CHIUDIPAGINASTANDARD('Verde');
END PERCENTPRENOTAZIONIFINALI;

end;
