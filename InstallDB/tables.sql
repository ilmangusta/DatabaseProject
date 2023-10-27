-- @Author : LucaBorrello 

drop table CAMERA CASCADE CONSTRAINTS;
drop table CLIENTERIFERIMENTO CASCADE CONSTRAINTS;
drop table CROCIERA CASCADE CONSTRAINTS;
drop table GESTISCE CASCADE CONSTRAINTS;
drop table GUIDA CASCADE CONSTRAINTS;
drop table IMBARCO CASCADE CONSTRAINTS;
drop table INCLUDE CASCADE CONSTRAINTS;
drop table LINGUE CASCADE CONSTRAINTS;
drop table LOCALITA CASCADE CONSTRAINTS;
drop table LUOGOVISITA CASCADE CONSTRAINTS;
drop table LUOGOINTERESSE CASCADE CONSTRAINTS;
drop table NAVE CASCADE CONSTRAINTS;
drop table PARLA CASCADE CONSTRAINTS;
drop table PORTO CASCADE CONSTRAINTS;
drop table RAGGIUNGE CASCADE CONSTRAINTS;
drop table PRENOTAZIONE CASCADE CONSTRAINTS;
drop table PRENOTAZIONEVISITA CASCADE CONSTRAINTS;
drop table PREPRENOTAZIONE CASCADE CONSTRAINTS;
drop table DISPONIBILITACAMERE CASCADE CONSTRAINTS;
drop table RECENSIONE CASCADE CONSTRAINTS;
drop table TIPOCAMERA CASCADE CONSTRAINTS;
drop table TOUR CASCADE CONSTRAINTS;
drop table VISITAGUIDATA CASCADE CONSTRAINTS;
drop table VISITEDISPONIBILI CASCADE CONSTRAINTS;

-- @Author : Gabriele

drop table RUOLOPERMESSO CASCADE CONSTRAINTS;
drop table UTENTERUOLO CASCADE CONSTRAINTS;
drop table EMAIL CASCADE CONSTRAINTS;
drop table TELEFONO CASCADE CONSTRAINTS;
drop view SESSIONE CASCADE CONSTRAINTS;
drop view Utente CASCADE CONSTRAINTS;
drop table BE_SESSIONE CASCADE CONSTRAINTS;
drop table BE_UTENTE CASCADE CONSTRAINTS;
drop table RUOLO CASCADE CONSTRAINTS;
drop table PERMESSO CASCADE CONSTRAINTS;

-- @Author : Fabiana

DROP TABLE RECENSIONEANOMALA;
DROP TABLE LOGCLIENTE;

CREATE TABLE RECENSIONEANOMALA (
    Clienteanomalo NUMBER(38) PRIMARY KEY,
    idvisita NUMBER(38) not NULL,
    nuovovoto NUMBER(38),
    vecchiovoto NUMBER(38)
);

CREATE TABLE LOGCLIENTE (
    idcliente NUMBER(38) PRIMARY KEY,
    campomodificato VARCHAR2(255),
    valoreprecedente VARCHAR2(255),
    valorenuovo VARCHAR2(255),
    datamodifica DATE
);

-- @Author : Gabriele

CREATE TABLE be_UTENTE(
        IDUtente INT PRIMARY KEY,
        CF CHAR(16) NOT NULL UNIQUE,
        Nome VARCHAR2(255) NOT NULL,
        Cognome VARCHAR2(255) NOT NULL,
        InformazioniPagamento VARCHAR2(255) NOT NULL,
        EPrivilegiato NUMBER(1) NOT NULL,
        SALT RAW(32) NOT NULL,
        username VARCHAR2(64) NOT NULL UNIQUE,
        password RAW(32) NOT NULL
);

CREATE TABLE Ruolo (
        IDRuolo INT PRIMARY KEY,
        Nome VARCHAR2(32) NOT NULL
);

CREATE TABLE Permesso (
        Nome VARCHAR2(32) PRIMARY KEY
);

CREATE TABLE be_SESSIONE(
        IDSessione INT PRIMARY KEY,
        IDUtente INT NOT NULL,
        EPrivilegiato NUMBER(1) NOT NULL,
        TStamp TIMESTAMP(4) NOT NULL,
        PEPPER RAW(32) NOT NULL,
        FOREIGN KEY(IDUtente) REFERENCES BE_Utente(IDUtente)
);

CREATE TABLE Telefono (
        IDUtente INT NOT NULL,
        Telefono VARCHAR2(32) PRIMARY KEY,
        FOREIGN KEY(IDUtente) REFERENCES BE_Utente(IDUtente)
);

