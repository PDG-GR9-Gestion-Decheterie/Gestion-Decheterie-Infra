--
-- Database: gestion_decheterie
-- Ferrara Justin, Graf Andrea, Hussain Lucas
-- GestionDecheterie.sql
-- Script complet de création de la base de données
--

------------------------------------------------------------------------------------------------------------------------
-- Installation des extensions
------------------------------------------------------------------------------------------------------------------------

-- CREATE EXTENSION IF NOT EXISTS postgis;

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
    number VARCHAR(30),
    street VARCHAR(255),
    city VARCHAR(255),
    region VARCHAR(50),
    postcode VARCHAR(30)
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
(1, 'Decheterie Yverdon', 1),
(2, 'Decheterie Yvonand', 2),
(3, 'Decheterie Grandson', 3),
(4, 'Decheterie Bex', 4),
(5, 'Decheterie Saillon', 5),
(6, 'Decheterie Verbier', 6);

-- Insert data into the 'principale' table
INSERT INTO principale (FK_principale, FK_decheterie) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(5, 5),
(5, 6);

-- Insert data into the 'fonction' table
INSERT INTO fonction (nom) VALUES
('Responsable'),
('Secrétaire'),
('Chauffeur'),
('Employé');

-- Insert data into the 'employe' table Responsable, Secrétaire, Chauffeur, Employé de déchèterie
INSERT INTO employe (idLogin, mdpLogin, nom, prenom, dateNaissance, dateDebutContrat, numTelephone, typePermis, FK_adresse,fk_decheterie, fk_fonction) VALUES
('jdoe', '$2b$10$I/9fLnf2NFR1eRd7IjVa7O5FjuqWoyYlmKzpqM86X7fk.zmfu5z5C', 'Doe', 'John', '1980-01-01', '2020-01-01', NULL, NULL, 7, 1, 'Responsable'),
('agraf', '$2b$10$rAckvfy0rTT3zmA4OvRrs.aWcJwAGNSNwoeQ.IGTMxsRp/jPCSOiG', 'Graf', 'Andrea', '1982-01-01', '2020-01-01', '0123456789', NULL, 9, 2, 'Responsable'),
('jdoe2', '$2b$10$.DbDMnSl/gRsoW27UgbK8euqpOxdhMsJVaYS803HRnsgy1BRnerqu', 'Doe', 'James', '1983-01-01', '2020-01-01', '0123456789', NULL, 11, 3, 'Responsable'),
('jmartin', '$2b$10$C5NsJXrXsc2FOy/YBGniz.MbhgrQJQnKjAPcz.QrIvwdPbYCexzuC', 'Martin', 'Joseph', '1985-01-01', '2020-01-01', NULL, NULL, 15, 4, 'Responsable'),
('jdurand', '$2b$10$wFCDg.Y6qfUJ1tArWOo4xuCMx89oLZ83BnWfX.htQ9PmlzK279H6G', 'Durand', 'Joseph', '1985-01-01', '2020-01-01', '0123456789', NULL, 15, 5, 'Responsable'),
('hlopez', '$2b$10$oWhiI6le5pI3mX1ON69DIePIR.r1cmp4MMcuyn3lavs1NGqOhAxce', 'Lopez', 'Hugo', '1985-01-01', '2020-01-01', '0123456789', NULL, 15, 6, 'Responsable'),
('jferrara', '$2b$10$ZBz2LfuMGioA9pRfj5hwi.fHrPp7K9SwBZSLIOrIzc8jDSRQUD/b6', 'Ferrara', 'Justin', '1986-01-01', '2021-01-01', '0123456789', NULL, 10, 1, 'Secrétaire'),
('lhussain', '$2b$10$qpU/j70xZHWaxAqdkLuSmudKYoXzm.kHhyBEitDlrbh3opRGgp3/i', 'Hussain', 'Lucas', '1986-01-01', '2021-01-01', '0123456789', NULL, 10, 1, 'Secrétaire'),
('jdoe3', '$2b$10$XfjNsDG57hJiZ0bdRz9F1eRsTSe4SvRxTI81kZcl8R/F65fGScPfq', 'Doe', 'Jennifer', '1984-01-01', '2020-01-01', '0123456789', NULL, 13, 5, 'Secrétaire'),
('asmith', '$2b$10$6pNCzfhLhPHkTBr8GeCMUeZ2EMOYGldsqToHP7EZz6ppfEzV.ENpW', 'Smith', 'Alice', '1985-01-01', '2021-01-01', '0123456789', NULL, 8, 1, 'Employé'),
('rsmith', '$2b$10$UQYCKx0XssASP6RlRpE..e8H1tPPGPEeQOCgcmTxoz0mRTU8j0Qyu', 'Smith', 'Robert', '1987-01-01', '2021-01-01', '0123456789', NULL, 12, 2, 'Employé'),
('rlandry', '$2b$10$Yxj4CLgN3NdbEc5R.DgnD.b98ZP8RGinKsUMEhbhjf5.HdusyVp5W', 'Landry', 'Rachel', '1989-01-01', '2021-01-01', NULL, NULL, 16, 6, 'Employé'),
('rsmith2', '$2b$10$wlLT1aTzrgCj5.iBvHs/hO8WfIahgDSjCseAVZZeaGWXFmtVly/Ea', 'Smith', 'Rebecca', '1988-01-01', '2021-01-01', '0123456789', 'C', 14, 1, 'Chauffeur'),
('rfournier', '$2b$10$DOj7mK.iVVnwPmRpesjvCOdpcaHr7ns9atfk7D0vFQalzWWuMQt/e', 'Fournier', 'Rebecca', '1988-01-01', '2021-01-01', '0123456789', 'B', 14, 1, 'Chauffeur'),
('lchevalier', '$2b$10$YpnPI6qA0cQODzeItxSwXeZxPONUhgUop0Sch47lyYZigeu.sgH6e', 'Chevalier', 'Lance', '1988-01-01', '2021-01-01', '0123456789', 'B', 14, 5, 'Chauffeur'),
('bleusly', '$2b$10$bbAbfu81Jvn20qvfiyf5hOFPTLxwKBNCeH1jP4DQbFKFNMw90ZxSG', 'Leusly', 'Barbara', '1988-01-01', '2021-01-01', '0123456789', 'C', 14, 5, 'Chauffeur');

