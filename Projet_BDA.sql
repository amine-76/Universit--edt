DROP TABLE etudiant_table;
DROP TABLE enseignant_table;
DROP TABLE edt_table;
DROP TABLE ue_table;
drop type etudiant_type;
drop type edt_type;
drop type enseignant_type;
drop type personne_type;
drop type list_ue;
drop type ue_type;
drop type prenoms_type;


-- Type pour un ue
CREATE TYPE ue_type AS OBJECT
(
    nom           VARCHAR(50),
    type_ue       VARCHAR(2),
    numero_groupe INTEGER
);
/

-- Type de la lists des ues
create type list_ue as table of ref ue_type;
/

-- Type prenom
CREATE TYPE prenoms_type AS TABLE OF VARCHAR2(50);
/

-- Type personne qui accepte l'héritage
CREATE OR REPLACE TYPE personne_type AS OBJECT
(
    nom     VARCHAR2(50),
    prenoms prenoms_type
) NOT FINAL;
/

--Type étudiant qui va hérité dy type personne_type
CREATE OR REPLACE TYPE etudiant_type UNDER personne_type
(
    num_etudiant VARCHAR2(50),
    provenance   VARCHAR2(50),
    ue           list_ue
);
/

-- Type enseignant qui hérite du type personne
CREATE OR REPLACE TYPE enseignant_type UNDER personne_type
(
    matricule VARCHAR2(50)
);
/

--Type emploi_du_temps
CREATE OR REPLACE TYPE edt_type AS OBJECT
(
    jour       VARCHAR(50),
    heure      VARCHAR(50),
    salle      VARCHAR(50),
    ue         REF ue_type,
    enseignant REF enseignant_type
);
/

-- Création de la table Etudiant
CREATE TABLE etudiant_table OF etudiant_type
    NESTED TABLE prenoms STORE AS prenoms_table
    NESTED TABLE ue store as etudiant_ue_table;
/

--Création table enseignant
CREATE TABLE enseignant_table OF enseignant_type
    NESTED TABLE prenoms STORE AS enseignant_prenom_table;
/

--Creation table ue
CREATE TABLE ue_table OF ue_type;
/

--Creation table edt
CREATE TABLE edt_table OF edt_type;
/

-- Insertion dans la table ue
-- Insertion dans la table ue
INSERT INTO ue_table
VALUES (ue_type('Programmation', 'TP', 1));
INSERT INTO ue_table
VALUES (ue_type('Linux',  'TP', 1));
INSERT INTO ue_table
VALUES (ue_type('Programmation', 'TP', 2));
INSERT INTO ue_table
VALUES (ue_type('Linux', 'TP', 2));
INSERT INTO ue_table
VALUES (ue_type('Programmation', 'TP', 3));
INSERT INTO ue_table
VALUES (ue_type('Programmation', 'TP', 4));
INSERT INTO ue_table
VALUES (ue_type('Linux', 'TP', 3));
INSERT INTO ue_table
VALUES (ue_type('Linux', 'TP', 4));
INSERT INTO ue_table
VALUES (ue_type('Algebre', 'TD', 1));
INSERT INTO ue_table
VALUES (ue_type('Algebre', 'TD', 2));
INSERT INTO ue_table
VALUES (ue_type('Anglais', 'TD', 1));
INSERT INTO ue_table
VALUES (ue_type('Astrophysique', 'CM', 0));
INSERT INTO ue_table
VALUES (ue_type('NSI', 'TP', 1));
INSERT INTO ue_table
VALUES (ue_type('NSI', 'TP', 2));
INSERT INTO ue_table
VALUES (ue_type('Concepts informatiques', 'TP', 1));
INSERT INTO ue_table
VALUES (ue_type('Concepts informatiques', 'CM', 0));
INSERT INTO ue_table
VALUES (ue_type('Concepts informatiques', 'CM', 1));
INSERT INTO ue_table
VALUES (ue_type('Concepts informatiques', 'CM', 2));
INSERT INTO ue_table
VALUES (ue_type('Concepts informatiques', 'TP', 2));
INSERT INTO ue_table
VALUES (ue_type('Analyse', 'TD', 1));
INSERT INTO ue_table
VALUES (ue_type('Remediation', 'TD', 1));

-- Insert dans la table etudiant
INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Pierre',
        Prenoms_Type('Martin', 'Jacques'),
        '20240001',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Programmation' AND u.type_ue = 'TP' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Linux' AND u.type_ue = 'TP' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'CM' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Anglais' AND u.type_ue = 'TD' AND u.numero_groupe = 3)

        )
        ));
INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Lucie',
        Prenoms_Type('Durand', 'Michel'),
        '20240002',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Programmation' AND u.type_ue = 'TP' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Linux' AND u.type_ue = 'TP' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'CM' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Anglais' AND u.type_ue = 'TD' AND u.numero_groupe = 3)

        )
        ));
INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Jean',
        Prenoms_Type('Lefevre', 'Anne'),
        '20240003',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Programmation' AND u.type_ue = 'TP' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Linux' AND u.type_ue = 'TP' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'CM' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Anglais' AND u.type_ue = 'TD' AND u.numero_groupe = 3)

        )
        ));
INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Marie',
        Prenoms_Type('Simon', 'Mike'),
        '20240004',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Programmation' AND u.type_ue = 'TP' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Linux' AND u.type_ue = 'TP' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'CM' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Anglais' AND u.type_ue = 'TD' AND u.numero_groupe = 3)
        )
        ));
INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Paul',
        Prenoms_Type('Bernard', 'Claude'),
        '20240005',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Programmation' AND u.type_ue = 'TP' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Linux' AND u.type_ue = 'TP' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'CM' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Anglais' AND u.type_ue = 'TD' AND u.numero_groupe = 3)
        )
        ));

INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Sophie',
        Prenoms_Type('Roux', 'Louise'),
        '20240006',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Concepts informatiques' AND u.type_ue = 'TP' AND u.numero_groupe = 4),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Linux' AND u.type_ue = 'TP' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'CM' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Anglais' AND u.type_ue = 'TD' AND u.numero_groupe = 3)
        )
        ));
INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Vincent',
        Prenoms_Type('Petit', 'Louis'),
        '20240007',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Programmation' AND u.type_ue = 'TP' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Linux' AND u.type_ue = 'TP' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'CM' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Anglais' AND u.type_ue = 'TD' AND u.numero_groupe = 3)
        )
        ));
INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Julie',
        Prenoms_Type('Moreau', 'Karine'),
        '20240008',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Programmation' AND u.type_ue = 'TP' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Analyse' AND u.type_ue = 'CM' AND u.numero_groupe = 3),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'CM' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Anglais' AND u.type_ue = 'TD' AND u.numero_groupe = 3)
        )
        ));
INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Thomas',
        Prenoms_Type('Laurent', 'Jhon'),
        '20240009',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Programmation' AND u.type_ue = 'TP' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Linux' AND u.type_ue = 'TP' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'CM' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Concepts informatiques' AND u.type_ue = 'TD' AND u.numero_groupe = 4)
        )
        ));
INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Elodie',
        Prenoms_Type('Simon', 'Lena'),
        '20240010',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'TP' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Anglais' AND u.type_ue = 'TP' AND u.numero_groupe = 3),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Programmation' AND u.type_ue = 'CM' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Linux' AND u.type_ue = 'TD' AND u.numero_groupe = 2)
        )
        ));
INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Dubois',
        Prenoms_Type('Laura'),
        '20230008',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Concepts informatiques' AND u.type_ue = 'TP' AND u.numero_groupe = 4),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'CM' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Anglais' AND u.type_ue = 'TD' AND u.numero_groupe = 3),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Programmation' AND u.type_ue = 'TP' AND u.numero_groupe = 2)

        )
        ));
INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Roubert',
        Prenoms_Type('Nathan'),
        '20230007',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'CM' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Anglais' AND u.type_ue = 'TD' AND u.numero_groupe = 3),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Linux' AND u.type_ue = 'TP' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Programmation' AND u.type_ue = 'TP' AND u.numero_groupe = 2)

        )
        ));
INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Duchamps',
        Prenoms_Type('Anais'),
        '20230006',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Analyse' AND u.type_ue = 'CM' AND u.numero_groupe = 3),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'CM' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Anglais' AND u.type_ue = 'TD' AND u.numero_groupe = 3),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'NSI' AND u.type_ue = 'TP' AND u.numero_groupe = 4)
        )
        ));
INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Sim',
        Prenoms_Type('Maxime'),
        '20230005',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Analyse' AND u.type_ue = 'CM' AND u.numero_groupe = 3),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'CM' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Anglais' AND u.type_ue = 'TD' AND u.numero_groupe = 3),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Programmation' AND u.type_ue = 'TP' AND u.numero_groupe = 2)
        )
        ));

INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Duche',
        Prenoms_Type('Emma'),
        '20230004',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Concepts informatiques' AND u.type_ue = 'TP' AND u.numero_groupe = 4),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'CM' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Anglais' AND u.type_ue = 'TD' AND u.numero_groupe = 3),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Linux' AND u.type_ue = 'TP' AND u.numero_groupe = 1)
        )
        ));

INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Morteau',
        Prenoms_Type('Alice'),
        '20230003',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Concepts informatiques' AND u.type_ue = 'TP' AND u.numero_groupe = 4),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'CM' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Anglais' AND u.type_ue = 'TD' AND u.numero_groupe = 3),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Programmation' AND u.type_ue = 'TP' AND u.numero_groupe = 2)
        )
        ));
INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Foulque',
        Prenoms_Type('Lucas'),
        '20230002',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'NSI' AND u.type_ue = 'TP' AND u.numero_groupe = 4),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'CM' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Anglais' AND u.type_ue = 'TD' AND u.numero_groupe = 3),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Programmation' AND u.type_ue = 'TP' AND u.numero_groupe = 2)
        )
        ));
INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Duralex',
        Prenoms_Type('Chloe'),
        '20230001',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Concepts informatiques' AND u.type_ue = 'TP' AND u.numero_groupe = 4),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Analyse' AND u.type_ue = 'CM' AND u.numero_groupe = 3),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Linux' AND u.type_ue = 'TP' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Programmation' AND u.type_ue = 'TP' AND u.numero_groupe = 2)
        )
        ));
INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Benar',
        Prenoms_Type('Hugo'),
        '20240012',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'CM' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Anglais' AND u.type_ue = 'TD' AND u.numero_groupe = 3),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'NSI' AND u.type_ue = 'TP' AND u.numero_groupe = 4),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Programmation' AND u.type_ue = 'TP' AND u.numero_groupe = 2)
        )
        ));
INSERT INTO etudiant_table
VALUES (Etudiant_Type(
        'Lefevre',
        Prenoms_Type('Laura'),
        '20240011',
        'parcoursup',
        list_ue(
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Algebre' AND u.type_ue = 'CM' AND u.numero_groupe = 1),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Anglais' AND u.type_ue = 'TD' AND u.numero_groupe = 3),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Linux' AND u.type_ue = 'TP' AND u.numero_groupe = 2),
                (SELECT REF(u) FROM ue_table u WHERE u.nom = 'Programmation' AND u.type_ue = 'TP' AND u.numero_groupe = 2)
        )
        ));

-- Insert dans la table enseignant
INSERT INTO enseignant_table
VALUES (Enseignant_Type(
        'Laurent',
        Prenoms_Type('Amanton'),
        '12345'
        ));

INSERT INTO enseignant_table
VALUES (Enseignant_Type(
        'Balev',
        Prenoms_Type('Stefan'),
        '00000'
        ));
INSERT INTO enseignant_table
VALUES (Enseignant_Type(
        'Lemaire ',
        Prenoms_Type(' Anne Sophie'),
        '180602'
        ));
INSERT INTO enseignant_table
VALUES (Enseignant_Type(
        ' Nicholas',
        Prenoms_Type('Josephs'),
        '210203'
        ));
INSERT INTO enseignant_table
VALUES (Enseignant_Type(
        'Duhamel',
        Prenoms_Type('Christophe'),
        '190325'
        ));

INSERT INTO enseignant_table
VALUES (Enseignant_Type(
        'Corson',
        Prenoms_Type(' Nathalie'),
        '210388'
        ));
INSERT INTO enseignant_table
VALUES (Enseignant_Type(
        'ponty',
        Prenoms_Type('Jean Luc'),
        '108090'
        ));
INSERT INTO enseignant_table
VALUES (Enseignant_Type(
        'mordi',
        Prenoms_Type('Omar'),
        '180909'
        ));
INSERT INTO enseignant_table
VALUES (Enseignant_Type(
        'lilo',
        Prenoms_Type('Alex'),
        '210809'
        ));

-- Insertion dans la table emploi du temps
INSERT INTO edt_table
VALUES ('Lundi', '8h-10h', 'A106',
        (select ref(u) from ue_table u where u.nom = 'Programmation' and u.type_ue = 'TP' and u.numero_groupe = 1),
        (Select ref(u) from enseignant_table u where u.matricule = '190325'));
