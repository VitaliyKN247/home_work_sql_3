CREATE DATABASE IF NOT EXISTS home_work_3;

USE home_work_3;

DROP TABLE IF EXISTS staff;
CREATE TABLE staff
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(45) NOT NULL,
    lastname VARCHAR(45) NOT NULL,
    post VARCHAR(45) NOT NULL,
    seniority INT, 
    salary DECIMAL(8,2), -- 100 000 . 00
    age INT
);

INSERT staff(firstname, lastname, post, seniority,salary,age)
VALUES ("Петр", "Петров", "Начальник", 8, 70000, 30); -- id = 1
INSERT staff (firstname, lastname, post, seniority, salary, age)
VALUES
  ('Вася', 'Петров', 'Начальник', 40, 100000, 60),
  ('Петр', 'Власов', 'Начальник', 8, 70000, 30),
  ('Катя', 'Катина', 'Инженер', 2, 70000, 25),
  ('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
  ('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
  ('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
  ('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
  ('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
  ('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
  ('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
  ('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
  ('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);
  

-- Отсортируйте данные по полю заработная плата (salary) в порядке:возрастания
SELECT
	post,
	salary
FROM staff
ORDER BY salary;

-- по убыванию
SELECT
	post,
	salary
FROM staff
ORDER BY salary DESC;

-- Выведите 5 максимальных заработных плат (saraly)
SELECT
	firstname,
    post,
    salary
FROM staff
ORDER BY salary DESC
LIMIT 5;

-- Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
SELECT
	post,
    SUM(salary) AS total_sum
FROM staff
GROUP BY post;

-- Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
SELECT 
	firstname,
    lastname,
    post,
    age
FROM staff
WHERE age >= 24 AND age <= 49;

-- Найдите количество специальностей
SELECT
	COUNT(DISTINCT post) AS number_post
FROM staff;

-- Выведите специальности, у которых средний возраст сотрудников меньше 30 лет
SELECT
    post 
FROM staff
WHERE age < 30
GROUP BY post;


-- Внутри каждой должности вывести ТОП-2 по ЗП (2 самых высокооплачиваемых сотрудника по ЗП внутри каждой должности)
SELECT 
	post,
	MAX(salary) AS max
FROM staff
GROUP BY post;

SELECT post,
MAX(salary)  AS max_salary,
	(SELECT MAX(salary) FROM staff 
    WHERE salary 
    < (SELECT MAX(salary) FROM staff )) AS second_max_salary
	-- ORDER BY salary DESC LIMIT 2) AS second_max_salary
FROM staff 
GROUP BY post;

SELECT post, salary
  FROM staff
 WHERE salary < (SELECT MAX( salary ) 	
                 FROM staff) 
GROUP BY post;

SELECT 
	post,
    MAX(salary)
FROM staff s1
WHERE salary > (SELECT MAX(s2.salary)
	FROM staff s2
    WHERE s1.salary > s2.salary);

SELECT 	
	post,
	MAX(salary)  AS max_salary,
	(SELECT MAX(salary) FROM staff 
    WHERE salary 
    < ALL(SELECT MAX(salary) FROM staff )) AS second_max_salary
	-- ORDER BY salary DESC LIMIT 2) AS second_max_salary
FROM staff 
GROUP BY post;




/*SELECT
	post,
    salary
 FROM staff
 WHERE post LIKE "Н%"
 -- ORDER BY salary DESC
UNION 
SELECT
	post,
    salary
 FROM staff
 WHERE post LIKE "У%"
UNION 
SELECT
	post,
    salary
 FROM staff
 WHERE post LIKE "Р%"
 ORDER BY salary DESC*/