-- Insert data into the 'vehicule' table
INSERT INTO vehicule (immatriculation, type, remorque, anneeFabrication, dateExpertise, consoCarburant, FK_decheterie) VALUES
('VD850154', 'camion', FALSE, '2010', '2022-01-01', 10.5, 1),
('VD145154', 'camionnette', FALSE, '2015', '2022-01-01', 7.5, 1),
('VD756254', 'camion', FALSE, '2011', '2022-01-01', 11.5, 1),
('VD896654', 'camionnette', TRUE, '2016', '2022-01-01', 8.5, 1),
('VD857154', 'camion', FALSE, '2011', '2022-01-01', 11.5, 1),
('VD568154', 'camionnette', TRUE, '2018', '2022-07-30', 8.5, 1),
('VD147154', 'camion', FALSE, '2011', '2022-01-01', 11.5, 1),
('VS568745', 'camionnette', TRUE, '2018', '2022-07-30', 8.5, 5),
('VS352125', 'camion', FALSE, '2011', '2022-01-01', 11.5, 5),
('VS255145', 'camionnette', FALSE, '2018', '2022-07-30', 8.5, 5),
('VS458569', 'camion', FALSE, '2011', '2022-01-01', 11.5, 5),
('VS987865', 'camionnette', TRUE, '2018', '2022-07-30', 8.5, 5);


-- Insert data into the 'dechet' table
INSERT INTO dechet (type) VALUES
('papier'), ('carton'), ('flaconnage'), ('encombrants'), ('déchets verts'), ('inertes'), ('ferraille'), ('pet'), ('alu'), ('fer blanc'),
('verre'), ('bois'), ('appareils électroniques'), ('appareils électriques'), ('déchets spéciaux');

-- Insert data into the 'status' table
INSERT INTO status (nom) VALUES
('accepté'), ('refusé'), ('en attente');

-- Insert data into the 'contenant' table
INSERT INTO contenant (id, nom, capaciteMax, nbCadre, taille, couleur, FK_decheterie, FK_dechet) VALUES

--Décheterie 1
(1, 'benne', 40, NULL, NULL, 'bleu', 1, 'papier'),
(2, 'benne', 40, NULL, NULL, 'vert', 1, 'carton'),
(3, 'benne', 40, NULL, NULL, 'rouge', 1, 'flaconnage'),
(4, 'benne', 40, NULL, NULL, 'rouge', 1, 'encombrants'),
(5, 'benne', 30, NULL, NULL, 'rouge', 1, 'inertes'),
(6, 'benne', 40, NULL, NULL, 'rouge', 1, 'ferraille'),
(7, 'benne', 40, NULL, NULL, 'rouge', 1, 'verre'),
(8, 'benne', 40, NULL, NULL, 'rouge', 1, 'bois'),
(9, 'grande caisse', 5, NULL, NULL, NULL, 1, 'pet'),
(10, 'grande caisse', 5, NULL, NULL, NULL, 1, 'alu'),
(11, 'grande caisse', 5, NULL, NULL, NULL, 1, 'fer blanc'),
(12, 'grande caisse', 5, NULL, NULL, NULL, 1, 'déchets spéciaux'),
(13, 'big bag', NULL, NULL, 'grand', NULL, 1, 'déchets verts'),
(14, 'palette', NULL, 3, NULL, NULL, 1, 'appareils électroniques'),
(15, 'palette', NULL, 4, NULL, NULL, 1, 'appareils électriques'),

