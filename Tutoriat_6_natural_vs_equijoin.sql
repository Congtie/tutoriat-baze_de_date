-- pastreaza coloana duplicat (equi-join/inner-join)
SELECT * 
FROM employees e, departments d
WHERE e.department_id = d.department_id;


-- pastreaza coloana duplicat (equi-join/inner-join)
SELECT *
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

--SELECT * FROM departments;


-- nu e ok (face natual join dupa TOATE coloanele comune, adica si department_id, si manager_id!!!)
-- practic, intoarce acei angajati care au drept manager direct managerul departamentului in care lucreaza!!
-- evident, obtin mai putine rezultate (32 vs. 106)
SELECT * 
FROM employees e
NATURAL JOIN departments d;


-- mai ok (imi adauga la cele 32 de linii restul liniilor din employees care nu se gaseau in rezultat)
-- dar tot gresit, pentru ca toate coloanele din departments sunt null!!!!!
SELECT * 
FROM employees e
NATURAL LEFT JOIN departments d;

describe employees;
describe departments;
-- pentru natural join, folositi aceasta sintaxa:
SELECT *
FROM employees e
JOIN departments d USING (department_id);









