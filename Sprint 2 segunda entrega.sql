#Nivel 1
#ejercicio 1
#sin subquery
SELECT *
FROM transaction
JOIN
company
ON company.id=transaction.company_id
WHERE country = 'Germany';

# con subquery
SELECT *
FROM transaction
WHERE company_id IN (
	SELECT id
    FROM company
    WHERE country = 'Germany');
    
# ejercicio 2
SELECT *
FROM company
WHERE id IN (
	SELECT company_id
	FROM transaction
	WHERE amount> (
		SELECT AVG(amount)
		FROM transaction
	)
);

# ejercicio 3
SELECT *
FROM transaction
WHERE company_id IN (
	SELECT id
	FROM company
	WHERE company_name LIKE 'C%'
);

#ejercicio 4
# con la expresion NOT EXISTS
SELECT *
FROM company
WHERE NOT EXISTS (
	SELECT company_id
    FROM transaction
    WHERE amount > 0
    )
;
#con la expresion NOT IN.
SELECT *
FROM company
WHERE id NOT IN (
	SELECT company_id
    FROM transaction
    WHERE amount > 0
    )
;

#Nivel 2
#Ejercicio 1
SELECT *
FROM transaction
WHERE company_id IN (
	SELECT id
	FROM company
	WHERE country = (
		SELECT country
        FROM company
        WHERE company_name = 'Non Institute'
	)
)
;

# Ejercicio 2
SELECT company_name, MAX(amount)
FROM transaction, company
WHERE company.id IN (
	SELECT company_id
	FROM transaction
	WHERE amount = (
		SELECT MAX(amount) 
		FROM transaction
	)
)
GROUP BY company_name
;

#Nivel 3
#Ejercicio 1
# Subquery sin JOIN
SELECT Pais, AVG(amount) as Mediapais  
FROM (SELECT *, (SELECT country FROM company where transaction.company_id= company.id) Pais    
		FROM transactions.transaction) nuevatabla   
GROUP BY Pais
HAVING Mediapais > (SELECT AVG(amount) from transaction);

# con JOIN
SELECT country, AVG(amount)
FROM transaction
JOIN
company
ON transaction.company_id=company.id
GROUP BY country
HAVING AVG(amount)> (
	SELECT AVG(amount) 
    FROM transaction
)
;

# otra forma de JOIN sin usar propiamente JOIN
SELECT country, AVG(amount)
FROM transaction, company
WHERE company.id =company_id
    group by country
	having AVG(amount) > (
		SELECT AVG(amount) 
		FROM transaction
	)
;

#Ejercicio 2
#con Subqueries
SELECT COUNT(id), (SELECT company_name FROM company WHERE company.id=transaction.company_id) NomCompany,
CASE
	WHEN COUNT(transaction.id) > 4 THEN "Té més de 4 transaccions"
   ELSE 'Té menys de 4 transaccions'
END AS Especificacions
FROM transaction
GROUP BY NomCompany;



#con JOIN
SELECT company_name, COUNT(transaction.id) QuantitatTransaccions,
CASE
	WHEN COUNT(transaction.id) > 4 THEN "Té més de 4 transaccions"
   ELSE 'Té menys de 4 transaccions'
END AS Especificacions
FROM transaction
JOIN company
ON company.id=transaction.company_id
GROUP BY company_id;

#otra forma de JOIN sin usarlo extrictamente
SELECT company_name, COUNT(transaction.id) QuantitatTransaccions,
CASE
	WHEN COUNT(transaction.id) > 4 THEN "Té més de 4 transaccions"
   ELSE 'Té menys de 4 transaccions'
END AS Especificacions
FROM transaction, company
where company.id= company_id
GROUP BY company_id;