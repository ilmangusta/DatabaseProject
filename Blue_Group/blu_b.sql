CREATE OR REPLACE package body BLU as


    procedure apriformvisite is
        /*
        apre form per ricerca delle visite riguardanti i luoghi di interesse della localita desiderata
        */
        BEGIN
            GUI.APRIPAGINASTANDARD();
            GUI.APRIFORM(CLASSE  => 'form card', METODO  => 'get',AZIONE => 'blu.mostravisitelocalita');
            GUI.CARDHEADER(TITOLO  => 'Trova le visite nella località interessata' ,LOGO  => 1  );
            GUI.APRIFIELD(CLASSE  => 'field'  ,
                          TESTO  => 'Cosa vuoi visitare?'  ,
                          ALLINEAMENTO  => 'center'  );
            GUI.APRISELECTINPUT(NOME  => 'localita'  ,
                                ID  => 'localita'  );
            for nome_localita in (SELECT DISTINCT NOMELOCALITA, POSGEOGRAFICA FROM LOCALITA) loop
                GUI.OPTION_SELECT(VALORE  => nome_localita.POSGEOGRAFICA  ,
                                     TESTO  => nome_localita.NOMELOCALITA  );
            end loop;
            GUI.CHIUDISELECT();
            GUI.CHIUDIFIELD();
            GUI.APRIFIELD(CLASSE  => 'field',
                          TESTO  => '',
                          ALLINEAMENTO  => 'ceter' );
                GUI.BTNSUBMIT(txt => 'Cerca');
                GUI.BTNRESET(txt => 'Cancella');
            GUI.CHIUDIFIELD();
            GUI.CHIUDIFORM();
            GUI.CHIUDIPAGINASTANDARD('gruppo blu');


    end apriformvisite;


    procedure mostravisitelocalita(
            localita in LOCALITA.POSGEOGRAFICA%TYPE default null) is

    /*
    cerca tutti i luohi per la localita desiderata
    */
            v_found BOOLEAN := FALSE;
            v_foundcheck NUMBER := 0;
        begin

            GUI.APRIPAGINASTANDARD;

            select count(*) into v_foundcheck
            from LUOGOINTERESSE li inner join LUOGOVISITA lv on li.IDLUOGOINTERESSE = lv.IDLUOGOINTERESSE
            where li.POSGEOGRAFICA = localita;
            if (v_foundcheck <> 0) then
            for luogo in (select lg.IDLUOGOINTERESSE, lg.NOMELUOGOINTERESSE
                from LOCALITA lc, LUOGOINTERESSE lg
                where lc.POSGEOGRAFICA = lg.POSGEOGRAFICA
                and lc.POSGEOGRAFICA = localita
                )
                loop
                    v_found := true;
                    mostravisiteluogo (luogo => luogo.NOMELUOGOINTERESSE, idluogo => luogo.IDLUOGOINTERESSE);

                end loop;

            else
                GUI.ESITOPERAZIONE(ESITO  => 'FALLITO' /*IN VARCHAR2*/,
                                    MESSAGGIO  => 'nessuna visita trovata per quesa località' /*IN VARCHAR2*/);
            end if;


            GUI.CHIUDIPAGINASTANDARD('blu');

        end mostravisitelocalita;


    procedure mostravisiteluogo (luogo in luogointeresse.nomeluogointeresse%type, idluogo in LUOGOINTERESSE.IDLUOGOINTERESSE%type DEFAULT NULL) IS
    /*
    mostra le visite relative al luogo di interesse desiderato
    */
        v_idluogo LUOGOINTERESSE.IDLUOGOINTERESSE%type;
        begin
            if idluogo is not null then
                v_idluogo := idluogo;
            else
                SELECT IDLUOGOINTERESSE into v_idluogo from LUOGOINTERESSE where NOMELUOGOINTERESSE = luogo;
                GUI.APRIPAGINASTANDARD;
            end if;

            GUI.APRITABELLA(titolo => 'visite che interessano ' || luogo, dimTitolo => 2 );
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLAHEADER(VAL  => 'Nome visita');
            GUI.CELLATABELLAHEADER(VAL  => 'Durata');
            GUI.CELLATABELLAHEADER(VAL  => 'Costo');

            GUI.CHIUDIRIGATABELLA();

                    for visita in (select v.nomevisita,v.DURATAVISITA,v.COSTOVISITA,v.ISDISPONIBILE
                             from VISITAGUIDATA v, luogovisita lv where v.IDVISITA = lv.IDVISITA and lv.idluogointeresse = v_idluogo order by v.COSTOVISITA)
                    loop
                    if visita.ISDISPONIBILE = 1 then
                        GUI.APRIRIGATABELLA();
                        GUI.CELLATABELLA(VAL  => visita.nomevisita);
                        GUI.CELLATABELLA(VAL  => visita.DURATAVISITA);
                        GUI.CELLATABELLA(VAL  => visita.COSTOVISITA);
                        GUI.CHIUDIRIGATABELLA();
                    end if;
                    end loop;
            GUI.CHIUDITABELLA;


            if idluogo is null then
                GUI.CHIUDIPAGINASTANDARD('blu');
            end if;



        end mostravisiteluogo;

    procedure infotour(id_tour tour.idtour%type) is
    /*
    mostra le informazioni su un tour e le relative tappe, con possibile collegamento a mostravisitelocalita
    */
        v_nome tour.nometour%type;
        v_numnotti tour.NUMERONOTTI%type;
        v_numtappe tour.NUMEROTAPPE%type;
        BEGIN
            select NOMETOUR, NUMERONOTTI, numerotappe into v_nome, v_numnotti, v_numtappe from tour where IDTOUR = id_tour;
            GUI.APRIPAGINASTANDARD();
            GUI.APRITABELLA(titolo => 'Informazioni tour ' || v_nome, dimTitolo => 1 );
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLAHEADER(VAL  => 'Numero di notti');
            GUI.CELLATABELLAHEADER(VAL  => 'Numero di tappe');
            GUI.CHIUDIRIGATABELLA();
            GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(VAL  => v_numnotti);
                GUI.CELLATABELLA(VAL  => v_numtappe);
            GUI.CHIUDIRIGATABELLA();
            GUI.CHIUDITABELLA();
            htp.p('<br>');
            htp.p('<br>');
            GUI.APRITABELLA(TITOLO => 'Tappe del tour ' || v_nome, dimTitolo => 2 );
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLAHEADER(VAL  => 'Nome porto');
            GUI.CELLATABELLAHEADER(VAL  => 'Numero di tappa');
            GUI.CHIUDIRIGATABELLA();
            for porto in (select p.nomeporto, p.POSGEOGRAFICA, i.ordine from include i inner join porto p on i.POSGEOGRAFICA = p.POSGEOGRAFICA where i.idtour = id_tour)
            loop
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLALINK(TXT  => porto.NOMEPORTO, LINKTO => COSTANTI.macchina2 || COSTANTI.radice || 'blu.localitadistanza?in_porto='||porto.POSGEOGRAFICA);
                GUI.CELLATABELLA(VAL  => porto.ordine);
                GUI.CHIUDIRIGATABELLA();
            end loop;

            GUI.CHIUDIRIGATABELLA();
            GUI.CHIUDITABELLA();
            GUI.CHIUDIPAGINASTANDARD('blu');
        end infotour;

    procedure infovisita(id_visita VISITAGUIDATA.IDVISITA%type) IS
        /*
        mostra le informazioni della visita desidereta
        */
        v_nomevisita VISITAGUIDATA.NOMEVISITA%type;
        v_duratavisita VISITAGUIDATA.DURATAVISITA%type;
        v_costovisita VISITAGUIDATA.COSTOVISITA%type;
        begin

            SELECT NOMEVISITA,DURATAVISITA, COSTOVISITA into v_nomevisita, v_duratavisita, v_costovisita from VISITAGUIDATA where IDVISITA = id_visita;

            GUI.APRIPAGINASTANDARD();

            gui.APRICARD(INTESTAZIONE  => 'informazioni su '|| v_nomevisita );
            gui.CORPOCARD();
            gui.P(TESTO  => 'durata della visita: ' || v_duratavisita);
            gui.P(TESTO  => 'costo della visita: ' || v_costovisita);
            gui.CHIUDICARD(FOOTER  => '');


            GUI.APRITABELLA(titolo => 'luoghi che interessano la visita ' || v_nomevisita , dimTitolo => 2 );
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLAHEADER(VAL  => 'Nome luogo');
            GUI.CELLATABELLAHEADER(VAL  => 'Posizione geografica');
            GUI.CELLATABELLAHEADER(VAL  => 'Tipologia');
            GUI.CHIUDIRIGATABELLA();
            for luogo in (select li.NOMELUOGOINTERESSE, li.POSGEOGRAFICA, li.TIPOLOGIA from LUOGOVISITA lv, LUOGOINTERESSE li where lv.IDVISITA = id_visita and lv.IDLUOGOINTERESSE = li.IDLUOGOINTERESSE)
            loop
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(VAL  => luogo.NOMELUOGOINTERESSE);
                GUI.CELLATABELLA(VAL  => luogo.POSGEOGRAFICA);
                GUI.CELLATABELLA(VAL  => luogo.TIPOLOGIA);
                GUI.CHIUDIRIGATABELLA();
            end loop;
            GUI.CHIUDITABELLA();

            GUI.CHIUDIPAGINASTANDARD('blu');
        end infovisita;


        procedure localitadistanza( in_porto in PORTO.POSGEOGRAFICA%TYPE DEFAULT null) IS
        /*
        mostra le localita raggiungibili dal porto desiderato
        */

            v_porto PORTO.NOMEPORTO%TYPE;
        BEGIN
            select NOMEPORTO into v_porto
            from PORTO
            where POSGEOGRAFICA = in_porto;


            GUI.APRIPAGINASTANDARD();
            GUI.APRITABELLA(titolo => 'Località raggiungibili dal porto di '|| v_porto, dimTitolo => 2 );
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLAHEADER(VAL  => 'Nome località');
            GUI.CELLATABELLAHEADER(VAL  => 'Distanza');
            GUI.CHIUDIRIGATABELLA();
            for localita in (SELECT DISTINCT l.NOMELOCALITA, r.DISTANZA, l.POSGEOGRAFICA FROM RAGGIUNGE r, LOCALITA l where r.POSGEOGRAFICALOCALITA=l.POSGEOGRAFICA and r.POSGEOGRAFICAPORTO = in_porto and l.POSGEOGRAFICA <> in_porto order by DISTANZA)
            loop
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLALINK(TXT  => localita.NOMELOCALITA, LINKTO => COSTANTI.macchina2 || COSTANTI.radice || 'blu.mostravisitelocalita?localita='||LOCALITA.POSGEOGRAFICA);
                GUI.CELLATABELLA(VAL  => localita.DISTANZA);
                GUI.CHIUDIRIGATABELLA();
            end loop;
            GUI.CHIUDITABELLA();
            htp.p('<br>');
            GUI.CHIUDIPAGINASTANDARD('blu');

        EXCEPTION
            when no_data_found then gui.ESITOPERAZIONE(ESITO  => 'fallito' /*IN VARCHAR2*/,
                                                       MESSAGGIO  => 'nessun porto trovato' || in_porto /*IN VARCHAR2*/);
        end localitadistanza;

