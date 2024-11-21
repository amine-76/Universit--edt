# 📚 Projet Universitaire : Modélisation et Gestion de l'Emploi du Temps des L1 en Base de Données Orientée Objet

## 🎯 Objectif du Projet
Ce projet avait pour objectif de concevoir et développer une base de données orientée objet pour gérer l'emploi du temps des étudiants de Licence 1 dans ma faculté. J'ai utilisé les fonctionnalités avancées d'Oracle, comme les **types d'objets** et l'héritage, pour représenter les entités et leurs relations.

## 🛠️ Technologies et Outils
- **SGBD utilisé :** Oracle Database
- **Langage SQL :** SQL étendu avec types d'objets.
- **Modélisation :** UML (diagrammes de classes).
- **Méthodologie :** Conception orientée objet et traduction en base de données.

## 🔑 Fonctionnalités principales
- **Gestion des entités :**
  - **Étudiants** (héritant d'un type `personne` générique).
  - **Enseignants** (héritant également du type `personne`).
  - **Unités d'enseignement (UE)** avec une représentation détaillée (nom, type, groupe).
  - **Emploi du temps (EDT)** avec des relations directes aux enseignants et UE.
- **Relations modélisées :**
  - Héritage entre les types (`personne_type` > `etudiant_type` et `enseignant_type`).
  - Utilisation de **types de collections** pour gérer des listes (ex. : `prenoms_type` et `list_ue`).
  - Références (`REF`) pour établir des liens entre les objets (ex. : un emploi du temps référence une UE et un enseignant).

## 📐 Modélisation Orientée Objet
- **Types d'objets :**
  - Utilisation de types `AS OBJECT` pour modéliser chaque entité (par ex. : `etudiant_type`, `ue_type`).
  - Mise en place de l’héritage avec le mot-clé `UNDER` (ex. : `etudiant_type` hérite de `personne_type`).
- **Collections :**
  - Utilisation de `NESTED TABLE` pour stocker des collections d'objets, comme les prénoms (`prenoms_type`) ou les UE suivies par un étudiant (`list_ue`).
- **Références :**
  - Utilisation de `REF` pour établir des relations directes entre les tables (ex. : `ue` et `enseignant` dans `edt_type`).

## 💡 Challenges et Solutions
- **Challenge :** Implémenter un modèle orienté objet en base relationnelle.  
  **Solution :** Utilisation des fonctionnalités natives d'Oracle pour gérer les types d'objets, les collections et l'héritage.

- **Challenge :** Gérer la cohérence des relations entre les entités.  
  **Solution :** Utilisation de `REF` pour garantir une association directe et correcte entre les objets.

## 🚀 Résultats
- Base de données orientée objet capable de gérer les emplois du temps de manière modulaire et flexible.
- Conception claire et extensible grâce à l'utilisation de l’héritage et des collections.
- Représentation fidèle du modèle orienté objet avec des relations complexes entre les entités.

## 🌟 Compétences Acquises
- Utilisation des **types d'objets** et de l’héritage en Oracle.
- Modélisation orientée objet et traduction dans un SGBD.
- Gestion des collections (`NESTED TABLE`) et références (`REF`) pour des relations complexes.
- Analyse des besoins métier et conception d’une solution optimisée.

---

### 🔗 Contact
Je suis disponible pour discuter davantage de ce projet et des compétences que j’ai développées ! N’hésitez pas à me contacter.