INSERT into edt_table
values ('Mercredi', '10h-12h', 'A203',
        (select ref(u) from ue_table u where u.nom = 'Programmation' and u.type_ue = 'TP' and u.numero_groupe = 1),
        (Select ref(u) from enseignant_table u where u.matricule = '190325'));
INSERT into edt_table
values ('Lundi', '14h-16h', 'A103',
        (select ref(u) from ue_table u where u.nom = 'Linux' and u.type_ue = 'TP' and u.numero_groupe = 1),
        (Select ref(u) from enseignant_table u where u.matricule = '12345'));
INSERT into edt_table
values ('Vendredi', '10h-12h', 'A104',
        (select ref(u) from ue_table u where u.nom = 'Linux' and u.type_ue = 'TP' and u.numero_groupe = 1),
        (Select ref(u) from enseignant_table u where u.matricule = '12345'));
INSERT into edt_table
values ('Mardi', '8h-10h', 'A110',
        (select ref(u) from ue_table u where u.nom = 'Programmation' and u.type_ue = 'TP' and u.numero_groupe = 2),
        (Select ref(u) from enseignant_table u where u.matricule = '190325'));
INSERT into edt_table
values ('Jeudi', '10h-12h', 'B203',
        (select ref(u) from ue_table u where u.nom = 'Programmation' and u.type_ue = 'TP' and u.numero_groupe = 2),
        (Select ref(u) from enseignant_table u where u.matricule = '190325'));
INSERT into edt_table
values ('Mercredi', '10h-12h', 'C103',
        (select ref(u) from ue_table u where u.nom = 'Linux' and u.type_ue = 'TP' and u.numero_groupe = 2),
        (Select ref(u) from enseignant_table u where u.matricule = '12345'));
INSERT into edt_table
values ('Jeudi', '10h-12h', 'C104',
        (select ref(u) from ue_table u where u.nom = 'Linux' and u.type_ue = 'TP' and u.numero_groupe = 2),
        (Select ref(u) from enseignant_table u where u.matricule = '12345'));
INSERT into edt_table
values ('Lundi', '14h-16h', 'B104',
        (select ref(u) from ue_table u where u.nom = 'Programmation' and u.type_ue = 'TP' and u.numero_groupe = 3),
        (Select ref(u) from enseignant_table u where u.matricule = '190325'));
INSERT into edt_table
values ('Mercredi', '14h-16h', 'C104',
        (select ref(u) from ue_table u where u.nom = 'Programmation' and u.type_ue = 'TP' and u.numero_groupe = 3),
        (Select ref(u) from enseignant_table u where u.matricule = '190325'));
INSERT into edt_table
values ('Mardi', '16h-18h', 'B104',
        (select ref(u) from ue_table u where u.nom = 'Linux' and u.type_ue = 'TP' and u.numero_groupe = 3),
        (Select ref(u) from enseignant_table u where u.matricule = '12345'));
INSERT into edt_table
values ('Jeudi', '10h-12h', 'A110',
        (select ref(u) from ue_table u where u.nom = 'Linux' and u.type_ue = 'TP' and u.numero_groupe = 3),
        (Select ref(u) from enseignant_table u where u.matricule = '12345'));
INSERT into edt_table
values ('Mardi', '16h-18h', 'B110',
        (select ref(u) from ue_table u where u.nom = 'Programmatioon' and u.type_ue = 'TP' and u.numero_groupe = 4),
        (Select ref(u) from enseignant_table u where u.matricule = '190325'));
INSERT into edt_table
values ('Jeudi', '10h-12h', 'A102',
        (select ref(u) from ue_table u where u.nom = 'Programmation' and u.type_ue = 'TP' and u.numero_groupe = 4),
        (Select ref(u) from enseignant_table u where u.matricule = '190325'));
INSERT into edt_table
values ('Mardi', '8h-10h', 'A103',
        (select ref(u) from ue_table u where u.nom = 'Linux' and u.type_ue = 'TP' and u.numero_groupe = 4),
        (Select ref(u) from enseignant_table u where u.matricule = '12345'));
INSERT into edt_table
values ('Mercredi', '8h-10h', 'A102',
        (select ref(u) from ue_table u where u.nom = 'Linux' and u.type_ue = 'TP' and u.numero_groupe = 4),
        (Select ref(u) from enseignant_table u where u.matricule = '12345'));