--Décheterie 2
(16, 'benne', 40, NULL, NULL, 'bleu', 2, 'papier'),
(17, 'benne', 40, NULL, NULL, 'vert', 2, 'carton'),
(18, 'benne', 40, NULL, NULL, 'rouge', 2, 'flaconnage'),
(19, 'benne', 40, NULL, NULL, 'rouge', 2, 'encombrants'),
(20, 'benne', 30, NULL, NULL, 'rouge', 2, 'inertes'),
(21, 'benne', 40, NULL, NULL, 'rouge', 2, 'ferraille'),
(22, 'benne', 40, NULL, NULL, 'rouge', 2, 'verre'),
(23, 'benne', 40, NULL, NULL, 'rouge', 2, 'bois'),
(24, 'grande caisse', 5, NULL, NULL, NULL, 2, 'pet'),
(25, 'grande caisse', 5, NULL, NULL, NULL, 2, 'alu'),
(26, 'grande caisse', 5, NULL, NULL, NULL, 2, 'fer blanc'),
(27, 'grande caisse', 5, NULL, NULL, NULL, 2, 'déchets spéciaux'),
(28, 'big bag', NULL, NULL, 'grand', NULL, 2, 'déchets verts'),
(29, 'palette', NULL, 3, NULL, NULL, 2, 'appareils électroniques'),
(30, 'palette', NULL, 4, NULL, NULL, 2, 'appareils électriques'),

--Décheterie 3
(31, 'benne', 40, NULL, NULL, 'bleu', 3, 'papier'),
(32, 'benne', 40, NULL, NULL, 'vert', 3, 'carton'),
(33, 'benne', 40, NULL, NULL, 'rouge', 3, 'flaconnage'),
(34, 'benne', 40, NULL, NULL, 'rouge', 3, 'encombrants'),
(35, 'benne', 30, NULL, NULL, 'rouge', 3, 'inertes'),
(36, 'benne', 40, NULL, NULL, 'rouge', 3, 'ferraille'),
(37, 'benne', 40, NULL, NULL, 'rouge', 3, 'verre'),
(38, 'benne', 40, NULL, NULL, 'rouge', 3, 'bois'),
(39, 'grande caisse', 5, NULL, NULL, NULL, 3, 'pet'),
(40, 'grande caisse', 5, NULL, NULL, NULL, 3, 'alu'),
(41, 'grande caisse', 5, NULL, NULL, NULL, 3, 'fer blanc'),
(42, 'grande caisse', 5, NULL, NULL, NULL, 3, 'déchets spéciaux'),
(43, 'big bag', NULL, NULL, 'grand', NULL, 3, 'déchets verts'),
(44, 'palette', NULL, 3, NULL, NULL, 3, 'appareils électroniques'),
(45, 'palette', NULL, 4, NULL, NULL, 3, 'appareils électriques'),

--Décheterie 4
(46, 'benne', 40, NULL, NULL, 'bleu', 4, 'papier'),
(47, 'benne', 40, NULL, NULL, 'vert', 4, 'carton'),
(48, 'benne', 40, NULL, NULL, 'rouge', 4, 'flaconnage'),
(49, 'benne', 40, NULL, NULL, 'rouge', 4, 'encombrants'),
(50, 'benne', 30, NULL, NULL, 'rouge', 4, 'inertes'),
(51, 'benne', 40, NULL, NULL, 'rouge', 4, 'ferraille'),
(52, 'benne', 40, NULL, NULL, 'rouge', 4, 'verre'),
(53, 'benne', 40, NULL, NULL, 'rouge', 4, 'bois'),
(54, 'grande caisse', 5, NULL, NULL, NULL, 4, 'pet'),
(55, 'grande caisse', 5, NULL, NULL, NULL, 4, 'alu'),
(56, 'grande caisse', 5, NULL, NULL, NULL, 4, 'fer blanc'),
(57, 'grande caisse', 5, NULL, NULL, NULL, 4, 'déchets spéciaux'),
(58, 'big bag', NULL, NULL, 'grand', NULL, 4, 'déchets verts'),
(59, 'palette', NULL, 3, NULL, NULL, 4, 'appareils électroniques'),
(60, 'palette', NULL, 4, NULL, NULL, 4, 'appareils électriques'),