CREATE TABLE Email (
        IDUtente INT NOT NULL,
        Email VARCHAR2(255) PRIMARY KEY,
        FOREIGN KEY(IDUtente) REFERENCES BE_Utente(IDUtente)
);

CREATE TABLE UtenteRuolo (
        IDUtente INT NOT NULL,
        IDRuolo INT NOT NULL,
        FOREIGN KEY(IDRuolo) REFERENCES Ruolo(IDRuolo),
        FOREIGN KEY(IDUtente) REFERENCES BE_Utente(IDUtente),
        PRIMARY KEY(IDRuolo, IDUtente)
);

CREATE TABLE RuoloPermesso (
        IDRuolo INT NOT NULL,
        NomePermesso VARCHAR2(32) NOT NULL,
        FOREIGN KEY(IDRuolo) REFERENCES Ruolo(IDRuolo),
        FOREIGN KEY(NomePermesso) REFERENCES Permesso(Nome),
        PRIMARY KEY(IDRuolo, NomePermesso)
);

CREATE VIEW Utente AS
        SELECT idutente, username, CF, Nome, Cognome, INFORMAZIONIPAGAMENTO, EPRIVILEGIATO
        FROM be_UTENTE
;

CREATE VIEW Sessione AS
        SELECT IDSESSIONE, IDUTENTE, EPRIVILEGIATO, TSTAMP
        FROM be_SESSIONE
;


-- @Author : LucaBorrello

Create table GUIDA (
    IDGuida int PRIMARY KEY,
    CF CHAR(16) not null,
    Nome VARCHAR2(225) not NULL,
    Cognome VARCHAR2(225) not NULL
);

create table LINGUE (
    Lingua VARCHAR2(255) not null PRIMARY KEY
);

create table PARLA (
    IDGuida int not null,
    Lingua VARCHAR2(255) not null,
    FOREIGN KEY (IDGuida) REFERENCES GUIDA(IDGuida),
    FOREIGN KEY (Lingua) REFERENCES LINGUE(Lingua),
    PRIMARY KEY (IDGuida, Lingua)
);


CREATE TABLE VISITAGUIDATA (
    IDVisita int PRIMARY KEY,
    NomeVisita varchar2(225) not null,
    DurataVisita int not NULL,
    CostoVisita int not NULL,
    isDisponibile NUMBER(1) not NULL,
    nPersone int not NULL,
    check (0 < DurataVisita and 0 < CostoVisita and 0 < nPersone)

);

CREATE TABLE NAVE(
    IDNave int PRIMARY KEY,
	NomeNave varchar2(255) not null,
	Lunghezza int not null, 
	Larghezza int not null,
	Altezza int not null,
	Peso int not null, 
	Descrizione varchar2(255) not null,
    check (0<Lunghezza and 0<Larghezza and 0 < Altezza and 0 < Peso)
);

CREATE TABLE TOUR (
    IDTour int PRIMARY KEY,
    NomeTour VARCHAR2(225) not null,
    numeroNotti int not NULL,
    numeroTappe int not null,
    check (0 < numeroNotti and 0 < numeroTappe)
);

CREATE TABLE PORTO (
    PosGeografica VARCHAR2(255) not null PRIMARY KEY,
    NomePorto VARCHAR2(255) not NULL,
    NumeroPosti int not NULL,
    check(0 < NumeroPosti)
);

CREATE TABLE LOCALITA(
    PosGeografica VARCHAR2(255)  PRIMARY KEY,
    NomeLocalita VARCHAR2(255) not NULL,
    GiorniConsigliati int not null,
    check(0 < GiorniConsigliati)
);

CREATE TABLE LUOGOINTERESSE (
    IDLuogointeresse int PRIMARY KEY,
    PosGeografica VARCHAR2(255) REFERENCES LOCALITA(PosGeografica),
    NomeLuogointeresse VARCHAR2(255),
    Tipologia VARCHAR2(255) not NULL,
    isDisponibile NUMBER(1) not null
);

CREATE TABLE GESTISCE (
    IDGuida int not null REFERENCES Guida(IDGuida),
    IDVisita int not null REFERENCES VisitaGuidata(IDVisita),
    lingua VARCHAR2(225) not NULL,
    PRIMARY KEY (IDGuida, IDVisita)
);

CREATE TABLE LUOGOVISITA (
    IDVisita int not null REFERENCES VisitaGuidata(IDVisita),
    IDLuogointeresse int not null  REFERENCES LUOGOintERESSE(IDLuogointeresse),
    PRIMARY KEY (IDVisita, IDLuogointeresse)
);

