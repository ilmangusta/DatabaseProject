# DatabaseProject
Repository for database project ISBD for programming database course.

Project for database programming exam. In this project, three groups were created (each one with 2 students) to work in different areas. Each one worked on the specific development of an idea:
1. Orange group: design the relational logic schema, creating all the initial setup for tables, triggers, views
2. Blue group: design the system setup, permissions, and privileges.
3. Green group: design the skeleton of the web page, constant in CSS and the style of the web page in PLSQL language.

Read all details about the design style, implementations, schemas, and more on the specific page Documentation of the project. (https://github.com/ilmangusta/DatabaseProject/tree/main/Documentation)
Later each group designed its own functions and operations to use in the web page and to navigate among the different pages.

Instruction to install all setup for database with order how to execute files:
1) tables.sql
2) sequence.sql
3) triggers.sql
4) insert.sql
5) Cambiare in costanti alla fine del file, la radice con il nome dell'utente del db
6) costanti.sql
7) gui_s.sql
8) Cambiare in authenticate_s.sql DB_UTENTE al nome dell'utente 
9) Authenticate_s.sql
10) gui_b.sql
11) Authenticate_b.sql
12) Authorize_s.sql
13) Authorize_b.sql
14) views.sql
15) all *_s.sql files (specifications)
16) all *_b.sql files (body)
17) GRANT EXECUTE ON GUI TO ANONYMOUS;
18) GRANT EXECUTE ON AUTHENTICATE TO ANONYMOUS;
19) GRANT EXECUTE ON AUTHORIZE TO ANONYMOUS;
20) GRANT EXECUTE ON ROSSO TO ANONYMOUS;
21) GRANT EXECUTE ON GVERDE TO ANONYMOUS;
22) GRANT EXECUTE ON BLU TO ANONYMOUS;

main page of site: http://oracle01.polo2.ad.unipi.it:8080/apex/{NOMEUTENTEDATABASE}.gui.aprihomepage -> NOMEUTENTEDATABASE=borrello per testing

23) Rules and credentials to use and navigate properly on the site:

UTENTE sys PASSWORD Lbd2023. // (includere il punto nella password)

UTENTE UTENTE2223 PASSWORD utente2223

UTENTE UTENTETEST2223 PASSWORD utentetest2223

UTENTE ROSONE PASSWORD Rosone23

24) Different roles and permissions:

----RUOLO ADMIN-------

USERNAME : ADMIN

PASSWORD : ADMIN

----RUOLO TOUR--------

USERNAME : laura_lete

PASSWORD : laura_lete

----RUOLO CROCIERE----

USERNAME : giulia_verdi

PASSWORD : giulia_verdi

----RUOLO STATISTA----

USERNAME : eugenio_impastato

PASSWORD : eugenio_impastato