--Décheterie 5
(61, 'benne', 40, NULL, NULL, 'bleu', 5, 'papier'),
(62, 'benne', 40, NULL, NULL, 'vert', 5, 'carton'),
(63, 'benne', 40, NULL, NULL, 'rouge', 5, 'flaconnage'),
(64, 'benne', 40, NULL, NULL, 'rouge', 5, 'encombrants'),
(65, 'benne', 30, NULL, NULL, 'rouge', 5, 'inertes'),
(66, 'benne', 40, NULL, NULL, 'rouge', 5, 'ferraille'),
(67, 'benne', 40, NULL, NULL, 'rouge', 5, 'verre'),
(68, 'benne', 40, NULL, NULL, 'rouge', 5, 'bois'),
(69, 'grande caisse', 5, NULL, NULL, NULL, 5, 'pet'),
(70, 'grande caisse', 5, NULL, NULL, NULL, 5, 'alu'),
(71, 'grande caisse', 5, NULL, NULL, NULL, 5, 'fer blanc'),
(72, 'grande caisse', 5, NULL, NULL, NULL, 5, 'déchets spéciaux'),
(73, 'big bag', NULL, NULL, 'grand', NULL, 5, 'déchets verts'),
(74, 'palette', NULL, 3, NULL, NULL, 5, 'appareils électroniques'),
(75, 'palette', NULL, 4, NULL, NULL, 5, 'appareils électriques'),

--Décheterie 6
(76, 'benne', 40, NULL, NULL, 'bleu', 6, 'papier'),
(77, 'benne', 40, NULL, NULL, 'vert', 6, 'carton'),
(78, 'benne', 40, NULL, NULL, 'rouge', 6, 'flaconnage'),
(79, 'benne', 40, NULL, NULL, 'rouge', 6, 'encombrants'),
(80, 'benne', 30, NULL, NULL, 'rouge', 6, 'inertes'),
(81, 'benne', 40, NULL, NULL, 'rouge', 6, 'ferraille'),
(82, 'benne', 40, NULL, NULL, 'rouge', 6, 'verre'),
(83, 'benne', 40, NULL, NULL, 'rouge', 6, 'bois'),
(84, 'grande caisse', 5, NULL, NULL, NULL, 6, 'pet'),
(85, 'grande caisse', 5, NULL, NULL, NULL, 6, 'alu'),
(86, 'grande caisse', 5, NULL, NULL, NULL, 6, 'fer blanc'),
(87, 'grande caisse', 5, NULL, NULL, NULL, 6, 'déchets spéciaux'),
(88, 'big bag', NULL, NULL, 'grand', NULL, 6, 'déchets verts'),
(89, 'palette', NULL, 3, NULL, NULL, 6, 'appareils électroniques'),
(90, 'palette', NULL, 4, NULL, NULL, 6, 'appareils électriques');

-- Insert data into the 'ramassage' table
INSERT INTO ramassage (id, date, fk_status, poids, FK_contenant, FK_employee, FK_decheterie, FK_vehicule) VALUES
(1, '2022-01-01', 'accepté', 100, 1, 'rsmith2', 1, 'VD756254'),
(2, '2022-01-02', 'refusé', 55, 28, 'rfournier', 2, 'VD145154'),
(3, '2022-03-06', 'accepté', 89, 59, 'rsmith2', 4, 'VD568154'),
(4, '2028-05-05', 'en attente', 25, 67, 'bleusly', 5, 'VS458569'),
(5, '2028-05-05', 'refusé', 66, 84, 'lchevalier', 6, 'VS987865');

-- Insert data into the 'superviseur' table
INSERT INTO superviseur (FK_employee, FK_superviseur) VALUES
('jdoe', 'jdoe'),
('rfournier', 'jdoe'),
('rsmith2', 'jdoe'),
('asmith', 'jdoe'),
('agraf', 'agraf'),
('bleusly', 'agraf'),
('lchevalier', 'agraf'),
('rsmith', 'agraf'),
('jdoe3', 'agraf'),
('jdoe2', 'jdoe2'),
('jmartin', 'jmartin'),
('jdurand', 'jdurand'),
('hlopez', 'hlopez'),
('rlandry', 'hlopez');
COMMIT ;
