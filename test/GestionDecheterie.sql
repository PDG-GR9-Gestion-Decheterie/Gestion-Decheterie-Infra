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
    id INTEGER,
    rue VARCHAR(30) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    NPA VARCHAR(10) NOT NULL,
    nomVille VARCHAR(30) NOT NULL,
    pays VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
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
INSERT INTO adresse (id, rue, numero, NPA, nomVille, pays) VALUES
(1, 'Rue 1', '1', '1400', 'Yverdon-les-Bains', 'Suisse'),
(2, 'Rue 2', '2', '3000', 'Berne', 'Suisse');

-- Insert data into the 'decheterie' table
INSERT INTO decheterie (id, nom, FK_adresse) VALUES
(1, 'Decheterie Yverdon', 1),
(2, 'Decheterie Berne', 2);

-- Insert data into the 'principale' table

-- Insert data into the 'fonction' table
INSERT INTO fonction (nom) VALUES
('Responsable'),
('Secrétaire'),
('Chauffeur'),
('Employé');

-- Insert data into the 'employe' table Responsable, Secrétaire, Chauffeur, Employé de déchèterie
INSERT INTO employe (idLogin, mdpLogin, nom, prenom, dateNaissance, dateDebutContrat, numTelephone, typePermis, FK_adresse,fk_decheterie, fk_fonction) VALUES
('Resp1', '$2b$10$I/9fLnf2NFR1eRd7IjVa7O5FjuqWoyYlmKzpqM86X7fk.zmfu5z5C', 'Nom', 'Prenom', '2000-01-01', '2020-01-01', NULL, NULL, 1, 1, 'Responsable'),
('Secr1', '$2b$10$rAckvfy0rTT3zmA4OvRrs.aWcJwAGNSNwoeQ.IGTMxsRp/jPCSOiG', 'Nom', 'Prenom', '2000-01-01', '2020-01-01', '0123456789', NULL, 1, 1, 'Secrétaire'),
('Empl1', '$2b$10$.DbDMnSl/gRsoW27UgbK8euqpOxdhMsJVaYS803HRnsgy1BRnerqu', 'Nom', 'Prenom', '2000-01-01', '2020-01-01', '0123456789', NULL, 1, 1, 'Employé'),
('Chauff1', '$2b$10$C5NsJXrXsc2FOy/YBGniz.MbhgrQJQnKjAPcz.QrIvwdPbYCexzuC', 'Nom', 'Prenom', '2000-01-01', '2020-01-01', NULL, 'C', 1, 1, 'Chauffeur'),
('Resp2', '$2b$10$wFCDg.Y6qfUJ1tArWOo4xuCMx89oLZ83BnWfX.htQ9PmlzK279H6G', 'Nom', 'Prenom', '2000-01-01', '2020-01-01', '0123456789', NULL, 2, 2, 'Responsable'),
('Secr2', '$2b$10$oWhiI6le5pI3mX1ON69DIePIR.r1cmp4MMcuyn3lavs1NGqOhAxce', 'Nom', 'Prenom', '2000-01-01', '2020-01-01', '0123456789', NULL, 2, 2, 'Secrétaire'),
('Empl2', '$2b$10$ZBz2LfuMGioA9pRfj5hwi.fHrPp7K9SwBZSLIOrIzc8jDSRQUD/b6', 'Nom', 'Prenom', '2000-01-01', '2020-01-01', '0123456789', NULL, 2, 2, 'Employé'),
('Chauff2', '$2b$10$qpU/j70xZHWaxAqdkLuSmudKYoXzm.kHhyBEitDlrbh3opRGgp3/i', 'Nom', 'Prenom', '2000-01-01', '2020-01-01', '0123456789', 'C', 2, 2, 'Chauffeur');

-- Insert data into the 'vehicule' table
INSERT INTO vehicule (immatriculation, type, remorque, anneeFabrication, dateExpertise, consoCarburant, FK_decheterie) VALUES
('VD100000', 'camion', FALSE, '2010', '2022-01-01', 10.5, 1),
('VD100001', 'camionnette', FALSE, '2010', '2022-01-01', 10.5, 1),
('VD200000', 'camion', FALSE, '2010', '2022-01-01', 10.5, 2),
('VD200001', 'camionnette', FALSE, '2010', '2022-01-01', 10.5, 2);


-- Insert data into the 'dechet' table
INSERT INTO dechet (type) VALUES
('papier'), ('carton'), ('flaconnage'), ('encombrants'), ('déchets verts'), ('inertes'), ('ferraille'), ('pet'), ('alu'), ('fer blanc'),
('verre'), ('bois'), ('appareils électroniques'), ('appareils électriques'), ('déchets spéciaux');

-- Insert data into the 'status' table
INSERT INTO status (nom) VALUES
('accepté'), ('refusé'), ('en attente');

-- Insert data into the 'contenant' table
INSERT INTO contenant (id, nom, capaciteMax, nbCadre, taille, couleur, FK_decheterie, FK_dechet) VALUES
(1, 'benne', 40, NULL, NULL, 'bleu', 1, 'papier'),
(2, 'benne', 40, NULL, NULL, 'bleu', 2, 'papier');

-- Insert data into the 'ramassage' table
INSERT INTO ramassage (id, date, fk_status, poids, FK_contenant, FK_employee, FK_decheterie, FK_vehicule) VALUES
(1, '2022-01-01', 'accepté', 100, 1, 'Chauff1', 1, 'VD100000'),
(2, '2022-01-01', 'accepté', 100, 1, 'Chauff2', 1, 'VD200000');

-- Insert data into the 'superviseur' table
INSERT INTO superviseur (FK_employee, FK_superviseur) VALUES
('Resp1', 'Resp1'),
('Secr1', 'Resp1'),
('Empl1', 'Resp1'),
('Chauff1', 'Resp1'),
('Resp2', 'Resp2'),
('Secr2', 'Resp2'),
('Empl2', 'Resp2'),
('Chauff2', 'Resp2');

COMMIT;
