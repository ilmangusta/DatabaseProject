-------Author: Fabiana Chericoni--------------
CREATE OR REPLACE VIEW CLIENTEVISITARECENSIONE AS
    SELECT IDCLIENTE,IDVISITA,VOTO
    FROM RECENSIONE R INNER JOIN IMBARCO I USING (IDIMBARCO);

CREATE OR REPLACE VIEW VISITECLIENTE AS
    SELECT IDCLIENTE, IDPRENOTAZIONE, IDVISITA
    FROM CLIENTERIFERIMENTO INNER JOIN PRENOTAZIONEVISITA USING (IDPRENOTAZIONE);

-------Author: Samuele Boldrini---------------
CREATE OR REPLACE VIEW PRENCLIENTE AS
    SELECT C.NOME, C.COGNOME, COUNT(*) AS quantita
    FROM BE_UTENTE C 
    JOIN PRENOTAZIONE P
    ON C.IDUTENTE = P.IDCLIENTE
    GROUP BY IDCLIENTE, C.NOME, C.COGNOME;
    
CREATE OR REPLACE VIEW VOTOVISITA AS
    SELECT V.NOMEVISITA, AVG(R.VOTO) AS voto_medio
    FROM VISITAGUIDATA V
    JOIN RECENSIONE R
    USING (IDVISITA)
    GROUP BY IDVISITA, V.NOMEVISITA;