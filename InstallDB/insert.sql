
--@Author: Luca Borrello

INSERT INTO GUIDA (IDGuida, CF, Nome, Cognome) VALUES (1, 'ABCDEF12G34H567I', 'Mario', 'Rossi');
INSERT INTO GUIDA (IDGuida, CF, Nome, Cognome) VALUES (2, 'FGHIJL23M45N678O', 'Luca', 'Bianchi');
INSERT INTO GUIDA (IDGuida, CF, Nome, Cognome) VALUES (3, 'PQRSTU34V56W789X', 'Giulia', 'Verdi');
INSERT INTO GUIDA (IDGuida, CF, Nome, Cognome) VALUES (4, 'YZABCD45E67F890G', 'Paola', 'Neri');
INSERT INTO GUIDA (IDGuida, CF, Nome, Cognome) VALUES (5, 'HIJKLM67N89P012Q', 'Stefano', 'Russo');
INSERT INTO GUIDA (IDGuida, CF, Nome, Cognome) VALUES (6, 'STUVWX78Y90Z123A', 'Chiara', 'Esposito');
INSERT INTO GUIDA (IDGUIDA, CF, NOME, COGNOME) VALUES (7, 'NESSUNAGUIDAAAAA', 'Nessuna', 'Guida');

-- Inserimento dati nella tabella LINGUE
INSERT INTO LINGUE (Lingua) VALUES ('Italiano');
INSERT INTO LINGUE (Lingua) VALUES ('Inglese');
INSERT INTO LINGUE (Lingua) VALUES ('Francese');
INSERT INTO LINGUE (Lingua) VALUES ('Spagnolo');
INSERT INTO LINGUE (Lingua) VALUES ('Tedesco');
INSERT INTO LINGUE (Lingua) VALUES ('Russo');
INSERT INTO LINGUE(Lingua) VALUES ('Nessunalingua');


-- Inserimento dati nella tabella PARLA
INSERT INTO PARLA (IDGuida, Lingua) VALUES (1, 'Italiano');
INSERT INTO PARLA (IDGuida, Lingua) VALUES (1, 'Inglese');
INSERT INTO PARLA (IDGuida, Lingua) VALUES (2, 'Italiano');
INSERT INTO PARLA (IDGuida, Lingua) VALUES (2, 'Francese');
INSERT INTO PARLA (IDGuida, Lingua) VALUES (3, 'Italiano');
INSERT INTO PARLA (IDGuida, Lingua) VALUES (3, 'Spagnolo');
INSERT INTO PARLA (IDGuida, Lingua) VALUES (4, 'Spagnolo');
INSERT INTO PARLA (IDGuida, Lingua) VALUES (5, 'Spagnolo');
INSERT INTO PARLA (IDGuida, Lingua) VALUES (1, 'Spagnolo');
INSERT INTO PARLA (IDGuida, Lingua) VALUES (2, 'Spagnolo');
INSERT INTO PARLA (IDGuida, Lingua) VALUES (7, 'Nessunalingua');


-- Inserimento dati nella tabella VISITAGUIDATA
INSERT INTO VISITAGUIDATA(IDVisita, NomeVisita, DurataVisita, CostoVisita, isDisponibile, nPersone) VALUES (1, 'Visita Pisa', 2, 20, 1, 10);
INSERT INTO VISITAGUIDATA(IDVisita, NomeVisita, DurataVisita, CostoVisita, isDisponibile, nPersone) VALUES (2, 'Visita Pisa2', 2, 30, 1, 10);
INSERT INTO VISITAGUIDATA(IDVisita, NomeVisita, DurataVisita, CostoVisita, isDisponibile, nPersone) VALUES (3, 'Visita Pisa3', 2, 50, 1, 10);

INSERT INTO VISITAGUIDATA(IDVisita, NomeVisita, DurataVisita, CostoVisita, isDisponibile, nPersone) VALUES (4, 'Visita Roma1', 4, 30, 1, 15);
INSERT INTO VISITAGUIDATA(IDVisita, NomeVisita, DurataVisita, CostoVisita, isDisponibile, nPersone) VALUES (5, 'Visita Roma2', 4, 50, 1, 15);
INSERT INTO VISITAGUIDATA(IDVisita, NomeVisita, DurataVisita, CostoVisita, isDisponibile, nPersone) VALUES (20, 'Visita Roma3', 4, 50, 1, 15);
INSERT INTO VISITAGUIDATA(IDVisita, NomeVisita, DurataVisita, CostoVisita, isDisponibile, nPersone) VALUES (30, 'Visita Civitavecchia1', 4, 50, 1, 15);
INSERT INTO VISITAGUIDATA(IDVisita, NomeVisita, DurataVisita, CostoVisita, isDisponibile, nPersone) VALUES (31, 'Visita Civitavecchia1', 4, 60, 1, 15);
INSERT INTO VISITAGUIDATA(IDVisita, NomeVisita, DurataVisita, CostoVisita, isDisponibile, nPersone) VALUES (32, 'Visita Civitavecchia1', 4, 70, 1, 15);

INSERT INTO VISITAGUIDATA(IDVisita, NomeVisita, DurataVisita, CostoVisita, isDisponibile, nPersone) VALUES (6, 'Visita Firenze', 3, 35, 1, 20);
INSERT INTO VISITAGUIDATA(IDVisita, NomeVisita, DurataVisita, CostoVisita, isDisponibile, nPersone) VALUES (7, 'Visita Firenze2', 3, 60, 1, 20);
INSERT INTO VISITAGUIDATA(IDVisita, NomeVisita, DurataVisita, CostoVisita, isDisponibile, nPersone) VALUES (21, 'Visita Firenze3', 3, 60, 1, 20);
INSERT INTO VISITAGUIDATA(IDVisita, NomeVisita, DurataVisita, CostoVisita, isDisponibile, nPersone) VALUES (22, 'Visita Firenze4', 3, 60, 1, 20);

INSERT INTO VISITAGUIDATA(IDVisita, NomeVisita, DurataVisita, CostoVisita, isDisponibile, nPersone) VALUES (8, 'Visita Viareggio', 5, 10, 0, 10);
INSERT INTO VISITAGUIDATA(IDVisita, NomeVisita, DurataVisita, CostoVisita, isDisponibile, nPersone) VALUES (9, 'Visita Viarggio2', 3, 30, 1, 20);
INSERT INTO VISITAGUIDATA(IDVisita, NomeVisita, DurataVisita, CostoVisita, isDisponibile, nPersone) VALUES (10, 'Visita Viarggio3', 3, 60, 1, 20);

insert into VISITAGUIDATA (IDVISITA, NOMEVISITA, DURATAVISITA, COSTOVISITA, ISDISPONIBILE, NPERSONE) VALUES (11, 'visitanapoli1', 2, 33, 1, 2 );
insert into VISITAGUIDATA (IDVISITA, NOMEVISITA, DURATAVISITA, COSTOVISITA, ISDISPONIBILE, NPERSONE) VALUES (12, 'visitanapoli2', 2,52, 1, 2 );
insert into VISITAGUIDATA (IDVISITA, NOMEVISITA, DURATAVISITA, COSTOVISITA, ISDISPONIBILE, NPERSONE) VALUES (13, 'visitanapoli3', 2, 72, 1, 2 );
insert into VISITAGUIDATA (IDVISITA, NOMEVISITA, DURATAVISITA, COSTOVISITA, ISDISPONIBILE, NPERSONE) VALUES (27, 'visitaVesuvio1', 2, 30, 1, 2 );
insert into VISITAGUIDATA (IDVISITA, NOMEVISITA, DURATAVISITA, COSTOVISITA, ISDISPONIBILE, NPERSONE) VALUES (28, 'visitaVesuvio2', 2, 50, 1, 2 );
insert into VISITAGUIDATA (IDVISITA, NOMEVISITA, DURATAVISITA, COSTOVISITA, ISDISPONIBILE, NPERSONE) VALUES (29, 'visitaVesuvio3', 2, 72, 1, 2 );

