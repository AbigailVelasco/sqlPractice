
-- List the schools in alphabetical order along with 
-- teachers ordered by the first name A-Z

SELECT school, first_name 
FROM teachers
ORDER BY school ASC, first_name ASC;

-- Find the one teacher whose first name starts with the
-- letter S and who earns more than $40000

SELECT * 
FROM teachers
WHERE salary >40000
	AND first_name LIKE 'S%';
    
-- Teachers hired since January 1,2010 
-- ordered by highest pay to lowest

SELECT * 
FROM teachers
WHERE hire_date >= '2010-01-01'
ORDER BY salary DESC;
