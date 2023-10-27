CREATE OR REPLACE PACKAGE BODY Authorize AS

       FUNCTION haPermesso( Permesso_p IN Permesso.NOME%TYPE)
       RETURN boolean
       IS
            IDSessione_v Sessione.IDSessione%TYPE := AUTHENTICATE.RECUPERA_SESSIONE().IDSessione;
            privilegiato INT;
            res INT;
       BEGIN
            SELECT EPrivilegiato INTO privilegiato FROM Sessione WHERE IDSessione = IDSessione_v;

            SELECT count(Permesso.NOME)
            INTO res
            FROM Sessione
            JOIN UtenteRuolo ON Sessione.IDUtente = UtenteRuolo.IDUtente
            JOIN Ruolo ON UtenteRuolo.IDRuolo = Ruolo.IDRuolo
            JOIN RuoloPermesso ON Ruolo.IDRuolo = RuoloPermesso.IDRuolo
            JOIN Permesso ON RuoloPermesso.NOMEPERMESSO = Permesso.NOMe
            WHERE Sessione.IDSessione = IDSessione_v AND Permesso.NOMe = Permesso_p;

            if privilegiato = 0 then
                return FALSE;
            end if;

            if res >= 1 then
                return TRUE;
            else
                return FALSE;
            end if;
       END haPermesso;


       PROCEDURE daiRuolo(
                  IDUtente_p IN be_Utente.IDUtente%TYPE,
                  IDRuolo_p IN Ruolo.IDRuolo%TYPE)
       IS
           privilegiato INT;
           ruolo_v Ruolo.IDRuolo%TYPE;
       BEGIN

            SELECT EPrivilegiato INTO privilegiato FROM be_Utente WHERE IDUtente = IDUtente_p;
            SELECT IDRuolo INTO ruolo_v FROM Ruolo WHERE IDRuolo = IDRuolo_p;

            if privilegiato IS NULL then
                raise UTENTE_NON_TROVATO;
            end if;

            if ruolo_v IS NULL then
                raise RUOLO_NON_TROVATO;
            end if;

            if privilegiato = 0 then
               raise UTENTE_NON_DIPENDENTE;
            end if;

            INSERT INTO UtenteRuolo VALUES (IDUtente_p, IDRuolo_p);
       END daiRuolo;


       PROCEDURE assumi(
                 IDUtente_p IN be_Utente.IDUtente%TYPE)
       IS
            privilegiato INT;
       BEGIN
            SELECT EPrivilegiato INTO privilegiato FROM be_Utente WHERE IDUtente = IDUtente_p;

            if privilegiato IS NULL then
                raise UTENTE_NON_TROVATO;
            end if;

            if privilegiato = 1 then
                raise UTENTE_GIA_ASSUNTO;
            end if;

            UPDATE be_Utente
            SET EPrivilegiato = 1
            WHERE IDUtente = IDUtente_p;
       END assumi;


       FUNCTION getPermessi
       RETURN NomiPermessi_t
       IS
            IDSessione_v Sessione.IDSessione%TYPE := AUTHENTICATE.RECUPERA_SESSIONE().IDSessione;
            nomiPermessi NomiPermessi_t := NomiPermessi_t();
            counter integer := 1;
            cursor permessi_c (IDSessione Sessione.IDSessione%TYPE) is
                 SELECT DISTINCT Permesso.Nome
                 FROM Sessione
                 JOIN UtenteRuolo ON Sessione.IDUtente = UtenteRuolo.IDUtente
                 JOIN Ruolo ON UtenteRuolo.IDRuolo = Ruolo.IDRuolo
                 JOIN RuoloPermesso ON Ruolo.IDRuolo = RuoloPermesso.IDRuolo
                 JOIN Permesso ON RuoloPermesso.NOMEPERMESSO = Permesso.NOME
                 WHERE Sessione.IDSessione = IDSessione;
       BEGIN
            for elem in permessi_c (IDSessione_v) loop
                 nomiPermessi.extend;
                 nomiPermessi(counter) := elem;
                 counter := counter + 1;
            end loop;

            return nomiPermessi;
       END getPermessi;
END Authorize;