insert into VISITAGUIDATA (IDVISITA, NOMEVISITA, DURATAVISITA, COSTOVISITA, ISDISPONIBILE, NPERSONE) VALUES (14, 'VisitaCagliari1', 2, 15, 1, 2 );
insert into VISITAGUIDATA (IDVISITA, NOMEVISITA, DURATAVISITA, COSTOVISITA, ISDISPONIBILE, NPERSONE) VALUES (15, 'VisitaCagliari2', 2, 43, 1, 2 );
insert into VISITAGUIDATA (IDVISITA, NOMEVISITA, DURATAVISITA, COSTOVISITA, ISDISPONIBILE, NPERSONE) VALUES (16, 'VisitaCagliari3', 2, 53, 1, 2 );

insert into VISITAGUIDATA (IDVISITA, NOMEVISITA, DURATAVISITA, COSTOVISITA, ISDISPONIBILE, NPERSONE) VALUES (17, 'VisitaCatania1', 2, 30, 1, 2 );
insert into VISITAGUIDATA (IDVISITA, NOMEVISITA, DURATAVISITA, COSTOVISITA, ISDISPONIBILE, NPERSONE) VALUES (18, 'VisitaCatania2', 2, 40, 1, 2 );
insert into VISITAGUIDATA (IDVISITA, NOMEVISITA, DURATAVISITA, COSTOVISITA, ISDISPONIBILE, NPERSONE) VALUES (19, 'VisitaCatania3', 2, 70, 1, 2 );

insert into VISITAGUIDATA (IDVISITA, NOMEVISITA, DURATAVISITA, COSTOVISITA, ISDISPONIBILE, NPERSONE) VALUES (23, 'VisitaTaormina1', 2, 30, 1, 2 );
insert into VISITAGUIDATA (IDVISITA, NOMEVISITA, DURATAVISITA, COSTOVISITA, ISDISPONIBILE, NPERSONE) VALUES (24, 'VisitaTaormina2', 2, 30, 1, 2 );
insert into VISITAGUIDATA (IDVISITA, NOMEVISITA, DURATAVISITA, COSTOVISITA, ISDISPONIBILE, NPERSONE) VALUES (25, 'VisitaTaormina3', 2, 30, 1, 2 );
insert into VISITAGUIDATA (IDVISITA, NOMEVISITA, DURATAVISITA, COSTOVISITA, ISDISPONIBILE, NPERSONE) VALUES (26, 'VisitaTaormina4', 2, 30, 1, 2 );

-- Inserimento dati nella tabella NAVE
INSERT INTO NAVE(IDNave, NomeNave, Lunghezza, Larghezza, Altezza, Peso, Descrizione) VALUES(1, 'Queen Mary 2', 345, 41, 72, 148000, 'Una delle navi più grandi al mondo, con servizi di lusso e ristoranti stellati.');
INSERT INTO NAVE(IDNave, NomeNave, Lunghezza, Larghezza, Altezza, Peso, Descrizione) VALUES(2, 'Norwegian Escape', 325, 41, 72, 164600, 'Una nave moderna e divertente, con numerosi ristoranti e attività a bordo.');
INSERT INTO NAVE(IDNave, NomeNave, Lunghezza, Larghezza, Altezza, Peso, Descrizione) VALUES(3, 'Costa Smeralda', 337, 42, 73, 185010, 'Una nave italiana con design innovativo e una vasta gamma di servizi a bordo.');
INSERT INTO NAVE(IDNave, NomeNave, Lunghezza, Larghezza, Altezza, Peso, Descrizione) VALUES(4, 'Carnival2', 344, 46, 72, 180800, 'Una nave divertente e colorata con numerosi ristoranti e attrazioni a tema a bordo.');
INSERT INTO NAVE (IDNave, NomeNave, Lunghezza, Larghezza, Altezza, Peso, Descrizione) VALUES (5, 'MSC Splendida', 333, 38, 67, 137936, 'MSC Splendida è una nave da crociera della compagnia MSC Crociere.');



-- Inserimento dati nella tabella TOUR
INSERT INTO TOUR (IDTour, NomeTour, numeroNotti, numeroTappe) VALUES (1, 'Tour della Toscana', 7, 10);
INSERT INTO TOUR (IDTour, NomeTour, numeroNotti, numeroTappe) VALUES (2, 'Tour della Sicilia', 9, 12);
INSERT INTO TOUR (IDTour, NomeTour, numeroNotti, numeroTappe) VALUES (3, 'Tour della Sardegna', 5, 8);
INSERT INTO TOUR (IDTour, NomeTour, numeroNotti, numeroTappe) VALUES (4, 'Tour della Costiera Amalfitana', 5, 6);
INSERT INTO TOUR (IDTour, NomeTour, numeroNotti, numeroTappe) VALUES (5, 'Tour Puglia', 4,3);
INSERT INTO TOUR (IDTour, NomeTour, numeroNotti, numeroTappe) VALUES (6, 'Tour Lazio', 8,3);
INSERT INTO TOUR (IDTour, NomeTour, numeroNotti, numeroTappe) VALUES (7, 'Tour della Toscana', 5, 10);
INSERT INTO TOUR (IDTour, NomeTour, numeroNotti, numeroTappe) VALUES (8, 'Tour della Sicilia', 5, 12);
INSERT INTO TOUR (IDTour, NomeTour, numeroNotti, numeroTappe) VALUES (9, 'Tour della Sardegna', 3, 4);
INSERT INTO TOUR (IDTour, NomeTour, numeroNotti, numeroTappe) VALUES (10, 'Tour della Costiera Amalfitana', 3, 6);
INSERT INTO TOUR (IDTour, NomeTour, numeroNotti, numeroTappe) VALUES (11, 'Tour Puglia', 8,3);
INSERT INTO TOUR (IDTour, NomeTour, numeroNotti, numeroTappe) VALUES (12, 'Tour Lazio', 6,3);