-----------------------------------------------------------------------------------------------------------------------------------


        procedure localitapiuvista is
        /*
        mostra la localita con il relativo numero di visite
        */
        v_numerovisite number;
        begin
            GUI.APRIPAGINASTANDARD();
            GUI.APRITABELLA(titolo => 'Località più visitate', dimTitolo => 2 );
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLAHEADER(VAL  => 'Posizione geografica');
            GUI.CELLATABELLAHEADER(VAL  => 'Nome Località');
            GUI.CELLATABELLAHEADER(VAL  => 'Numero visite');
            GUI.CHIUDIRIGATABELLA();
            for LOCALITA in (select count(lv.IDVISITA) as numero, li.POSGEOGRAFICA, lc.NOMELOCALITA
                from VISITAGUIDATA vg
                    inner join LUOGOVISITA lv on vg.IDVISITA = lv.IDVISITA
                    RIGHT join LUOGOINTERESSE li on lv.IDLUOGOINTERESSE = li.IDLUOGOINTERESSE
                    inner join LOCALITA lc on li.POSGEOGRAFICA=lc.POSGEOGRAFICA
                group by li.POSGEOGRAFICA, lc.NOMELOCALITA
                order by numero desc)
            loop

                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(VAL  => LOCALITA.POSGEOGRAFICA);
                GUI.CELLATABELLA(VAL  => LOCALITA.NOMELOCALITA);
                GUI.CELLATABELLA(VAL  => LOCALITA.numero);
                GUI.CHIUDIRIGATABELLA();
            end loop;
            GUI.CHIUDITABELLA();
            GUI.CHIUDIPAGINASTANDARD('blu');



        end localitapiuvista;

        procedure portodipartenza is
        /*
        mostra i porti di partenza con il relativo numero di tour che partono da quel porto
        */
        begin

            GUI.APRIPAGINASTANDARD();
            GUI.APRITABELLA(titolo => 'Porti più popolari', dimTitolo => 2 );
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLAHEADER(VAL  => 'Nome porto');
            GUI.CELLATABELLAHEADER(VAL  => 'Numero di tour');
            GUI.CHIUDIRIGATABELLA();
            for porto in (select p.NOMEPORTO, count(*) as numero_tour
                                 from TOUR t
                                inner join include i on t.IDTOUR = i.IDTOUR
                                inner join porto p on i.POSGEOGRAFICA = p.POSGEOGRAFICA
                            where i.ORDINE = 1
                            group by p.POSGEOGRAFICA, p.NOMEPORTO
                            order by count(*) desc)
            loop
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(VAL  => porto.NOMEPORTO);
                GUI.CELLATABELLA(VAL  => porto.numero_tour);
                GUI.CHIUDIRIGATABELLA();
            end loop;


        end portodipartenza;

        PROCEDURE visitacostomax is
        /*
        mostra la localita con il costo medio delle visite più alto
        */
        v_posgeografica LOCALITA.POSGEOGRAFICA%type;
        v_nomelocalita LOCALITA.NOMELOCALITA%type;
        v_costo number;
        BEGIN

            GUI.APRIPAGINASTANDARD();
            GUI.APRITABELLA(titolo => 'Località più costose', dimTitolo => 2 );
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLAHEADER(VAL  => 'Posizione geografica');
            GUI.CELLATABELLAHEADER(VAL  => 'Nome località');
            GUI.CELLATABELLAHEADER(VAL  => 'Costo medio');
            GUI.CHIUDIRIGATABELLA();
            for visita in (SELECT v.posgeografica, v.nomelocalita, floor(avg(v.COSTOVISITA)) as costo
                            from visiteperlocalita v
                            GROUP by v.POSGEOGRAFICA, v.NOMELOCALITA
                                having avg(v.COSTOVISITA) > all (
                                    select avg(v1.COSTOVISITA)
                                    from VISITEPERLOCALITA V1
                                    where v1.POSGEOGRAFICA <> v.posgeografica
                                    group by v1.POSGEOGRAFICA
                                )) loop 
            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLA(VAL  => visita.posgeografica);
            GUI.CELLATABELLA(VAL  => visita.nomelocalita);
            GUI.CELLATABELLA(VAL  => visita.costo);
            GUI.CHIUDIRIGATABELLA();
            end loop;
            GUI.CHIUDITABELLA();
            GUI.CHIUDIPAGINASTANDARD('blu');

        end visitacostomax;

    procedure localitalontana( in_porto porto.POSGEOGRAFICA%type DEFAULT null, in_distanza  in number DEFAULT null)is
    /*
    mostra la visita più lontana da un determinato porto, se viene specificata una distana mostra tutte le visite più lontante di quella distanza
    */
        
        v_nomeporto PORTO.NOMEPORTO%type;
        v_distanza number;
        v_in_distanza number;
        v_check number := 0;
    begin
        GUI.APRIPAGINASTANDARD();
        if in_distanza is null then
            v_in_distanza := 0;
        else
            v_in_distanza := to_number(trim(in_distanza));
        end if;

        if v_in_distanza > 0 then
            SELECT count(*) into v_check
            from distanzaporti d
            where d.distanza > v_in_distanza
                AND d.POSGEOGRAFICAPORTO = in_porto;
            if v_check = 0 then
                raise no_data_found;
            end if;
        end if;
            select NOMEPORTO into v_nomeporto
            from porto 
            where POSGEOGRAFICA = in_porto;
        GUI.APRITABELLA(titolo => 'Località più lontana dal porto di ' || v_nomeporto, dimTitolo => 2 );
        GUI.APRIRIGATABELLA();
        GUI.CELLATABELLAHEADER(VAL  => 'Posizione geografica localita');
        GUI.CELLATABELLAHEADER(VAL  => 'Nome località');
        GUI.CELLATABELLAHEADER(VAL  => 'Posizione geografica porto');
        GUI.CELLATABELLAHEADER(VAL  => 'Nome porto');
        GUI.CELLATABELLAHEADER(VAL  => 'Distanza');
        GUI.CHIUDIRIGATABELLA();

        IF v_in_distanza = 0 then
            for LOCALITA in (
                            SELECT d.POSGEOGRAFICALOCALITA, d.NOMELOCALITA, d.POSGEOGRAFICAPORTO, d.NOMEPORTO, d.DISTANZA
                            from distanzaporti d
                            where d.POSGEOGRAFICAPORTO = in_porto and
                                    d.distanza >= all (
                                        select d1.distanza
                                        from DISTANZAPORTI d1
                                        where d1.POSGEOGRAFICAPORTO = d.POSGEOGRAFICAPORTO
                                    )
                            ) loop

            GUI.APRIRIGATABELLA();
            GUI.CELLATABELLA(VAL  => localita.posgeograficalocalita);
            GUI.CELLATABELLA(VAL  => localita.nomelocalita);
            GUI.CELLATABELLA(VAL  => localita.posgeograficaporto);
            GUI.CELLATABELLA(VAL  => v_nomeporto);
            GUI.CELLATABELLA(VAL  => localita.distanza);
            GUI.CHIUDIRIGATABELLA();
            end loop;
        ELSIF v_in_distanza > 0 then
            for localita in (
                    SELECT d.POSGEOGRAFICALOCALITA, d.NOMELOCALITA, d.POSGEOGRAFICAPORTO, d.NOMEPORTO, d.DISTANZA
                    from distanzaporti d
                    where d.distanza > v_in_distanza
                        AND d.POSGEOGRAFICAPORTO = in_porto)
            loop
                GUI.APRIRIGATABELLA();
                GUI.CELLATABELLA(VAL  => localita.POSGEOGRAFICALOCALITA);
                GUI.CELLATABELLA(VAL  => localita.NOMELOCALITA);
                GUI.CELLATABELLA(VAL  => localita.POSGEOGRAFICAPORTO);
                GUI.CELLATABELLA(VAL  => localita.nomeporto);
                GUI.CELLATABELLA(VAL  => localita.distanza);
                GUI.CHIUDIRIGATABELLA();
            end loop;
        end if;


        GUI.CHIUDITABELLA();
        GUI.CHIUDIPAGINASTANDARD('blu');

        EXCEPTION
                WHEN no_data_found THEN gui.ESITOPERAZIONE(ESITO  => 'fallito' /*IN VARCHAR2*/,
                                                           MESSAGGIO  => 'nessun dato trovato per il porto selezionato ' || v_check /*IN VARCHAR2*/);
    end localitalontana;

    PROCEDURE visitaconpiulingue AS
    /*
    mostra la visita con più lingue diverse disponibili
    */
    v_idvisita VISITAGUIDATA.idvisita%type;
    v_nomevisita visitaGUIdata.nomevisita%type;
    v_lingue NUMBER;
    begin
        GUI.APRIPAGINASTANDARD();
        GUI.APRITABELLA(TITOLO  => 'Visita con più lingue diverse disponibili',
                                DIMTITOLO  => 2);
        GUI.APRIRIGATABELLA();
        GUI.CELLATABELLAHEADER(VAL  => 'ID visita');
        GUI.CELLATABELLAHEADER(VAL  => 'Nome visita');
        GUI.CELLATABELLAHEADER(VAL  => 'Numero lingue');
        GUI.CHIUDIRIGATABELLA();
        for visita in (
                        SELECT vg.IDVISITA, vg.NOMEVISITA, g.numero_lingue
                        from VISITAGUIDATA vg
                            inner join GUIdevisite g on vg.IDVISITA = g.IDVISITA
                        where g.numero_lingue >= all (
                            select g1.numero_lingue
                            from GUIdevisite g1
                        )

        ) loop
        GUI.APRIRIGATABELLA();
        GUI.CELLATABELLA(VAL  => visita.idvisita);
        GUI.CELLATABELLA(VAL  => visita.nomevisita);
        GUI.CELLATABELLA(VAL  => visita.numero_lingue);
        GUI.CHIUDIRIGATABELLA();
        end loop;
        GUI.CHIUDITABELLA();

        GUI.CHIUDIPAGINASTANDARD('blu');

    end visitaconpiulingue;


    PROCEDURE formtour AS
    /*
    apre il form per l'inserimento di un nuovo tour
    */

    BEGIN

        GUI.APRIPAGINASTANDARD(TITOLO  => 'nuovo tour');


        if (AUTHORIZE.HAPERMESSO(PERMESSO_P  => 'cu_blu') or AUTHORIZE.HAPERMESSO(PERMESSO_P  => 'cu_tutto' /*IN VARCHAR2*/))  = false then
            raise authorize.SENZA_PERMESSO;

        end if;

        GUI.apriform('form card', 'get', 'blu.nuovotour', JS => 'return confirm(`Confermi di inviare i dati selezionati`);');
        GUI.CARDHEADER(TITOLO  => 'Inserisci i dati del nuovo tour',
                       LOGO  => 0);

        GUI.APRIFIELD(TESTO  => 'Nome del nuovo tour');
        GUI.INPUT_FORM(CLASSE  => 'input'  ,
                                 TIPO  => 'text'  ,
                                 ID  => 'in_nometour'  ,
                                 NOME  => 'in_nometour'  ,
                                 REQUIRED  => 'required'  );
        GUI.CHIUDIFIELD();
        GUI.APRIFIELD(TESTO  => 'Numero notti del nuovo tour');
        GUI.INPUT_FORM(CLASSE  => 'input'  ,
                                 TIPO  => 'number'  ,
                                 ID  => 'in_numeronotti'  ,
                                 NOME  => 'in_numeronotti'  ,
                                 REQUIRED  => 'required'  );
        GUI.CHIUDIFIELD();
         GUI.APRIFIELD(TESTO  => 'Numero tappe del nuovo tour');
        GUI.INPUT_FORM(CLASSE  => 'input'  ,
                                 TIPO  => 'number'  ,
                                 ID  => 'in_numerotappe'  ,
                                 NOME  => 'in_numerotappe'  ,
                                 REQUIRED  => 'required'  );
        GUI.CHIUDIFIELD();
        GUI.APRIFIELD(ALLINEAMENTO  => 'center');
            GUI.BTNSUBMIT(txt => 'inserisci');
            GUI.BTNRESET(txt => 'cancella');
        GUI.CHIUDIFIELD;
        GUI.CHIUDIFORM();
        GUI.CHIUDIPAGINASTANDARD(FOOTER  => 'blu');

        EXCEPTION
            when authorize.SENZA_PERMESSO then gui.ESITOPERAZIONE(ESITO  => 'fallimento' /*IN VARCHAR2*/,
                    MESSAGGIO  => 'non hai i permessi necessari per eseguire questa operazione' /*IN VARCHAR2*/);
    end formtour;

    procedure nuovotour(in_nometour tour.NOMETOUR%TYPE, in_numeronotti tour.NUMERONOTTI%type, in_numerotappe tour.NUMEROTAPPE%type) AS
    /*
    operazione per inserimento nuovo tour
    */
    v_msg VARCHAR2(200) DEFAULT 'Tour inserito correttamente';
    v_idtour tour.idtour%type;
    begin

        v_idtour := IDTOURSEQ.NEXTVAL;

        GUI.APRIPAGINASTANDARD();
        insert into tour values(v_idtour, in_nometour, in_numeronotti, in_numerotappe);

        gui.ESITOPERAZIONE(ESITO  => 'SUCCESSO' /*IN VARCHAR2*/,
                           MESSAGGIO  => v_msg /*IN VARCHAR2*/);
        htp.p('<a style="left:50%" href=' || costanti.macchina2 || costanti.radice || 'blu.formtappa?in_idtour=' || v_idtour || '=' || in_numerotappe|| '>');
        GUI.BTN(TXT  => 'inserisci le tappe'  );
        htp.p('</a>');

        GUI.CHIUDIPAGINASTANDARD(FOOTER  => 'blu'  );
        EXCEPTION
            when DUP_VAL_ON_INDEX then
                v_msg := 'Tour già presente';
                gui.ESITOPERAZIONE(ESITO  => 'fallimento' /*IN VARCHAR2*/,
                    MESSAGGIO  => v_msg /*IN VARCHAR2*/);
                GUI.CHIUDIPAGINASTANDARD(FOOTER  => 'blu'  );
            when others then
                v_msg := 'Errore';
                gui.ESITOPERAZIONE(ESITO  => 'fallimento' /*IN VARCHAR2*/,
                    MESSAGGIO  => v_msg /*IN VARCHAR2*/);
                GUI.CHIUDIPAGINASTANDARD(FOOTER  => 'blu'  );

    end nuovotour;

    procedure formtappa(in_idtour tour.IDTOUR%type, in_numerotappe tour.NUMERONOTTI%type) is
    /*
    form per inserire nuove tappe del tour
    */
    begin

        GUI.APRIPAGINASTANDARD(TITOLO  => 'nuovo tour');
        if (AUTHORIZE.HAPERMESSO(PERMESSO_P  => 'cu_blu') or AUTHORIZE.HAPERMESSO(PERMESSO_P  => 'cu_tutto' /*IN VARCHAR2*/))  = false then
            raise authorize.SENZA_PERMESSO;

        end if;

        GUI.apriform('form card', 'get', 'blu.nuovatappa', JS => 'return confirm(`Confermi di inviare i dati selezionati`);');
        GUI.CARDHEADER(TITOLO  => 'Inserisci le '|| in_numerotappe || ' tappe del nuovo tour',
                       LOGO  => 0);
        GUI.APRIFIELD();
            GUI.INPUT_FORM(CLASSE  => 'number'  ,
                           TIPO  => 'hidden'  ,
                           ID  => 'in_idtour'  ,
                           NOME  => 'in_idtour'  ,
                           VALORE  => in_idtour  );
        GUI.CHIUDIFIELD();
        GUI.APRIFIELD(TESTO  => 'Inserisci la lista delle tappe, separate da virgola');
        GUI.INPUT_FORM(CLASSE  => 'input'  ,
                        TIPO  => 'text'  ,
                        ID  => 'in_listaporti'  ,
                        NOME  => 'in_listaporti'  ,
                        REQUIRED  => 'required'  );
        GUI.CHIUDIFIELD();
        GUI.APRIFIELD();
            GUI.INPUT_FORM(CLASSE  => 'number'  ,
                           TIPO  => 'hidden'  ,
                           ID  => 'in_numerotappe'  ,
                           NOME  => 'in_numerotappe'  ,
                           VALORE  => in_numerotappe  );
        GUI.CHIUDIFIELD();
        GUI.APRIFIELD(ALLINEAMENTO  => 'center');
            GUI.BTNSUBMIT(txt => 'inserisci');
            GUI.BTNRESET(txt => 'cancella');
        GUI.CHIUDIFIELD;


        GUI.CHIUDIFORM();
        GUI.CHIUDIPAGINASTANDARD('blu');


        EXCEPTION
            when authorize.SENZA_PERMESSO then gui.ESITOPERAZIONE(ESITO  => 'fallimento' /*IN VARCHAR2*/,
                    MESSAGGIO  => 'non hai i permessi necessari per eseguire questa operazione' /*IN VARCHAR2*/);

    end formtappa;


    procedure nuovatappa(in_idtour tour.IDTOUR%type DEFAULT 1, in_listaporti varchar2 DEFAULT 'Livorno', in_numerotappe tour.NUMEROTAPPE%type DEFAULT 1) IS

    /*
    operazione per inserimento nuove tappe
    */
    v_index number:= 1;
    v_index1 number := 1;
    v_check number := 0;
    v_stringlistaporti varchar2(200);
    v_posporto porto.POSGEOGRAFICA%type;
    v_string VARCHAR2(200);

    begin
        v_stringlistaporti := in_listaporti || ',';

       for i in 1..in_numerotappe loop
            v_index1 := instr(v_stringlistaporti, ',',v_index);
            v_string := substr(v_stringlistaporti, v_index, v_index1-v_index );
            select POSGEOGRAFICA into v_posporto from porto where NOMEPORTO = v_string;
            insert into include values (in_idtour, v_posporto, i);
            v_index := v_index1 + 1;
            v_check := v_check + 1;
        end loop ;


        GUI.APRIPAGINASTANDARD(TITOLO  => 'nuovo tour');

        if v_check = in_numerotappe then
            gui.ESITOPERAZIONE(ESITO  => 'SUCCESSO' /*IN VARCHAR2*/,
                               MESSAGGIO  => 'tappe inserite correttamente' /*IN VARCHAR2*/);
        else
            raise no_data_found;
        end if;


        GUI.CHIUDIPAGINASTANDARD(FOOTER  => 'blu'  );

        EXCEPTION
            when no_data_found then gui.ESITOPERAZIONE(ESITO  => 'fallimento' /*IN VARCHAR2*/,
                                                        MESSAGGIO  => 'errore nell''inserimento delle tappe' /*IN VARCHAR2*/);


    end nuovatappa;


end BLU;