--
-- Database: gestion_decheterie
-- Ferrara Justin, Graf Andrea, Hussain Lucas
-- GestionDecheterie.sql
-- Script complet de création de la base de données
--

------------------------------------------------------------------------------------------------------------------------
-- Crétion des tables
------------------------------------------------------------------------------------------------------------------------
CREATE SCHEMA gestion_decheterie;
SET search_path TO gestion_decheterie;

CREATE TABLE employe (
    idLogin VARCHAR(30),
    mdpLogin CHAR(60) NOT NULL,
    nom VARCHAR(30) NOT NULL,
    prenom VARCHAR(30) NOT NULL,
    dateNaissance DATE NOT NULL,
    dateDebutContrat DATE NOT NULL,
    numTelephone VARCHAR(30),
    typePermis VARCHAR(30),
    FK_adresse INTEGER,
    FK_decheterie INTEGER NOT NULL,
    FK_fonction VARCHAR(30) NOT NULL,
    PRIMARY KEY (idLogin)
);

CREATE TABLE adresse (
    id SERIAL PRIMARY KEY,
    number VARCHAR(50),
    street VARCHAR(255),
    city VARCHAR(255),
    region VARCHAR(50),
    postcode VARCHAR(50)
);

CREATE TABLE decheterie (
    id INTEGER,
    nom VARCHAR(30) NOT NULL,
    FK_adresse INTEGER NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE vehicule (
    immatriculation VARCHAR(30),
    type VARCHAR(30) NOT NULL,
    remorque BOOLEAN NOT NULL,
    anneeFabrication VARCHAR(10),
    dateExpertise DATE,
    consoCarburant DOUBLE PRECISION,
    FK_decheterie INTEGER NOT NULL,
    PRIMARY KEY (immatriculation)
);

CREATE TABLE contenant (
    id INTEGER,
    nom VARCHAR(30) NOT NULL,
    capaciteMax INTEGER,
    nbCadre INTEGER,
    taille VARCHAR(10),
    couleur VARCHAR(30),
    FK_decheterie INTEGER NOT NULL,
    FK_dechet VARCHAR(30),
    PRIMARY KEY (id)
);

CREATE TABLE dechet (
    type VARCHAR(30),
    PRIMARY KEY (type)
);

CREATE TABLE fonction (
    nom VARCHAR(30),
    PRIMARY KEY (nom)
);

CREATE TABLE status (
    nom VARCHAR(10),
    PRIMARY KEY (nom)
);

CREATE TABLE ramassage (
    id INTEGER,
    date DATE NOT NULL,
    poids DOUBLE PRECISION,
    FK_contenant INTEGER NOT NULL,
    FK_employee VARCHAR(30),
    FK_decheterie INTEGER NOT NULL,
    FK_vehicule VARCHAR(30),
    FK_status varchar(10) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE principale (
    FK_principale INTEGER,
    FK_decheterie INTEGER,
    PRIMARY KEY (FK_principale, FK_decheterie)
);

CREATE TABLE superviseur (
    FK_employee VARCHAR(30),
    FK_superviseur VARCHAR(30),
    PRIMARY KEY (FK_employee, FK_superviseur)
);

ALTER TABLE employe
ADD CONSTRAINT fk_employe_adresse
    FOREIGN KEY (FK_adresse) REFERENCES adresse(id),
ADD CONSTRAINT fk_employe_decheterie
    FOREIGN KEY (FK_decheterie) REFERENCES decheterie(id),
ADD CONSTRAINT fk_employe_fonction
    FOREIGN KEY (FK_fonction) REFERENCES fonction(nom);

ALTER TABLE decheterie
ADD CONSTRAINT fk_decheterie_adresse
    FOREIGN KEY (FK_adresse) REFERENCES adresse(id);

ALTER TABLE vehicule
ADD CONSTRAINT fk_vehicule_decheterie
    FOREIGN KEY (FK_decheterie) REFERENCES decheterie(id);

ALTER TABLE contenant
ADD CONSTRAINT fk_contenant_decheterie
    FOREIGN KEY (FK_decheterie) REFERENCES decheterie(id),
ADD CONSTRAINT fk_contenant_dechet
    FOREIGN KEY (FK_dechet) REFERENCES dechet(type);

ALTER TABLE ramassage
ADD CONSTRAINT fk_ramassage_contenant
    FOREIGN KEY (FK_contenant) REFERENCES contenant(id),
ADD CONSTRAINT fk_ramassage_employee
    FOREIGN KEY (FK_employee) REFERENCES employe(idLogin) ON DELETE SET NULL,
ADD CONSTRAINT fk_ramassage_decheterie
    FOREIGN KEY (FK_decheterie) REFERENCES decheterie(id),
ADD CONSTRAINT fk_ramassage_vehicule
    FOREIGN KEY (FK_vehicule) REFERENCES vehicule(immatriculation);


ALTER TABLE principale
ADD CONSTRAINT fk_principale_decheterie
    FOREIGN KEY (FK_decheterie) REFERENCES decheterie(id),
ADD CONSTRAINT fk_principale_principale
    FOREIGN KEY (FK_principale) REFERENCES decheterie(id);

ALTER TABLE superviseur
ADD CONSTRAINT fk_superviseur_employee
    FOREIGN KEY (FK_employee) REFERENCES employe(idLogin) ON DELETE CASCADE,
ADD CONSTRAINT fk_superviseur_superviseur
    FOREIGN KEY (FK_superviseur) REFERENCES employe(idLogin) ON DELETE CASCADE;

------------------------------------------------------------------------------------------------------------------------
-- Insertion des données
------------------------------------------------------------------------------------------------------------------------
BEGIN;
-- Insert data into the 'adresse' table
COPY adresse (number, street, city, region, postcode)
FROM '/dataAdresse/source.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Insert data into the 'decheterie' table
INSERT INTO decheterie (id, nom, FK_adresse) VALUES
(1, 'Decheterie Yverdon', 1);

-- Insert data into the 'principale' table
INSERT INTO principale (FK_principale, FK_decheterie) VALUES
(1, 1);

-- Insert data into the 'fonction' table
INSERT INTO fonction (nom) VALUES
('Responsable'),
('Secrétaire'),
('Chauffeur'),
('Employé');

-- Insert data into the 'employe' table Responsable, Secrétaire, Chauffeur, Employé de déchèterie
INSERT INTO employe (idLogin, mdpLogin, nom, prenom, dateNaissance, dateDebutContrat, numTelephone, typePermis, FK_adresse,fk_decheterie, fk_fonction) VALUES
('admin', '$2b$10$Db1QVQd2CD.TL47zEZBxSezC.ThYe23b5hBiyUntBBsrgvb6QTkk2', 'name', 'surname', '1980-01-01', '2020-01-01', NULL, NULL, 1, 1, 'Responsable');

-- Insert data into the 'vehicule' table


-- Insert data into the 'dechet' table
INSERT INTO dechet (type) VALUES
('papier'), ('carton'), ('flaconnage'), ('encombrants'), ('déchets verts'), ('inertes'), ('ferraille'), ('pet'), ('alu'), ('fer blanc'),
('verre'), ('bois'), ('appareils électroniques'), ('appareils électriques'), ('déchets spéciaux');

-- Insert data into the 'status' table
INSERT INTO status (nom) VALUES
('accepté'), ('refusé'), ('en attente');

-- Insert data into the 'contenant' table

-- Insert data into the 'ramassage' table

-- Insert data into the 'superviseur' table
INSERT INTO superviseur (FK_employee, FK_superviseur) VALUES
('admin', 'admin');

COMMIT ;