--porto
INSERT INTO PORTO(PosGeografica, NomePorto, NumeroPosti) VALUES ('45.4408-12.3155', 'Venezia', 200);
INSERT INTO PORTO(PosGeografica, NomePorto, NumeroPosti) VALUES ('41.9028-12.4964', 'Civitavecchia', 300);
INSERT INTO PORTO(PosGeografica, NomePorto, NumeroPosti) VALUES ('43.7714-11.2542', 'Livorno', 150);
INSERT INTO PORTO(PosGeografica, NomePorto, NumeroPosti) VALUES ('2982392-2832372', 'Piombino', 680);
INSERT INTO PORTO(PosGeografica, NomePorto, NumeroPosti) VALUES ('2939729-833747', 'Carrara', 680);
INSERT INTO PORTO(PosGeografica, NomePorto, NumeroPosti) VALUES ('40.8376-14.2681', 'Napoli', 250);
INSERT INTO PORTO(PosGeografica, NomePorto, NumeroPosti) VALUES ('38.1105-13.3525', 'Palermo', 100);
INSERT INTO PORTO(PosGeografica, NomePorto, NumeroPosti) VALUES ('39.2144-9.1102', 'Cagliari', 120);
INSERT INTO PORTO(PosGeografica, NomePorto, NumeroPosti) VALUES ('38.1368-13.3359', 'Trapani', 80);
INSERT INTO PORTO(PosGeografica, NomePorto, NumeroPosti) VALUES ('44.4056-8.9463', 'Genova', 180);
INSERT INTO PORTO(PosGeografica, NomePorto, NumeroPosti) VALUES ('45.6505-13.7699', 'Trieste', 90);
INSERT INTO PORTO(PosGeografica, NomePorto, NumeroPosti) VALUES ('40.6668-17.9364', 'Brindisi', 70);



-- INSERT INTO LOCALITA
INSERT INTO LOCALITA (PosGeografica, NomeLocalita, GiorniConsigliati) VALUES ('45.4408-12.3155', 'Venezia', 3);
INSERT INTO LOCALITA (PosGeografica, NomeLocalita, GiorniConsigliati) VALUES ('239821', 'Padua', 3);

INSERT INTO LOCALITA (PosGeografica, NomeLocalita, GiorniConsigliati) VALUES ('41.9028-21234', 'Roma', 4);
INSERT INTO LOCALITA (PosGeografica, NomeLocalita, GiorniConsigliati) VALUES ('98543114', 'Sora', 1);

INSERT INTO LOCALITA (PosGeografica, NomeLocalita, GiorniConsigliati) VALUES ('43.1214-11.0342', 'Firenze', 3);
INSERT INTO LOCALITA (PosGeografica, NomeLocalita, GiorniConsigliati) VALUES ('12345', 'Pisa', 1);
INSERT INTO LOCALITA (PosGeografica, NomeLocalita, GiorniConsigliati) VALUES ('1243-65984', 'Viareggio', 1);
INSERT INTO LOCALITA (PosGeografica, NomeLocalita, GiorniConsigliati) VALUES ('1223891-332345', 'lucca', 1);
INSERT INTO LOCALITA (PosGeografica, NomeLocalita, GiorniConsigliati) VALUES ('9584-1232345', 'san giuliano terme', 1);
INSERT INTO LOCALITA (PosGeografica, NomeLocalita, GiorniConsigliati) VALUES ('43.7714-11.2542', 'Livorno', 1);

INSERT INTO LOCALITA (PosGeografica, NomeLocalita, GiorniConsigliati) VALUES ('40.8376-14.2681', 'Napoli', 3);
INSERT INTO LOCALITA (PosGeografica, NomeLocalita, GiorniConsigliati) VALUES ('292893', 'Pozzuoli', 2);

INSERT INTO LOCALITA (PosGeografica, NomeLocalita, GiorniConsigliati) VALUES ('38.1105-13.3525', 'Palermo', 3);
INSERT INTO LOCALITA (PosGeografica, NomeLocalita, GiorniConsigliati) VALUES ('95443', 'Taormina', 1);
INSERT INTO LOCALITA (PosGeografica, NomeLocalita, GiorniConsigliati) VALUES ('12143', 'Catania', 1);
INSERT INTO LOCALITA (PosGeografica, NomeLocalita, GiorniConsigliati) VALUES ('38.1368-13.3359', 'Trapani', 2);

INSERT INTO LOCALITA (PosGeografica, NomeLocalita, GiorniConsigliati) VALUES ('39.2144-9.1102', 'Cagliari', 3);
INSERT INTO LOCALITA (PosGeografica, NomeLocalita, GiorniConsigliati) VALUES ('29205592', 'Calamosca', 3);


--raggiunge
INSERT INTO RAGGIUNGE(PosGeograficaPorto, PosGeograficaLocalita, Distanza, Mezzo) VALUES ('43.7714-11.2542','43.1214-11.0342', 200, 'Bus1');
INSERT INTO RAGGIUNGE(PosGeograficaPorto, PosGeograficaLocalita, Distanza, Mezzo) VALUES ('43.7714-11.2542','1243-65984', 30, 'Bus2');
INSERT INTO RAGGIUNGE(PosGeograficaPorto, PosGeograficaLocalita, Distanza, Mezzo) VALUES ('43.7714-11.2542','12345', 40, 'Bus3');
INSERT INTO RAGGIUNGE(PosGeograficaPorto, PosGeograficaLocalita, Distanza, Mezzo) VALUES ('43.7714-11.2542','9584-1232345', 25, 'Bus4');
INSERT INTO RAGGIUNGE(PosGeograficaPorto, PosGeograficaLocalita, Distanza, Mezzo) VALUES ('43.7714-11.2542','43.7714-11.2542', 0, 'Bus5');
INSERT INTO RAGGIUNGE(PosGeograficaPorto, PosGeograficaLocalita, Distanza, Mezzo) VALUES ('43.7714-11.2542','1223891-332345', 15, 'Bus6');

INSERT INTO RAGGIUNGE(PosGeograficaPorto, PosGeograficaLocalita, Distanza, Mezzo) VALUES ('41.9028-12.4964','41.9028-21234', 120, 'pullman');
INSERT INTO RAGGIUNGE(PosGeograficaPorto, PosGeograficaLocalita, Distanza, Mezzo) VALUES ('41.9028-12.4964','98543114', 56, 'pullman2');

INSERT INTO RAGGIUNGE(PosGeograficaPorto, PosGeograficaLocalita, Distanza, Mezzo) VALUES ('40.8376-14.2681','40.8376-14.2681', 0, 'Macchina');
INSERT INTO RAGGIUNGE(PosGeograficaPorto, PosGeograficaLocalita, Distanza, Mezzo) VALUES ('40.8376-14.2681','292893', 200, 'Macchina2');

INSERT INTO RAGGIUNGE(POSGEOGRAFICAPORTO,POSGEOGRAFICALOCALITA,DISTANZA,MEZZO) VALUES ( '38.1105-13.3525','38.1368-13.3359',200,'monopattino');
INSERT INTO RAGGIUNGE(POSGEOGRAFICAPORTO,POSGEOGRAFICALOCALITA,DISTANZA,MEZZO) VALUES ( '38.1105-13.3525','38.1105-13.3525',0,'hoverboard1');
INSERT INTO RAGGIUNGE(POSGEOGRAFICAPORTO,POSGEOGRAFICALOCALITA,DISTANZA,MEZZO) VALUES ( '38.1105-13.3525','12143',80,'hoverboard2');
INSERT INTO RAGGIUNGE(POSGEOGRAFICAPORTO,POSGEOGRAFICALOCALITA,DISTANZA,MEZZO) VALUES ( '38.1105-13.3525','95443',60,'hoverboard3');

INSERT INTO RAGGIUNGE(POSGEOGRAFICAPORTO,POSGEOGRAFICALOCALITA,DISTANZA,MEZZO) VALUES ( '39.2144-9.1102','39.2144-9.1102',0,'bus1');
INSERT INTO RAGGIUNGE(POSGEOGRAFICAPORTO,POSGEOGRAFICALOCALITA,DISTANZA,MEZZO) VALUES ( '39.2144-9.1102','29205592',60,'bu2');


