CREATE TABLE PARTICIPA(
    nume_student VARCHAR2(20),
    nume_curs    VARCHAR2(50)
);

CREATE TABLE CURS_OBLIGATORIU(
    nume_curs   VARCHAR2(50)
);

INSERT INTO PARTICIPA VALUES('Mihnea', 'Baze de Date');
INSERT INTO PARTICIPA VALUES('Mihnea', 'Programarea Algoritmilor');
INSERT INTO PARTICIPA VALUES('Simona', 'Arhitectura Calculatoarelor');
INSERT INTO PARTICIPA VALUES('Simona', 'Baze de Date');
INSERT INTO PARTICIPA VALUES('Simona', 'Machine Learning');
INSERT INTO PARTICIPA VALUES('Marius', 'Programarea Algoritmilor');
INSERT INTO PARTICIPA VALUES('Marius', 'Statistica');

INSERT INTO CURS_OBLIGATORIU VALUES('Baze de Date');
INSERT INTO CURS_OBLIGATORIU VALUES('Programarea Algoritmilor');



-- varianta 1, NOT EXISTS
-- NOT EXISTS intoarce TRUE daca nu gaseste nicio linie care sa satisfaca conditiile
-- selectez studentii pentru care nu exista vreun curs obligatoriu la care sa nu fi participat
-- afisez acei stundeti pentru care lista cursurilor oblgiatorii
-- la care nu participa (adica rezultatul primei subcereri) este vida
-- in prima subcerere (linia 31), folosesc NOT EXISTS pentru a selecta acele cursuri la care NU participa
SELECT DISTINCT p.nume_student
FROM participa p
WHERE NOT EXISTS
    (SELECT 1 FROM curs_obligatoriu co
     WHERE NOT EXISTS
         (SELECT 1 FROM participa pp
          WHERE pp.nume_student = p.nume_student AND co.nume_curs = pp.nume_curs));



-- varianta 2, COUNT:
-- aleg toti studentii care participa la cursuri obligatorii,
-- ii grupez dupa nume si returnez doar numele acelor studenti pentru care
-- grupul obtinut (adica nume_student + toate cursurile obligatorii la care participa)
-- are un numar de linii egal cu numarul de cursuri obligatorii
SELECT p.nume_student
FROM participa p
JOIN curs_obligatoriu co ON p.nume_curs = co.nume_curs
GROUP BY p.nume_student
HAVING COUNT(DISTINCT p.nume_curs) = (SELECT COUNT(*) FROM curs_obligatoriu);



-- varianta 3, MINUS
-- aleg multimea tuturor studentii care participa la cursuri,
-- din care mai apoi elimin (DIFFERECE/MINUS)
-- acei studenti pentru care exista cel putin un curs obligatoriu la care nu participa
SELECT DISTINCT nume_student
FROM participa
MINUS
SELECT DISTINCT p.nume_student
FROM participa p
WHERE EXISTS (
    SELECT 1 FROM (
        SELECT nume_curs FROM curs_obligatoriu
        MINUS
        SELECT nume_curs FROM participa pp WHERE pp.nume_student = p.nume_student
    )
);







