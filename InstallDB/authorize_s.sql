CREATE OR REPLACE PACKAGE Authorize AS

UTENTE_NON_TROVATO EXCEPTION;
UTENTE_NON_DIPENDENTE EXCEPTION;
RUOLO_NON_TROVATO EXCEPTION;
UTENTE_GIA_ASSUNTO EXCEPTION;
PERMESSO_NON_TROVATO EXCEPTION;
SENZA_PERMESSO EXCEPTION;

-- tipo di ritorno della proceduta getPermessi
TYPE NomiPermessi_t IS TABLE OF Permesso%ROWTYPE;

-- costanti per il tipo dei permessi
tipo_permessi_inserimento constant INT := 0;
tipo_permessi_modifica constant INT := 1;
tipo_permessi_cancellazione constant INT := 2;

-- @Author : Samuele
        /**
                @name : hasPermesso
                @desc : controlla se un utente ha un certo privileggio
                @Args :
                        IDPermesso : int
                @Res  : Vero o Falso o fallimento
                @Excs :
                        UTENTE_NON_DIPENDENTE
                        PERMESSO_NON_TROVATO
                @Uses : Permesso, RuoloPermessi, Ruolo, Sessione, UtenteRuolo
                @Modifies :
        */
        function haPermesso(
                Permesso_p IN Permesso.NOME%TYPE)
        return boolean;

        /**
                @name : daiRuolo
                @desc : da un ruolo a un utente
                @Args :
                        IDSessione : int
                        IDruolo : int
                @Res  : Vero o Falso o fallimento
                @Excs :
                        UTENTE_NON_TROVATO
                        UTENTE_NON_DIPENDENTE
                        RUOLO_NON_TROVATO
                @Uses : Ruolo, Utente, RuoloUtente
                @Modifies : RuoloUtente
        */
        procedure daiRuolo(
                  IDUtente_p IN be_Utente.IDUtente%TYPE,
                  IDRuolo_p IN Ruolo.IDRuolo%TYPE);

        /**
                @name : assumi
                @desc : Fa diventare un utente un interno, quindi puo ricevere ruoli
                @Args :
                        IDUtente : int
                        IDRuolo: int
                @Res  : Successo o Fallimento
                @Excs :
                        UTENTE_NON_TROVATO
                        UTENTE_GIA_ASSUNTO
                @Uses : Utente
                @Modifies : Utente
                 */
        procedure assumi(
                  IDUtente_p IN be_Utente.IDUtente%TYPE);

        /**
                @name : getPermessi
                @desc : ritorna un array di nomi di permessi
                @Args :
                        tipoPermessi : int
                @Res  : NomiPermessi_t
                @Excs :
                @Uses : Sessione, UtenteRuolo, Permesso, RuoloPermessi, Ruolo, Utente
                @Modifies :
        */
        function getPermessi               
        return NomiPermessi_t;

END Authorize;