--------------------------------------------------------------------------------
-- TABLA: ClaseAutor
--------------------------------------------------------------------------------
CREATE TABLE ClaseAutor (
    ClaseAutorId NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NombreClase VARCHAR2(20) NOT NULL UNIQUE
);

INSERT INTO ClaseAutor (NombreClase) VALUES ('PRIMARIO');
INSERT INTO ClaseAutor (NombreClase) VALUES ('SECUNDARIO');
INSERT INTO ClaseAutor (NombreClase) VALUES ('TERCIARIO');

COMMIT;


--------------------------------------------------------------------------------
-- TABLA: Publicacion
--------------------------------------------------------------------------------
CREATE TABLE Publicacion (
    DOI VARCHAR2(255) PRIMARY KEY,
    Nombre_Publicacion VARCHAR2(500) NOT NULL
);


--------------------------------------------------------------------------------
-- TABLA: Autor
--------------------------------------------------------------------------------
CREATE TABLE Autor (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Nombre  VARCHAR2(255) NOT NULL,
    Apellido VARCHAR2(255) NOT NULL
);


--------------------------------------------------------------------------------
-- TABLA RELACIONAL: Publicacion_Autor
--------------------------------------------------------------------------------
CREATE TABLE Publicacion_Autor (
    DOI VARCHAR2(255) NOT NULL,
    AutorId NUMBER NOT NULL,
    ClaseAutorId NUMBER NOT NULL,

    PRIMARY KEY (DOI, AutorId),

    FOREIGN KEY (DOI) REFERENCES Publicacion(DOI),
    FOREIGN KEY (AutorId) REFERENCES Autor(id),
    FOREIGN KEY (ClaseAutorId) REFERENCES ClaseAutor(ClaseAutorId)
);


--------------------------------------------------------------------------------
-- TABLA: Compuesto
--------------------------------------------------------------------------------
CREATE TABLE Compuesto (
    CompuestoId NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Codigo_IUPAC VARCHAR2(1000),
    Codigo_SMILES VARCHAR2(1000),
    Publicacion VARCHAR2(255),
    CONSTRAINT fk_compuesto_publicacion
        FOREIGN KEY (Publicacion) REFERENCES Publicacion(DOI)
);


--------------------------------------------------------------------------------
-- TABLA: Propiedades
--------------------------------------------------------------------------------
CREATE TABLE Propiedades (
    PropiedadId NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    CompuestoId NUMBER NOT NULL,

    Metodos_Extraccion         VARCHAR2(2000),
    Metodos_Identificacion     VARCHAR2(2000),
    Metodos_Cuantificacion     VARCHAR2(2000),

    Estudios_in_vitro          VARCHAR2(2000),
    Estudios_in_cellula        VARCHAR2(2000),
    Estudios_in_vivo           VARCHAR2(2000),
    Estudios_in_silico         VARCHAR2(2000),

    Vias_Metabolicas_Afectadas VARCHAR2(2000),
    Mecanismo_Accion           VARCHAR2(2000),
    Biodisponibilidad          VARCHAR2(2000),
    Propiedades_PK             VARCHAR2(2000),
    Propiedades_PD             VARCHAR2(2000),

    CONSTRAINT fk_prop_compuesto
        FOREIGN KEY (CompuestoId) REFERENCES Compuesto(CompuestoId)
);


--------------------------------------------------------------------------------
-- TABLA RELACIONAL: Publicacion_Compuesto
--------------------------------------------------------------------------------
CREATE TABLE Publicacion_Compuesto (
    DOI VARCHAR2(255) NOT NULL,
    CompuestoId NUMBER NOT NULL,

    PRIMARY KEY (DOI, CompuestoId),

    FOREIGN KEY (DOI) REFERENCES Publicacion(DOI),
    FOREIGN KEY (CompuestoId) REFERENCES Compuesto(CompuestoId)
);


--------------------------------------------------------------------------------
-- TABLA: Fuente
--------------------------------------------------------------------------------
CREATE TABLE Fuente (
    FuenteId NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    NombreFuente VARCHAR2(255) NOT NULL,
    TipoFuente VARCHAR2(50)
        CHECK (TipoFuente IN ('PLANTA', 'ALIMENTO'))
);


--------------------------------------------------------------------------------
-- TABLA RELACIONAL: Compuesto_Fuente
--------------------------------------------------------------------------------
CREATE TABLE Compuesto_Fuente (
    CompuestoId NUMBER NOT NULL,
    FuenteId    NUMBER NOT NULL,

    PRIMARY KEY (CompuestoId, FuenteId),

    CONSTRAINT fk_cf_compuesto
        FOREIGN KEY (CompuestoId) REFERENCES Compuesto(CompuestoId),

    CONSTRAINT fk_cf_fuente
        FOREIGN KEY (FuenteId) REFERENCES Fuente(FuenteId)
);

CREATE TABLE UserUpload (
    UploadId NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    CompuestoId NUMBER NOT NULL,

    UserName  VARCHAR2(255) NOT NULL,
    UserClass VARCHAR2(50)
        CHECK (UserClass IN ('ADMIN', 'RESEARCHER')),

    CONSTRAINT fk_upload_compuesto
        FOREIGN KEY (CompuestoId)
        REFERENCES Compuesto(CompuestoId)
);