--luogo interesse
INSERT INTO LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse, Tipologia, isDisponibile) VALUES (1, '41.9028-21234', 'Colosseo', 'Monumento', 1);
INSERT INTO LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse, Tipologia, isDisponibile) VALUES (2, '41.9028-21234', 'roma1', 'Monumento', 1);
INSERT INTO LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse, Tipologia, isDisponibile) VALUES (3, '41.9028-21234', 'roma2', 'Monumento', 1);
INSERT INTO LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse, Tipologia, isDisponibile) VALUES (4, '41.9028-21234', 'roma3', 'Monumento', 1);
INSERT INTO LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse, Tipologia, isDisponibile) VALUES (5, '41.9028-21234', 'roma4', 'Monumento', 1);
INSERT INTO LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse, Tipologia, isDisponibile) VALUES (6, '41.9028-21234', 'roma4', 'Monumento', 1);

insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (7,'1243-65984', 'passeggiata', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (8,'1243-65984', 'viareggio1', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (9,'1243-65984', 'viareggio2', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (10,'1243-65984', 'viareggio3', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (11,'1243-65984', 'viareggio4', 'attrazione', 1);


insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (12,'12345', 'Torrepisa', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (13,'12345', 'arno', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (14,'12345', 'pisa1', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (15,'12345', 'pisa2', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (16,'12345', 'pisa3', 'attrazione', 1);


INSERT INTO LUOGOintERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse, Tipologia, isDisponibile) VALUES (22, '43.1214-11.0342', 'Cattedrale di Santa Maria del Fiore', 'Storico', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (17,'43.1214-11.0342', 'montecatini', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (18,'43.1214-11.0342', 'firenze1', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (19,'43.1214-11.0342', 'firenze2', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (20,'43.1214-11.0342', 'firenze3', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (21,'43.1214-11.0342', 'firenze4', 'attrazione', 1);

insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (23,'40.8376-14.2681', 'vesusio', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (24,'40.8376-14.2681', 'napoli1', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (25,'40.8376-14.2681', 'napoli2', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (26,'40.8376-14.2681', 'napoli3', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (27,'40.8376-14.2681', 'napoli4', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (28,'40.8376-14.2681', 'margherita', 'attrazione', 1);

insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (29,'29205592', 'calamosca1', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (30,'29205592', 'calamosca2', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (31,'29205592', 'calamosca3', 'attrazione', 1);

insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (32,'98543114', 'sora1', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (33,'98543114', 'sora2', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (34,'98543114', 'sora3', 'attrazione', 1);

insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (35,'39.2144-9.1102', 'cagliari1', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (36,'39.2144-9.1102', 'cagliari2', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (37,'39.2144-9.1102', 'cagliari3', 'attrazione', 1);

insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (38,'12143', 'catania1', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (39,'12143', 'catania2', 'attrazione', 1);
insert into LUOGOINTERESSE (IDLuogointeresse, PosGeografica, NomeLuogointeresse,Tipologia, isDisponibile) VALUES (40,'12143', 'catania3', 'attrazione', 1);




------gestisce
insert into GESTISCE (IDGUIDA, IDVISITA, LINGUA) VALUES (1,3, 'Francese');
insert into GESTISCE (IDGUIDA, IDVISITA, LINGUA) VALUES (1, 2, 'Inglese');
insert into GESTISCE (IDGUIDA, IDVISITA, LINGUA) VALUES (2,1, 'Inglese');
insert into GESTISCE (IDGUIDA, IDVISITA, LINGUA) VALUES (2,2,'Inglese');
insert into GESTISCE (IDGUIDA, IDVISITA, LINGUA) VALUES (2,6, 'Inglese');
insert into GESTISCE (IDGUIDA, IDVISITA, LINGUA) VALUES (3, 4 , 'Inglese');
insert into GESTISCE (IDGUIDA, IDVISITA, LINGUA) VALUES (4, 1, 'Tedesco');
insert into GESTISCE (IDGUIDA, IDVISITA, LINGUA) VALUES (4,3, 'Tedesco');
insert into GESTISCE (IDGUIDA, IDVISITA, LINGUA) VALUES (4, 5, 'Inglese');
insert into GESTISCE (IDGUIDA, IDVISITA, LINGUA) VALUES (5, 2, 'Inglese');
insert into GESTISCE (IDGUIDA, IDVISITA, LINGUA) VALUES (6,6, 'Inglese');
insert into GESTISCE (IDGUIDA, IDVISITA, LINGUA) VALUES (6,4, 'Tedesco');


------luogo visita
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (4,2);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (4,3);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (5,2);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (5,3);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (5,1);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (5,6);

insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (8,7);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (8,8);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (9,8);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (9,11);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (9,10);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (10,7);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (10,8);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (10,11);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (10,10);

insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (1,12);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (1,13);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (2,13);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (2,15);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (2,16);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (3,12);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (3,13);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (3,14);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (3,15);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (3,16);

insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (6,22);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (6,18);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (6,19);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (7,22);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (7,19);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (7,18);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (7,17);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (6,20);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (7,21);

insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (17,38);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (18,38);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (18,39);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (19,38);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (19,39);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (19,40);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (14,35);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (14,36);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (15,36);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (15,37);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (16,36);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (16,37);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (16,35);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (11,23);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (11,24);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (12,25);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (12,22);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (12,26);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (12,27);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (13,25);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (13,22);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (13,26);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (13,27);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (13,28);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (13,21);
insert into LUOGOVISITA (IDVISITA, IDLuogointeresse) VALUES (13,23);


---crociere
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(1, 1, 1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 1200, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(2, 2, 2, TO_DATE('2023-02-15', 'YYYY-MM-DD'), 1790, 0);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(3, 3, 3, TO_DATE('2023-03-20', 'YYYY-MM-DD'), 2530, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(4, 4, 4, TO_DATE('2023-04-25', 'YYYY-MM-DD'), 1890, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(5, 5, 5, TO_DATE('2023-05-05', 'YYYY-MM-DD'), 2900, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(6, 1, 5, TO_DATE('2023-06-11', 'YYYY-MM-DD'), 2200, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(7, 2, 6, TO_DATE('2023-07-10', 'YYYY-MM-DD'), 132, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(8, 4, 7, TO_DATE('2023-08-10', 'YYYY-MM-DD'), 3532, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(9, 5, 8, TO_DATE('2023-09-10', 'YYYY-MM-DD'), 1234, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(10,5, 9, TO_DATE('2023-10-10', 'YYYY-MM-DD'), 3453, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(11,4, 10, TO_DATE('2023-11-10', 'YYYY-MM-DD'), 1293, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(12,3, 11, TO_DATE('2023-12-10', 'YYYY-MM-DD'), 1214, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(13,2, 10, TO_DATE('2023-02-10', 'YYYY-MM-DD'), 1234, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(14, 1, 9, TO_DATE('2023-04-10', 'YYYY-MM-DD'), 4334, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(15, 2, 8, TO_DATE('2023-06-10', 'YYYY-MM-DD'), 2134, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(16, 3, 7, TO_DATE('2023-09-10', 'YYYY-MM-DD'), 2332, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(17,4, 6, TO_DATE('2023-10-22', 'YYYY-MM-DD'), 3244, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(18, 3, 5, TO_DATE('2023-12-18', 'YYYY-MM-DD'), 2133, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(19, 2, 4, TO_DATE('2023-03-08', 'YYYY-MM-DD'), 3211, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(20, 5, 3, TO_DATE('2023-05-11', 'YYYY-MM-DD'), 1233, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(21, 3, 2, TO_DATE('2023-07-02', 'YYYY-MM-DD'), 3211, 1);
INSERT INTO CROCIERA(IDCrociera, IDNave, IDTour, DataCrociera, CostoCrociera, isDisponibile) 
VALUES(22, 4, 1, TO_DATE('2023-06-11', 'YYYY-MM-DD'), 1233, 1);


----visite disponibili
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (1, 1, TO_DATE('2023/01/01', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (1, 2, TO_DATE('2023/01/01', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (1, 3, TO_DATE('2023/01/02', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (1, 6, TO_DATE('2023/01/02', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (1, 21, TO_DATE('2023/01/02', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (8, 6, TO_DATE('2023/08/10', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (8, 21, TO_DATE('2023/08/10', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (8, 9, TO_DATE('2023/08/10', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (8, 8, TO_DATE('2023/08/10', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (16, 8, TO_DATE('2023/09/10', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (16, 9, TO_DATE('2023/09/11', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (16, 10, TO_DATE('2023/09/11', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (16, 3, TO_DATE('2023/09/12', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (16, 2, TO_DATE('2023/09/12', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (22, 3, TO_DATE('2023/06/13', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (22, 2, TO_DATE('2023/06/13', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (22, 1, TO_DATE('2023/06/15', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (22, 7, TO_DATE('2023/06/15', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (22, 6, TO_DATE('2023/06/15', 'YYYY-MM-DD'));


insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (9, 18, TO_DATE('2023/09/10', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (9, 19, TO_DATE('2023/09/11', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (9, 26, TO_DATE('2023/09/11', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (2, 17, TO_DATE('2023/02/15', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (2, 19, TO_DATE('2023/02/15', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (2, 23, TO_DATE('2023/02/16', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (2, 24, TO_DATE('2023/02/16', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (15, 24, TO_DATE('2023/06/10', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (15, 25, TO_DATE('2023/06/11', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (15, 26, TO_DATE('2023/06/11', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (21, 17, TO_DATE('2023/07/02', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (21, 18, TO_DATE('2023/07/03', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (21, 26, TO_DATE('2023/07/03', 'YYYY-MM-DD'));


insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (4, 11, TO_DATE('2023/04/25', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (4, 12, TO_DATE('2023/04/25', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (4, 29, TO_DATE('2023/04/25', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (11, 12, TO_DATE('2023/11/11', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (11, 13, TO_DATE('2023/11/11', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (11, 27, TO_DATE('2023/11/11', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (13, 27, TO_DATE('2023/02/10', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (13, 28, TO_DATE('2023/02/11', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (13, 29, TO_DATE('2023/02/11', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (19, 12, TO_DATE('2023/03/09', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (19, 27, TO_DATE('2023/03/10', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (19, 29, TO_DATE('2023/03/11', 'YYYY-MM-DD'));


insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (7,4, TO_DATE('2023/07/10', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (7,5, TO_DATE('2023/07/11', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (7,30, TO_DATE('2023/07/11', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (17,4, TO_DATE('2023/10/22', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (17,31, TO_DATE('2023/10/23', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (17,20, TO_DATE('2023/10/23', 'YYYY-MM-DD'));
insert into VISITEDISPONIBILI (IDCROCIERA, IDVISITA, DataVisita) VALUES (17,30, TO_DATE('2023/10/23', 'YYYY-MM-DD'));




-----include 
INSERT INTO INCLUDE (IDTour, PosGeografica, Ordine) VALUES (1, '43.7714-11.2542', 1);
INSERT INTO INCLUDE (IDTour, PosGeografica, Ordine) VALUES (1, '2982392-2832372', 2);
INSERT INTO INCLUDE (IDTour, PosGeografica, Ordine) VALUES (7, '43.7714-11.2542', 1);
INSERT INTO INCLUDE (IDTour, PosGeografica, Ordine) VALUES (7, '2982392-2832372', 2);

INSERT INTO INCLUDE (IDTour, PosGeografica, Ordine) VALUES (2, '38.1105-13.3525', 1);
INSERT INTO INCLUDE (IDTour, PosGeografica, Ordine) VALUES (2, '38.1368-13.3359', 2);
INSERT INTO INCLUDE (IDTour, PosGeografica, Ordine) VALUES (8, '38.1105-13.3525', 1);
INSERT INTO INCLUDE (IDTour, PosGeografica, Ordine) VALUES (8, '38.1368-13.3359', 2);

INSERT INTO INCLUDE (IDTour, PosGeografica, Ordine) VALUES (3, '39.2144-9.1102', 1);
INSERT INTO INCLUDE (IDTour, PosGeografica, Ordine) VALUES (9, '39.2144-9.1102', 1);

INSERT INTO INCLUDE (IDTour, PosGeografica, Ordine) VALUES (5, '40.6668-17.9364', 1);
INSERT INTO INCLUDE (IDTour, PosGeografica, Ordine) VALUES (11, '40.6668-17.9364', 1);

INSERT INTO INCLUDE (IDTour, PosGeografica, Ordine) VALUES (10, '40.8376-14.2681', 1);
INSERT INTO INCLUDE (IDTour, PosGeografica, Ordine) VALUES (4, '40.8376-14.2681', 1);

INSERT INTO INCLUDE (IDTour, PosGeografica, Ordine) VALUES (6, '41.9028-12.4964', 1);
INSERT INTO INCLUDE (IDTour, PosGeografica, Ordine) VALUES (12, '41.9028-12.4964', 1);



--- tipologia
INSERT INTO TIPOCAMERA(Tipologia, Costo, PianoNave) VALUES ('Singola', '100', '3'); 
INSERT INTO TIPOCAMERA(Tipologia, Costo, PianoNave) VALUES ('Doppia', '150', '2');
INSERT INTO TIPOCAMERA(Tipologia, Costo, PianoNave) VALUES ('Tripla', '200', '2');


---camera
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 1, 1, 'Singola',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES( 2, 1, 'Singola',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES( 3, 1, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES( 4, 1, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES( 5, 1, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES( 6, 1, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 24, 1, 'Tripla',0);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 25, 1, 'Tripla',0);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 26, 1, 'Tripla',0);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 27, 1, 'Tripla',0);



INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 7, 2, 'Tripla',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 8, 2, 'Tripla',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 52, 2, 'Tripla',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 53, 2, 'Tripla',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 54, 2, 'Tripla',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 55, 2, 'Tripla',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 56, 2, 'Tripla',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 57, 2, 'Tripla',1);

INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 9, 2, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 28, 2, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 29, 2, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 30, 2, 'Singola',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 31, 2, 'Singola',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 32, 2, 'Singola',1);



INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 10, 3, 'Singola',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 11, 3, 'Singola',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 12, 3, 'Singola',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 13, 3, 'Singola',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 14, 3, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 33, 3, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 34, 3, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 35, 3, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 36, 3, 'Tripla',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 37, 3, 'Tripla',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia, isDisponibile) VALUES ( 38, 3, 'Tripla',1);


INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 15, 4, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 16, 4, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 49, 4, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 50, 4, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 51, 4, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 17, 4, 'Singola',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 18, 4, 'Singola',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 19, 4, 'Singola',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 39, 4, 'Singola',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 40, 4, 'Tripla',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 41, 4, 'Tripla',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 42, 4, 'Tripla',1);


INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 20, 5, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 21, 5, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 22, 5, 'Doppia',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 23, 5, 'Singola',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 43, 5, 'Singola',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 44, 5, 'Singola',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 45, 5, 'Singola',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 46, 5, 'Singola',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 47, 5, 'Tripla',1);
INSERT INTO CAMERA(IdCamera, IDNave, Tipologia,isDisponibile) VALUES ( 48, 5, 'Tripla',1);



--insert DISPONIBILITACAMERE
INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (1, 'Singola', 234, 359);
INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (1, 'Doppia', 235, 468);
INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (1, 'Tripla', 653, 1245);

INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (2, 'Singola', 234, 359);
INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (2, 'Doppia', 235, 468);
INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (2, 'Tripla', 253, 1245);

INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (3, 'Singola', 94, 359);
INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (3, 'Doppia', 135, 468);
INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (3, 'Tripla', 453, 745);

INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (4, 'Singola', 34, 359);
INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (4, 'Doppia', 235, 468);
INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (4, 'Tripla', 653, 845);

INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (5, 'Singola', 134, 359);
INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (5, 'Doppia', 335, 468);
INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (5, 'Tripla', 253, 645);

INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (6, 'Singola', 234, 359);
INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (6, 'Doppia', 321, 468);
INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (6, 'Tripla', 0, 753);

INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (7, 'Singola', 34, 743);
INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (7, 'Doppia', 42, 433);
INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (7, 'Tripla', 632, 854);

INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (8, 'Singola', 743, 2121);
INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (8, 'Doppia', 25,546);
INSERT INTO DISPONIBILITACAMERE(IDCROCIERA, Tipologia, NumeroPostiLiberi, NumeroPostiTotali) VALUES (8, 'Tripla', 223, 3325);



DECLARE
        v_salt RAW(32) := DBMS_CRYPTO.RANDOMBYTES(32);
        v_pwd RAW(128) := UTL_I18N.STRING_TO_RAW(DATA  => 'admin' /*IN VARCHAR2*/,
                                                DST_CHARSET  => 'AL32UTF8' /*IN VARCHAR2*/);
        v_concats RAW(128) := UTL_RAW.CONCAT(R1  => v_pwd /*IN RAW*/,
                                        R2  => v_salt /*IN RAW*/);
BEGIN

        INSERT INTO be_UTENTE VALUES (1, 'AAAAAAAAAAAAAAAA', 'ADMIN', 'ADMIN', 'carta', 1, v_salt, 'admin', DBMS_CRYPTO.HASH(v_concats, DBMS_CRYPTO.HASH_SH256));
END;
/

DECLARE
        v_salt RAW(32) := DBMS_CRYPTO.RANDOMBYTES(32);
        v_pwd RAW(128) := UTL_I18N.STRING_TO_RAW(DATA  => 'mario_rossi' /*IN VARCHAR2*/,
                                                DST_CHARSET  => 'AL32UTF8' /*IN VARCHAR2*/);
        v_concats RAW(128) := UTL_RAW.CONCAT(R1  => v_pwd /*IN RAW*/,
                                        R2  => v_salt /*IN RAW*/);
BEGIN

    INSERT INTO BE_Utente VALUES (2, 'ABCDEF12G34H567I', 'Mario', 'Rossi', 'carta', 1, v_salt, 'mario_rossi', DBMS_CRYPTO.HASH(v_concats, DBMS_CRYPTO.HASH_SH256));
END;
/

DECLARE
        v_salt RAW(32) := DBMS_CRYPTO.RANDOMBYTES(32);
        v_pwd RAW(128) := UTL_I18N.STRING_TO_RAW(DATA  => 'luca_bianchi' /*IN VARCHAR2*/,
                                                DST_CHARSET  => 'AL32UTF8' /*IN VARCHAR2*/);
        v_concats RAW(128) := UTL_RAW.CONCAT(R1  => v_pwd /*IN RAW*/,
                                        R2  => v_salt /*IN RAW*/);
BEGIN

INSERT INTO BE_UTENTE VALUES (3, 'FGHIJL23M45N678O', 'Luca', 'Bianchi', 'carta', 1, v_salt, 'luca_bianchi', DBMS_CRYPTO.HASH(v_concats, DBMS_CRYPTO.HASH_SH256));
END;
/


DECLARE
        v_salt RAW(32) := DBMS_CRYPTO.RANDOMBYTES(32);
        v_pwd RAW(128) := UTL_I18N.STRING_TO_RAW(DATA  => 'paola_neri' /*IN VARCHAR2*/,
                                                DST_CHARSET  => 'AL32UTF8' /*IN VARCHAR2*/);
        v_concats RAW(128) := UTL_RAW.CONCAT(R1  => v_pwd /*IN RAW*/,
                                        R2  => v_salt /*IN RAW*/);
BEGIN

INSERT INTO BE_UTENTE VALUES (4, 'YZABCD45E67F890G', 'Paola', 'Neri' , 'carta', 1, v_salt, 'paola_neri', DBMS_CRYPTO.HASH(v_concats, DBMS_CRYPTO.HASH_SH256));
END;
/

DECLARE
        v_salt RAW(32) := DBMS_CRYPTO.RANDOMBYTES(32);
        v_pwd RAW(128) := UTL_I18N.STRING_TO_RAW(DATA  => 'stefano_russo' /*IN VARCHAR2*/,
                                                DST_CHARSET  => 'AL32UTF8' /*IN VARCHAR2*/);
        v_concats RAW(128) := UTL_RAW.CONCAT(R1  => v_pwd /*IN RAW*/,
                                        R2  => v_salt /*IN RAW*/);
BEGIN

INSERT INTO BE_UTENTE VALUES (5, 'HIJKLM67N89P012Q', 'Stefano', 'Russo', 'carta', 1, v_salt, 'stefano_russo', DBMS_CRYPTO.HASH(v_concats, DBMS_CRYPTO.HASH_SH256));
END;
/

DECLARE
        v_salt RAW(32) := DBMS_CRYPTO.RANDOMBYTES(32);
        v_pwd RAW(128) := UTL_I18N.STRING_TO_RAW(DATA  => 'chiara_esposito' /*IN VARCHAR2*/,
                                                DST_CHARSET  => 'AL32UTF8' /*IN VARCHAR2*/);
        v_concats RAW(128) := UTL_RAW.CONCAT(R1  => v_pwd /*IN RAW*/,
                                        R2  => v_salt /*IN RAW*/);
BEGIN

INSERT INTO BE_UTENTE VALUES (6, 'STUVWX78Y90Z123A', 'Chiara', 'Esposito', 'carta', 1, v_salt, 'chiara_esposito', DBMS_CRYPTO.HASH(v_concats, DBMS_CRYPTO.HASH_SH256));
END;
/

DECLARE
        v_salt RAW(32) := DBMS_CRYPTO.RANDOMBYTES(32);
        v_pwd RAW(128) := UTL_I18N.STRING_TO_RAW(DATA  => 'luigi_verdi' /*IN VARCHAR2*/,
                                                DST_CHARSET  => 'AL32UTF8' /*IN VARCHAR2*/);
        v_concats RAW(128) := UTL_RAW.CONCAT(R1  => v_pwd /*IN RAW*/,
                                        R2  => v_salt /*IN RAW*/);
BEGIN

INSERT INTO be_Utente VALUES (7, 'QSDBCH17C9E610BE', 'Luigi', 'Verdi', 'carta', 0, v_salt, 'luigi_verdi', DBMS_CRYPTO.HASH(v_concats, DBMS_CRYPTO.HASH_SH256));
END;
/

DECLARE
        v_salt RAW(32) := DBMS_CRYPTO.RANDOMBYTES(32);
        v_pwd RAW(128) := UTL_I18N.STRING_TO_RAW(DATA  => 'claudia_ciondi' /*IN VARCHAR2*/,
                                                DST_CHARSET  => 'AL32UTF8' /*IN VARCHAR2*/);
        v_concats RAW(128) := UTL_RAW.CONCAT(R1  => v_pwd /*IN RAW*/,
                                        R2  => v_salt /*IN RAW*/);
BEGIN

INSERT INTO be_Utente VALUES (8, 'QSDBCH15C9E610BB', 'Claudia', 'Ciondi', 'carta', 0, v_salt, 'claudia_ciondi', DBMS_CRYPTO.HASH(v_concats, DBMS_CRYPTO.HASH_SH256));
END;
/

DECLARE
        v_salt RAW(32) := DBMS_CRYPTO.RANDOMBYTES(32);
        v_pwd RAW(128) := UTL_I18N.STRING_TO_RAW(DATA  => 'bruno_milanesi' /*IN VARCHAR2*/,
                                                DST_CHARSET  => 'AL32UTF8' /*IN VARCHAR2*/);
        v_concats RAW(128) := UTL_RAW.CONCAT(R1  => v_pwd /*IN RAW*/,
                                        R2  => v_salt /*IN RAW*/);
BEGIN

INSERT INTO be_Utente VALUES (9, 'QSDBCH19C9E610BI', 'Bruno', 'Milanesi', 'carta', 0, v_salt, 'bruno_milanesi', DBMS_CRYPTO.HASH(v_concats, DBMS_CRYPTO.HASH_SH256));
END;
/

DECLARE
        v_salt RAW(32) := DBMS_CRYPTO.RANDOMBYTES(32);
        v_pwd RAW(128) := UTL_I18N.STRING_TO_RAW(DATA  => 'sara_bianchi' /*IN VARCHAR2*/,
                                                DST_CHARSET  => 'AL32UTF8' /*IN VARCHAR2*/);
        v_concats RAW(128) := UTL_RAW.CONCAT(R1  => v_pwd /*IN RAW*/,
                                        R2  => v_salt /*IN RAW*/);
BEGIN

INSERT INTO be_Utente VALUES (10, 'QSDBCH11C9E610BP', 'Sara', 'Bianchi', 'carta', 0, v_salt, 'sara_bianchi', DBMS_CRYPTO.HASH(v_concats, DBMS_CRYPTO.HASH_SH256));
END;
/

DECLARE
        v_salt RAW(32) := DBMS_CRYPTO.RANDOMBYTES(32);
        v_pwd RAW(128) := UTL_I18N.STRING_TO_RAW(DATA  => 'giulia_verdi' /*IN VARCHAR2*/,
                                                DST_CHARSET  => 'AL32UTF8' /*IN VARCHAR2*/);
        v_concats RAW(128) := UTL_RAW.CONCAT(R1  => v_pwd /*IN RAW*/,
                                        R2  => v_salt /*IN RAW*/);
BEGIN

INSERT INTO BE_UTENTE VALUES (11, 'PQRSTU34V56W789X', 'Giulia', 'Verdi' , 'carta', 1, v_salt, 'giulia_verdi', DBMS_CRYPTO.HASH(v_concats, DBMS_CRYPTO.HASH_SH256));
END;
/

DECLARE
        v_salt RAW(32) := DBMS_CRYPTO.RANDOMBYTES(32);
        v_pwd RAW(128) := UTL_I18N.STRING_TO_RAW(DATA  => 'laura_lete' /*IN VARCHAR2*/,
                                                DST_CHARSET  => 'AL32UTF8' /*IN VARCHAR2*/);
        v_concats RAW(128) := UTL_RAW.CONCAT(R1  => v_pwd /*IN RAW*/,
                                        R2  => v_salt /*IN RAW*/);
BEGIN

INSERT INTO be_Utente VALUES (12, 'QSDBCH11C9E410BP', 'Laura', 'Lete', 'carta', 1, v_salt, 'laura_lete', DBMS_CRYPTO.HASH(v_concats, DBMS_CRYPTO.HASH_SH256));
END;
/

DECLARE
        v_salt RAW(32) := DBMS_CRYPTO.RANDOMBYTES(32);
        v_pwd RAW(128) := UTL_I18N.STRING_TO_RAW(DATA  => 'eugenio_impastato' /*IN VARCHAR2*/,
                                                DST_CHARSET  => 'AL32UTF8' /*IN VARCHAR2*/);
        v_concats RAW(128) := UTL_RAW.CONCAT(R1  => v_pwd /*IN RAW*/,
                                        R2  => v_salt /*IN RAW*/);
BEGIN

INSERT INTO be_Utente VALUES (13, 'QSDBCH31C9E610BP', 'Eugenio', 'Impastato', 'carta', 1, v_salt, 'eugenio_impastato', DBMS_CRYPTO.HASH(v_concats, DBMS_CRYPTO.HASH_SH256));
END;
/


---roulo
insert into RUOLO (IDRUOLO, NOME) VALUES (1, 'ADMIN');
insert into RUOLO (IDRUOLO, NOME) VALUES (2, 'ADMIN_TOUR');
insert into RUOLO (IDRUOLO, NOME) VALUES (3, 'ADMIN_CROCIERE');
insert into RUOLO (IDRUOLO, NOME) VALUES (4, 'ADMIN_PRENOTAZIONI');
insert into RUOLO (IDRUOLO, NOME) VALUES (5, 'STATISTA');

---utenteruolo
insert into UTENTERUOLO (IDUTENTE, IDRUOLO) values (1, 1);

insert into UTENTERUOLO (IDUTENTE, IDRUOLO) values (12, 2);
insert into UTENTERUOLO (IDUTENTE, IDRUOLO) values (11, 3);
insert into UTENTERUOLO (IDUTENTE, IDRUOLO) values (13, 5);

---permesso
insert into PERMESSO (NOME) VALUES ('cu_blu');
insert into PERMESSO (NOME) VALUES ('d_blu');

insert into PERMESSO (NOME) VALUES ('cu_rosso');
insert into PERMESSO (NOME) VALUES ('d_rosso');

insert into PERMESSO (NOME) VALUES ('cu_verde');
insert into PERMESSO (NOME) VALUES ('d_verde');

insert into PERMESSO (NOME) VALUES ('cu_tutto');
insert into PERMESSO (NOME) VALUES ('d_tutto');

insert into PERMESSO (NOME) VALUES ('stat');

---ruolopermesso
insert into RUOLOPERMESSO (IDRUOLO, NOMEPERMESSO) VALUES (1, 'cu_tutto');
insert into RUOLOPERMESSO (IDRUOLO, NOMEPERMESSO) VALUES (1, 'd_tutto');
insert into RUOLOPERMESSO (IDRUOLO, NOMEPERMESSO) VALUES (1, 'stat');

insert into RUOLOPERMESSO (IDRUOLO, NOMEPERMESSO) VALUES (2, 'cu_blu');
insert into RUOLOPERMESSO (IDRUOLO, NOMEPERMESSO) VALUES (2, 'd_blu');
insert into RUOLOPERMESSO (IDRUOLO, NOMEPERMESSO) VALUES (2, 'stat');

insert into RUOLOPERMESSO (IDRUOLO, NOMEPERMESSO) VALUES (3, 'cu_rosso');
insert into RUOLOPERMESSO (IDRUOLO, NOMEPERMESSO) VALUES (3, 'd_rosso');
insert into RUOLOPERMESSO (IDRUOLO, NOMEPERMESSO) VALUES (3, 'stat');

insert into RUOLOPERMESSO (IDRUOLO, NOMEPERMESSO) VALUES (4, 'cu_verde');
insert into RUOLOPERMESSO (IDRUOLO, NOMEPERMESSO) VALUES (4, 'd_verde');
insert into RUOLOPERMESSO (IDRUOLO, NOMEPERMESSO) VALUES (4, 'stat');

insert into RUOLOPERMESSO (IDRUOLO, NOMEPERMESSO) VALUES (5, 'stat');

---prenotazione
insert into PRENOTAZIONE (IDPRENOTAZIONE, IDCLIENTE,IDCROCIERA,COSTOBASE,DATAPRENOTAZIONE,QUANTITASALDATA)values (1,2,6,2300, TO_DATE('2023/05/29', 'YYYY-MM-DD'), 2300);
insert into PRENOTAZIONE (IDPRENOTAZIONE, IDCLIENTE,IDCROCIERA,COSTOBASE,DATAPRENOTAZIONE,QUANTITASALDATA)values (2,3,6,2400, TO_DATE('2023/01/02', 'YYYY-MM-DD'), 2400);
insert into PRENOTAZIONE (IDPRENOTAZIONE, IDCLIENTE,IDCROCIERA,COSTOBASE,DATAPRENOTAZIONE,QUANTITASALDATA)values (3,4,6,2400, TO_DATE('2023/01/02', 'YYYY-MM-DD'), 2400);
insert into PRENOTAZIONE (IDPRENOTAZIONE, IDCLIENTE,IDCROCIERA,COSTOBASE,DATAPRENOTAZIONE,QUANTITASALDATA)values (4,5,6,2400, TO_DATE('2023/01/02', 'YYYY-MM-DD'), 2400);
insert into PRENOTAZIONE (IDPRENOTAZIONE, IDCLIENTE,IDCROCIERA,COSTOBASE,DATAPRENOTAZIONE,QUANTITASALDATA)values (5,6,6,2400, TO_DATE('2023/01/02', 'YYYY-MM-DD'), 2400);


---preprenotazione
insert into PREPRENOTAZIONE (IDPRENOTAZIONE, TIPOLOGIA, QUANTITA) VALUES (1,'Doppia',3);
insert into PREPRENOTAZIONE (IDPRENOTAZIONE, TIPOLOGIA, QUANTITA) VALUES (2,'Doppia',4);
insert into PREPRENOTAZIONE (IDPRENOTAZIONE, TIPOLOGIA, QUANTITA) VALUES (3,'Doppia',2);
insert into PREPRENOTAZIONE (IDPRENOTAZIONE, TIPOLOGIA, QUANTITA) VALUES (3,'Singola',1);
insert into PREPRENOTAZIONE (IDPRENOTAZIONE, TIPOLOGIA, QUANTITA) VALUES (4,'Doppia',2);
insert into PREPRENOTAZIONE (IDPRENOTAZIONE, TIPOLOGIA, QUANTITA) VALUES (4,'Singola',1);
insert into PREPRENOTAZIONE (IDPRENOTAZIONE, TIPOLOGIA, QUANTITA) VALUES (5,'Doppia',2);
insert into PREPRENOTAZIONE (IDPRENOTAZIONE, TIPOLOGIA, QUANTITA) VALUES (5,'Singola',1);

---clienteriferimento
insert into CLIENTERIFERIMENTO (IDPRENOTAZIONE, IDCLIENTE) VALUES (1, 1);
insert into CLIENTERIFERIMENTO (IDPRENOTAZIONE, IDCLIENTE) VALUES (2, 1);

--- imbarco

INSERT INTO IMBARCO (IdImbarco, IdCamera, IdPrenotazione, IDCliente)
VALUES (1, 1, 1, 1);

INSERT INTO IMBARCO (IdImbarco, IdCamera, IdPrenotazione, IDCliente)
VALUES (2, 2, 2, 1);


--RECENSIONE
INSERT INTO RECENSIONE VALUES(1,1,5);
INSERT INTO RECENSIONE VALUES(2,1,7);
INSERT INTO RECENSIONE VALUES(2,2,7);
INSERT INTO RECENSIONE VALUES(2,1,7);
INSERT INTO RECENSIONE VALUES(2,3,9);

-- PRENOTAZIONEVISITA
INSERT INTO PRENOTAZIONEVISITA (IdPrenotazione, IDVisita, NumeroBiglietti, CostoTotaleOrdine, QuantitaSaldata, LINGUA)
VALUES (1, 1, 5, 100, 100, 'Tedesco'); --Lingua

INSERT INTO PRENOTAZIONEVISITA (IdPrenotazione, IDVisita, NumeroBiglietti, CostoTotaleOrdine, QuantitaSaldata, LINGUA)
VALUES (1, 2, 3, 90, 90, 'Inglese');  --prenotazoine visita

INSERT INTO PRENOTAZIONEVISITA (IdPrenotazione, IDVisita, NumeroBiglietti, CostoTotaleOrdine, QuantitaSaldata, LINGUA)
VALUES (2, 4, 2, 60, 60, 'Tedesco'); --prenotazione visita

INSERT INTO PRENOTAZIONEVISITA (IdPrenotazione, IDVisita, NumeroBiglietti, CostoTotaleOrdine, QuantitaSaldata, LINGUA)
VALUES (1, 3, 4, 100, 100, 'Francese'); --lingua
INSERT INTO PRENOTAZIONEVISITA (IdPrenotazione, IDVisita, NumeroBiglietti, CostoTotaleOrdine, QuantitaSaldata, LINGUA)
VALUES (1, 5, 1, 100, 100, 'Inglese'); --prenotazione visita
INSERT INTO PRENOTAZIONEVISITA (IdPrenotazione, IDVisita, NumeroBiglietti, CostoTotaleOrdine, QuantitaSaldata, LINGUA)
VALUES (2, 5, 2, 100, 100, 'Inglese'); -- prenotazione visita
INSERT INTO PRENOTAZIONEVISITA (IdPrenotazione, IDVisita, NumeroBiglietti, CostoTotaleOrdine, QuantitaSaldata, LINGUA)
VALUES (3, 5, 1, 100, 100, 'Inglese'); -- prenotazione visita
INSERT INTO PRENOTAZIONEVISITA (IdPrenotazione, IDVisita, NumeroBiglietti, CostoTotaleOrdine, QuantitaSaldata, LINGUA)
VALUES (4, 5, 2, 100, 100, 'Inglese'); -- prenotazione visita