CREATE TABLE CROCIERA(
    IDCrociera int not null primary key,
    IDNave int not null REFERENCES NAVE(IDNave),
    IDTour int not null REFERENCES TOUR(IDTour),
    DataCrociera date not null,
    CostoCrociera int not null,
    isDisponibile NUMBER(1) not null,
    check (0 < CostoCrociera )

);

CREATE table VISITEDISPONIBILI(
    IDCrociera int not null REFERENCES CROCIERA(IDCrociera),
    IDVisita int not null REFERENCES VISITAGUIDATA(IDVisita),
    DataVisita date not null,
    PRIMARY KEY (IDCrociera, IDVisita)
);

CREATE TABLE INCLUDE (
    IDTour int REFERENCES TOUR(IDTour),
    PosGeografica VARCHAR2(255) REFERENCES PORTO(PosGeografica),
    Ordine int not null,
    PRIMARY KEY (IDTour, PosGeografica),
    check(0 < Ordine)
);

CREATE TABLE RAGGIUNGE(
    PosGeograficaPorto VARCHAR2(255) REFERENCES PORTO(PosGeografica),
    PosGeograficaLocalita VARCHAR2(255) REFERENCES LOCALITA(PosGeografica),
    Distanza int not NULL,
    Mezzo VARCHAR2(255) not null,
    PRIMARY KEY (PosGeograficaPorto, PosGeograficaLocalita),
    check(0 <= Distanza)
);

CREATE TABLE PRENOTAZIONE(
    IdPrenotazione int not null primary key,
    IDCliente int NOT NULL references BE_UTENTE(IDUTENTE),
	IDCrociera int not null REFERENCES CROCIERA(IDCrociera),
    CostoBase int not null,
    DataPrenotazione date not null,
    QuantitaSaldata int not null,
    check (QuantitaSaldata >= 0 and QUANTITASALDATA <= CostoBase)
);

CREATE TABLE  TIPOCAMERA(
    Tipologia varchar2(255) not null primary key,
    Costo int not null, 
    PianoNave int not null,
    check (0 < Costo and 0 < PianoNave)
);

CREATE TABLE CAMERA(
    IdCamera int not null primary key,
    IDNave int not null references NAVE(IDNave),
    Tipologia varchar2(255) not null references TIPOCAMERA(Tipologia),
    isDisponibile int not null
);

CREATE TABLE IMBARCO(
    IdImbarco int not null primary key, 
    IdCamera int not null references CAMERA(IdCamera), 
    IdPrenotazione int not null  references PRENOTAZIONE(IdPrenotazione),
    IDCliente int not null references BE_UTENTE(IDUTENTE)
);

CREATE TABLE PRENOTAZIONEVISITA(
    IdPrenotazione int not null references PRENOTAZIONE(IdPrenotazione),
    IDVisita int not null references VISITAGUIDATA(IDVisita), 
    NumeroBiglietti int not null,
    CostoTotaleOrdine int not null, 
    QuantitaSaldata int not null,
    LINGUA VARCHAR2(255) NOT NULL REFERENCES LINGUE(LINGUA),
    primary key(IdPrenotazione,IDVisita),
    check (0<NumeroBiglietti and QuantitaSaldata<=CostoTotaleOrdine and 0<=QuantitaSaldata)
);

CREATE TABLE PREPRENOTAZIONE(
    IdPrenotazione int not null references PRENOTAZIONE(IdPrenotazione),
    Tipologia varchar2(255) not null references TIPOCAMERA(Tipologia),
    Quantita int not null,
    primary key(IdPrenotazione, Tipologia),
    check (0 < Quantita)
);

CREATE TABLE RECENSIONE(
    IdImbarco int not null references IMBARCO(IdImbarco), 
    IDVisita int not null references VISITAGUIDATA(IDVisita) ,
    Voto int not null,
    primary key(IdImbarco,IDVisita),
    check (1<=Voto and Voto <= 10)
);

CREATE TABLE CLIENTERIFERIMENTO (
    IdPrenotazione int NOT NULL references PRENOTAZIONE(IdPrenotazione),
    IDCliente int NOT NULL references BE_UTENTE(IDUTENTE),
    primary key(IdPrenotazione,IDCliente)
);

CREATE TABLE DISPONIBILITACAMERE(
    IDCrociera int not null references CROCIERA(IDCrociera),
    Tipologia varchar2(255) not null references TIPOCAMERA(Tipologia), 
    NumeroPostiLiberi int not null, 
    NumeroPostiTotali int not null,
    primary key(IDCrociera,Tipologia),
    check (NumeroPostiLiberi<=NumeroPostiTotali and NumeroPostiLiberi>=0)

);
