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