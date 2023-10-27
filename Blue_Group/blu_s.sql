CREATE OR REPLACE package BLU as

    procedure apriformvisite;

    procedure mostravisitelocalita(
            localita in LOCALITA.POSGEOGRAFICA%TYPE default null
    );

    procedure mostravisiteluogo (
        luogo in luogointeresse.nomeluogointeresse%type, 
        idluogo in LUOGOINTERESSE.IDLUOGOINTERESSE%type DEFAULT NULL
    );

    procedure infotour(
        id_tour tour.idtour%type
    );

    procedure infovisita(id_visita VISITAGUIDATA.IDVISITA%type);

    procedure localitadistanza (
        in_porto in PORTO.POSGEOGRAFICA%TYPE DEFAULT null
    );

    procedure portodipartenza;

    LOCALITA_NON_TROVATA EXCEPTION;
    

    procedure visitacostomax;
    procedure localitalontana(
        in_porto in PORTO.POSGEOGRAFICA%TYPE DEFAULT null,
        in_distanza in number DEFAULT null
    );
    PROCEDURE visitaconpiulingue; 
    procedure localitapiuvista;

    procedure nuovotour( in_nometour tour.NOMETOUR%TYPE, in_numeronotti tour.NUMERONOTTI%type, in_numerotappe tour.NUMEROTAPPE%type);
    procedure nuovatappa(in_idtour tour.IDTOUR%type DEFAULT 1, in_listaporti varchar2 DEFAULT 'Livorno', in_numerotappe tour.NUMEROTAPPE%type DEFAULT 1);
    procedure formtour;
    procedure formtappa(in_idtour tour.IDTOUR%type, in_numerotappe tour.NUMERONOTTI%type);


    --visita con costo massimo
    --ok localita più cara
    --ok localita più lontana o più lontana di un tot 
    --ok visite con più lingue diverse
    --visite più prenotate
    --tour più scelto da crociere


end BLU;