INSERT into edt_table
values ('Lundi', '8h-10h', 'C102',
        (select ref(u) from ue_table u where u.nom = 'Algebre' and u.type_ue = 'TD' and u.numero_groupe = 1),
        (Select ref(u) from enseignant_table u where u.matricule = '180602'));
INSERT into edt_table
values ('Mercredi', '14h-16h', 'A108',
        (select ref(u) from ue_table u where u.nom = 'Algebre' and u.type_ue = 'TD' and u.numero_groupe = 1),
        (Select ref(u) from enseignant_table u where u.matricule = '180602'));
INSERT into edt_table
values ('Lundi', '10h-12h', 'B110',
        (select ref(u) from ue_table u where u.nom = 'Algebre' and u.type_ue = 'TD' and u.numero_groupe = 2),
        (Select ref(u) from enseignant_table u where u.matricule = '180602'));
INSERT into edt_table
values ('Mercredi', '10h-12h', 'A103',
        (select ref(u) from ue_table u where u.nom = 'Algebre' and u.type_ue = 'TD' and u.numero_groupe = 2),
        (Select ref(u) from enseignant_table u where u.matricule = '180602'));
INSERT into edt_table
values ('Mercredi', '8h-10h', 'A103',
        (select ref(u) from ue_table u where u.nom = 'Anglais' and u.type_ue = 'TD' and u.numero_groupe = 1),
        (Select ref(u) from enseignant_table u where u.matricule = '210203'));
INSERT into edt_table
values ('Mardi', '14h-16h', 'A105',
        (select ref(u) from ue_table u where u.nom = 'Anglais' and u.type_ue = 'TD' and u.numero_groupe = 2),
        (Select ref(u) from enseignant_table u where u.matricule = '210203'));
INSERT into edt_table
values ('Lundi', '14h-16h', 'C105',
        (select ref(u) from ue_table u where u.nom = 'Astrophysique' and u.type_ue = 'CM' and u.numero_groupe = 0),
        (Select ref(u) from enseignant_table u where u.matricule = '108090'));
INSERT into edt_table
values ('Mardi', '8h-10h', 'C105',
        (select ref(u) from ue_table u where u.nom = 'Astrophysique' and u.type_ue = 'CM' and u.numero_groupe = 0),
        (Select ref(u) from enseignant_table u where u.matricule = '108090'));
INSERT into edt_table
values ('Lundi', '16h-18h', 'C206',
        (select ref(u) from ue_table u where u.nom = 'NSI' and u.type_ue = 'TP' and u.numero_groupe = 1),
        (Select ref(u) from enseignant_table u where u.matricule = '180909'));
INSERT into edt_table
values ('Jeudi', '8h-10h', 'A106',
        (select ref(u) from ue_table u where u.nom = 'NSI' and u.type_ue = 'TP' and u.numero_groupe = 1),
        (Select ref(u) from enseignant_table u where u.matricule = '180909'));
INSERT into edt_table
values ('Lundi', '14h-16h', 'C206',
        (select ref(u) from ue_table u where u.nom = 'NSI' and u.type_ue = 'TP' and u.numero_groupe = 2),
        (Select ref(u) from enseignant_table u where u.matricule = '180909'));
INSERT into edt_table
values ('Vendredi', '10h-12h', 'B106',
        (select ref(u) from ue_table u where u.nom = 'NSI' and u.type_ue = 'TP' and u.numero_groupe = 2),
        (Select ref(u) from enseignant_table u where u.matricule = '180909'));
INSERT into edt_table
values ('Mercredi', '16h-18h', 'C006',
        (select ref(u) from ue_table u where u.nom = 'Concepts informatiques' and u.type_ue = 'CM' and u.numero_groupe = 0),
        (Select ref(u) from enseignant_table u where u.matricule = '00000'));
INSERT into edt_table
values ('Mardi', '8h-10h', 'C106',
        (select ref(u) from ue_table u where u.nom = 'Concepts informatiques' and u.type_ue = 'TP' and u.numero_groupe = 1),
        (Select ref(u) from enseignant_table u where u.matricule = '00000'));
INSERT into edt_table
values ('Vendredi', '8h-10h', 'C006',
        (select ref(u) from ue_table u where u.nom = 'Concepts informatiques' and u.type_ue = 'CM' and u.numero_groupe = 1),
        (Select ref(u) from enseignant_table u where u.matricule = '00000'));
INSERT into edt_table
values ('Lundi', '16h-18h', 'C106',
        (select ref(u) from ue_table u where u.nom = 'Concepts informatiques' and u.type_ue = 'TP' and u.numero_groupe = 2),
        (Select ref(u) from enseignant_table u where u.matricule = '00000'));
