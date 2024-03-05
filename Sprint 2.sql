#Nivel 1
#ejercicio 1
#sin subquery
SELECT *
FROM transaction
JOIN
company
ON company.id=transaction.company_id
WHERE country = "Germany";

# con subquery
SELECT *
FROM transaction
WHERE company_id IN (
	SELECT id
    FROM company
    WHERE country = "Germany");
    
# ejercicio 2
SELECT company_name
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
SELECT *
FROM company
WHERE id IN (
	SELECT DISTINCT company_id
    FROM transaction
    WHERE amount = 'null'
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
SELECT company_name
FROM company
WHERE id IN (
	SELECT company_id
	FROM transaction
	WHERE amount = (
		SELECT MAX(amount)
		FROM transaction
	)
)
;

#Nivel 3
#Ejercicio 1
SELECT country 
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

#Ejercicio 2
SELECT company_name, COUNT(transaction.id),
CASE
	WHEN COUNT(transaction.id) > 4 THEN "Té més de 4 transaccions"
   ELSE 'Té menys de 4 transaccions'
END AS QuantitatTransaccions
FROM transaction
JOIN company
ON company.id=transaction.company_id
GROUP BY company_id;