-------Author: Fabiana Chericoni--------------

CREATE OR REPLACE TRIGGER MODIFICARECENSIONE
AFTER UPDATE ON RECENSIONE
FOR EACH ROW
WHEN ((OLD.VOTO - NEW.VOTO) > 2)
DECLARE

CLIENTEANOMALO NUMBER;
  
BEGIN

    SELECT IDCLIENTE
    INTO CLIENTEANOMALO
    FROM RECENSIONE INNER JOIN IMBARCO USING (IDIMBARCO)
    WHERE IDIMBARCO=:OLD.IDIMBARCO AND IDVISITA=:OLD.IDVISITA;
    
    INSERT INTO RECENSIONEANOMALA VALUES (CLIENTEANOMALO,:OLD.IDVISITA,:OLD.VOTO,:NEW.VOTO);
  
END;
/

CREATE OR REPLACE TRIGGER REGISTRA_MODIFICHE_CLIENTE
AFTER UPDATE OF INFORMAZIONIPAGAMENTO ON BE_UTENTE
FOR EACH ROW
BEGIN
    INSERT INTO LOGCLIENTE (idcliente, campomodificato, valoreprecedente, valorenuovo, datamodifica)
    VALUES (:NEW.idutente, 'INFORMAZIONIPAGAMENTO', :OLD.INFORMAZIONIPAGAMENTO, :NEW.INFORMAZIONIPAGAMENTO, SYSDATE);
END;
/

-------Author: Samuele Boldrini--------------

CREATE OR REPLACE TRIGGER CREAIMBARCO
AFTER UPDATE ON PRENOTAZIONE
FOR EACH ROW
WHEN (new.QUANTITASALDATA = new.COSTOBASE)
DECLARE
    type clienti_t IS TABLE OF CLIENTERIFERIMENTO.IDCLIENTE%TYPE;

    clienti clienti_t := clienti_t();

    clienti_i INTEGER;
    camere_i INTEGER;

    n_clienti INTEGER;

    n_imbarchi INTEGER;
BEGIN
    clienti_i := 1;
    FOR CLIENTE IN
    (
        SELECT *
        FROM CLIENTERIFERIMENTO C
        WHERE C.IDPRENOTAZIONE = :new.IDPRENOTAZIONE
    ) LOOP
        clienti.extend;
        clienti(clienti_i) := CLIENTE.IDCLIENTE;
        clienti_i := clienti_i + 1;
    END LOOP;

    clienti_i := 1;
    FOR PRE IN
    (
        SELECT *
        FROM PREPRENOTAZIONE P
        WHERE P.IDPRENOTAZIONE = :new.IDPRENOTAZIONE
    )
    LOOP
        camere_i := 1;

        FOR CAMERA_P IN
        (
            SELECT CA.IDCAMERA, IDNAVE, CA.TIPOLOGIA, CA.ISDISPONIBILE
            FROM CAMERA CA
            JOIN NAVE N
            USING (IDNAVE)
            JOIN CROCIERA CR
            USING (IDNAVE)
            WHERE CA.TIPOLOGIA = PRE.TIPOLOGIA
            AND CR.IDCROCIERA = :new.IDCROCIERA
        ) LOOP
            n_clienti := 0;
            EXIT WHEN (camere_i > PRE.QUANTITA);

            IF (PRE.TIPOLOGIA = 'Singola')
            THEN
                n_clienti := 1;
            ELSIF (PRE.TIPOLOGIA = 'Doppia')
            THEN
                n_clienti := 2;
            ELSIF (PRE.TIPOLOGIA = 'Tripla')
            THEN
                n_clienti := 3;
            END IF;
            camere_i := camere_i + 1;

            FOR i IN 1 .. n_clienti
            LOOP
                EXIT WHEN (clienti_i > clienti.count);
                INSERT INTO IMBARCO VALUES (IDIMBARCOSEQ.NEXTVAL, CAMERA_P.IDCAMERA, PRE.IDPRENOTAZIONE, clienti(clienti_i));
                clienti_i := clienti_i + 1;
            END LOOP;

            UPDATE CAMERA SET ISDISPONIBILE = 0 WHERE CAMERA.IDCAMERA = CAMERA_P.IDCAMERA;
        END LOOP;
    END LOOP;
END;
/
