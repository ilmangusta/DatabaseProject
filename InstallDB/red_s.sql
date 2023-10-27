CREATE OR REPLACE PACKAGE ROSSO AS
        ROOT CONSTANT VARCHAR2(20) := '/apex/borrello.';

        ------------- Luca ------------------

        PROCEDURE FORMNUOVACROCIERA;
        PROCEDURE FORMNUOVAVISITADISPONIBILE;
        PROCEDURE FORMCOSTOMEDIOCROCIERE;

        PROCEDURE INSERISCICROCIERA(
                IDTOUR IN TOUR.IDTOUR%TYPE DEFAULT NULL,
                IDNAVE IN NAVE.IDNAVE%TYPE DEFAULT NULL,
                DATACROCIERA IN VARCHAR2 DEFAULT NULL,
                COSTO IN CROCIERA.COSTOCROCIERA%TYPE DEFAULT NULL
        );

        PROCEDURE INSERISCIVISITADISPONIBILE(
                IDCR IN CROCIERA.IDCROCIERA%TYPE DEFAULT NULL,
                IDVISITA IN VISITAGUIDATA.IDVISITA%TYPE DEFAULT NULL,
                DATAVISITA IN VARCHAR2 DEFAULT NULL
        );
        PROCEDURE DELETEVISITA(
                IDCR IN CROCIERA.IDCROCIERA%TYPE DEFAULT NULL,
                IDV IN VISITAGUIDATA.IDVISITA%TYPE DEFAULT NULL
        );

        PROCEDURE COSTOMEDIO(
                DATACR VARCHAR2
        );

        PROCEDURE CROCIEREDISPONIBILI(
                DOVE IN PORTO.NOMEPORTO%TYPE DEFAULT NULL,
                QUANDO IN VARCHAR2 DEFAULT NULL
        );

        PROCEDURE VISITEDISPONIBILI(
                IDCR IN CROCIERA.IDCROCIERA%TYPE DEFAULT NULL,
                MESE_VISITA IN INTEGER DEFAULT NULL,
                ELIMINA IN INTEGER DEFAULT 0
        );

        PROCEDURE ITINERARIONAVI (
                NOMETOUR IN TOUR.NOMETOUR%TYPE DEFAULT NULL
        );
        PROCEDURE INFOCROCIERA(
                TOUR IN TOUR.IDTOUR%TYPE DEFAULT NULL,
                IDCR IN CROCIERA.IDCROCIERA%TYPE DEFAULT NULL
        );
        PROCEDURE MOSTRACAMERENAVE(
                IDN IN NAVE.IDNAVE%TYPE DEFAULT NULL,
                NOMENAVE IN NAVE.NOMENAVE%TYPE DEFAULT NULL
        );
        PROCEDURE POSTITOTALILIBERICROCIERE(
                IDCR IN CROCIERA.IDCROCIERA%TYPE DEFAULT NULL
        );
        PROCEDURE POSTILIBERICROCIERA(
                IDCR IN CROCIERA.IDCROCIERA%TYPE DEFAULT NULL,
                NOMENAVE IN NAVE.NOMENAVE%TYPE DEFAULT NULL
        );

        PROCEDURE CROCIERAPIUCOSTOSACONNOTTI(
                N_NOTTI IN TOUR.NUMERONOTTI%TYPE DEFAULT 1
        );
        PROCEDURE MESECONPIUVISITE;

        PROCEDURE NAVEPIUCOSTOSA;

        PROCEDURE CROCIEREEFFETTUATEDANAVE (
                IDN IN NAVE.IDNAVE%TYPE DEFAULT NULL
        );
        FUNCTION COSTOBASE(
                IDCR IN CROCIERA.IDCROCIERA%TYPE DEFAULT NULL,
                TIPO IN TIPOCAMERA.TIPOLOGIA%TYPE DEFAULT NULL
        ) RETURN NUMBER;

        PROCEDURE CROCIERAMAXVISITE;

        PROCEDURE LISTACROCIEREPERMESE(
                DATACR IN CROCIERA.DATACROCIERA%TYPE DEFAULT NULL
        );

    ----------------- Gabriele ---------------

        -- API
        PROCEDURE get_boats;

        PROCEDURE put_boat(
                p_Nome in NAVE.NOMENAVE%TYPE,
                p_Lunghezza in NAVE.LUNGHEZZA%TYPE,
                p_LARGHEZZA in NAVE.LARGHEZZA%TYPE,
                p_altezza in NAVE.ALTEZZA%TYPE,
                p_peso in NAVE.PESO%TYPE,
                p_descrizione in NAVE.DESCRIZIONE%TYPE
        );
        PROCEDURE delete_boat(
                p_idnave IN NAVE.IDNAVE%TYPE
        );
        PROCEDURE modify_boat (
                p_idnave in NAVE.IDNAVE%TYPE,
                p_Nome in NAVE.NOMENAVE%TYPE,
                p_Lunghezza in NAVE.LUNGHEZZA%TYPE,
                p_LARGHEZZA in NAVE.LARGHEZZA%TYPE,
                p_altezza in NAVE.ALTEZZA%TYPE,
                p_peso in NAVE.PESO%TYPE,
                p_descrizione in NAVE.DESCRIZIONE%TYPE
        );
        PROCEDURE put_cabins(
                p_idnave NAVE.IDNAVE%TYPE,
                p_n integer,
                p_tipologia TIPOCAMERA.TIPOLOGIA%TYPE,
                p_costo TIPOCAMERA.COSTO%TYPE,
                p_piano TIPOCAMERA.PIANONAVE%TYPE
        );
        PROCEDURE delete_cabins(
                p_idnave NAVE.IDNAVE%TYPE,
                p_n INTEGER,
                p_tipologia TIPOCAMERA.TIPOLOGIA%TYPE
        );
        PROCEDURE modify_cabins(
                p_tipologia TIPOCAMERA.TIPOLOGIA%TYPE,
                p_costo     TIPOCAMERA.COSTO%TYPE,
                p_pianonave TIPOCAMERA.PIANONAVE%TYPE
        );
        PROCEDURE get_boatCabins(
                p_idnave NAVE.IDNAVE%TYPE
        );
        PROCEDURE posti_occupati(
                p_IDTOUR TOUR.IDTOUR%TYPE DEFAULT NULL
        );
        PROCEDURE scelta_cabina(
                p_IDTOUR IN TOUR.IDTOUR%TYPE DEFAULT NULL
        );
        PROCEDURE lingua_parlata;
        PROCEDURE room_Avail(
                p_id IN CAMERA.IDCAMERA%TYPE,
                p_val IN CAMERA.ISDISPONIBILE%TYPE
        );
        PROCEDURE get_Types;
        PROCEDURE del_room(
                p_id CAMERA.IDCAMERA%TYPE
        );
        PROCEDURE get_type_rooms(
                p_idnave IN NAVE.IDNAVE%TYPE,
                p_tipologia IN TIPOCAMERA.TIPOLOGIA%TYPE
        );
        PROCEDURE occupiedNTimes(
                p_n IN NUMBER
        );
        PROCEDURE allRoomsBook(
                p_ratio IN NUMBER
        );



        -- API USERS
        PROCEDURE inserisciNavi;
        PROCEDURE inserisciCabine(
                p_idNave NAVE.IDNAVE%TYPE
        );
        PROCEDURE quantiParlano;
        PROCEDURE tipologiaMigliore;
        PROCEDURE tourMigliori;
        PROCEDURE cabine(
                p_idNave NAVE.IDNAVE%TYPE
        );
        PROCEDURE navi;
        PROCEDURE quanteMultiple;
        PROCEDURE quanteSopraMedia;

END ROSSO;
/