INSERT into edt_table
values ('Vendredi', '8h-10h', 'B106',
        (select ref(u) from ue_table u where u.nom = 'Concepts informatiques' and u.type_ue = 'CM' and u.numero_groupe = 2),
        (Select ref(u) from enseignant_table u where u.matricule = '00000'));
INSERT into edt_table
values ('Vendredi', '10h-12h', 'C106',
        (select ref(u) from ue_table u where u.nom = 'Analyse' and u.type_ue = 'TD' and u.numero_groupe = 1),
        (Select ref(u) from enseignant_table u where u.matricule = '210388'));
INSERT into edt_table
values ('Mercredi', '14h-16h', 'A106',
        (select ref(u) from ue_table u where u.nom = 'Analyse' and u.type_ue = 'TD' and u.numero_groupe = 1),
        (Select ref(u) from enseignant_table u where u.matricule = '210388'));
INSERT into edt_table
values ('Lundi', '16h-18h', 'A110',
        (select ref(u) from ue_table u where u.nom = 'Remediation' and u.type_ue = 'TD' and u.numero_groupe = 1),
        (Select ref(u) from enseignant_table u where u.matricule = '210809'));
INSERT into edt_table
values ('Mardi', '16h-18h', 'B216',
        (select ref(u) from ue_table u where u.nom = 'Remediation' and u.type_ue = 'TD' and u.numero_groupe = 1),
        (Select ref(u) from enseignant_table u where u.matricule = '210809'));
INSERT into edt_table
values ('Vendredi', '14h-16h', 'C116',
        (select ref(u) from ue_table u where u.nom = 'Remediation' and u.type_ue = 'TD' and u.numero_groupe = 1),
        (Select ref(u) from enseignant_table u where u.matricule = '210809'));


-- requete permettant d'avoir la liste des ue d'un étudiant
SELECT e.nom           AS Nom_Etudiant,
       e.prenoms       AS Prenom_Etudiant,
       e.provenance    AS Provenance_Etudiant,
       u.nom           AS Nom_UE,
       u.type_ue       AS Type_UE,
       u.numero_groupe AS Numero_Groupe
FROM etudiant_table e,
     TABLE (e.ue) eu,
     ue_table u
WHERE eu.COLUMN_VALUE = REF(u)
  AND e.nom = 'Pierre';


-- requete permettant d'avoir l'emploi du temps d'un etudiant pour un jour donné
SELECT e.nom             AS Nom_Etudiant,
       e.prenoms         AS Prenom_Etudiant,
       e.provenance      AS Provenance_Etudiant,
       ed.jour           AS Jour,
       ed.heure          AS Heure,
       ed.salle          AS Salle,
       ed.enseignant.nom AS enseignant,
       u.nom             AS Nom_UE,
       u.type_ue         AS Type_UE,
       u.numero_groupe   AS Numero_Groupe
FROM etudiant_table e,
     TABLE (e.ue) eu,
     ue_table u,
     edt_table ed
WHERE eu.COLUMN_VALUE = REF(u)
  AND REF(u) = ed.ue
  AND e.nom = 'Pierre' AND ed.jour = 'Mardi';

-- L'EMPLOI DU TEMPS DE LA CLASSE D'UN JOUR DONNEE
SELECT ed.jour           AS Jour,
       ed.heure          AS Heure,
       ed.salle          AS Salle,
       ed.enseignant.nom AS enseignant,
       u.nom             AS Nom_UE,
       u.type_ue         AS Type_UE,
       u.numero_groupe   AS Numero_Groupe
FROM edt_table ed,
     ue_table u
WHERE ed.ue = REF(u)
  AND ed.jour = 'Lundi';


--LA LISTE DES ETUDIANTS INSCRITS DANS UNE UE POUR UN GROUPE DONNÉE
SELECT e.nom           AS Nom_Etudiant,
       e.prenoms       AS Prenom_Etudiant,
       e.provenance    AS Provenance_Etudiant,
       u.nom           AS Nom_UE,
       u.type_ue       AS Type_UE,
       u.numero_groupe AS Numero_Groupe
FROM etudiant_table e,
     TABLE (e.ue) eu,
     ue_table u
WHERE eu.COLUMN_VALUE = REF(u)
  AND u.nom = 'Linux' AND u.type_ue = 'TP' AND u.numero_groupe = 1;
