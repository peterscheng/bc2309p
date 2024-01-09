DDL:
-- ----------------------------
-- Table structure for countries
-- ----------------------------
DROP TABLE IF EXISTS `countries`;
CREATE TABLE `countries` (
  `COUNTRY_ID` char(2) NOT NULL,
  `COUNTRY_NAME` varchar(40) DEFAULT NULL,
  `REGION_ID` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`COUNTRY_ID`),
  KEY `FK_REGION` (`REGION_ID`),
  CONSTRAINT `FK_REGION` FOREIGN KEY (`REGION_ID`) REFERENCES `regions` (`REGION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for departments
-- ----------------------------
DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments` (
  `DEPARTMENT_ID` int NOT NULL,
  `DEPARTMENT_NAME` varchar(30) DEFAULT NULL,
  `MANAGER_ID` int DEFAULT NULL,
  `LOCATION_ID` int DEFAULT NULL,
  PRIMARY KEY (`DEPARTMENT_ID`),
  KEY `FK_DEP` (`LOCATION_ID`),
  CONSTRAINT `FK_DEP` FOREIGN KEY (`LOCATION_ID`) REFERENCES `locations` (`LOCATION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for employees
-- ----------------------------
DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees` (
  `EMPLOYEE_ID` int NOT NULL,
  `FIRST_NAME` varchar(20) DEFAULT NULL,
  `LAST_NAME` varchar(25) DEFAULT NULL,
  `EMAIL` varchar(25) DEFAULT NULL,
  `PHONE_NUMBER` varchar(20) DEFAULT NULL,
  `HIRE_DATE` date DEFAULT NULL,
  `JOB_ID` varchar(10) DEFAULT NULL,
  `SALARY` int DEFAULT NULL,
  `COMMISSION_PCT` int DEFAULT NULL,
  `MANAGER_ID` int DEFAULT NULL,
  `DEPARTMENT_ID` int DEFAULT NULL,
  PRIMARY KEY (`EMPLOYEE_ID`),
  KEY `FK_DEPT` (`DEPARTMENT_ID`),
  KEY `FK_JOB_ID` (`JOB_ID`),
  CONSTRAINT `FK_DEPT` FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `departments` (`DEPARTMENT_ID`),
  CONSTRAINT `FK_JOB_ID` FOREIGN KEY (`JOB_ID`) REFERENCES `jobs` (`JOB_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `JOB_ID` varchar(10) NOT NULL,
  `JOB_TITLE` varchar(35) DEFAULT NULL,
  `MIN_SALARY` int DEFAULT NULL,
  `MAX_SALARY` int DEFAULT NULL,
  PRIMARY KEY (`JOB_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for job_grades
-- ----------------------------
DROP TABLE IF EXISTS `job_grades`;
CREATE TABLE `job_grades` (
  `GRADE_LEVEL` varchar(2) NOT NULL,
  `LOWEST_SAL` int DEFAULT NULL,
  `HIGHEST_SAL` int DEFAULT NULL,
  PRIMARY KEY (`GRADE_LEVEL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for job_history
-- ----------------------------
DROP TABLE IF EXISTS `job_history`;
CREATE TABLE `job_history` (
  `EMPLOYEE_ID` int NOT NULL,
  `START_DATE` date NOT NULL,
  `END_DATE` date DEFAULT NULL,
  `JOB_ID` varchar(10) DEFAULT NULL,
  `DEPARTMENT_ID` int DEFAULT NULL,
  PRIMARY KEY (`EMPLOYEE_ID`,`START_DATE`),
  KEY `FK_JOB` (`JOB_ID`),
  CONSTRAINT `FK_EMPLOYEE` FOREIGN KEY (`EMPLOYEE_ID`) REFERENCES `employees` (`EMPLOYEE_ID`),
  CONSTRAINT `FK_JOB` FOREIGN KEY (`JOB_ID`) REFERENCES `jobs` (`JOB_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for locations
-- ----------------------------
DROP TABLE IF EXISTS `locations`;
CREATE TABLE `locations` (
  `LOCATION_ID` int NOT NULL,
  `STREET_ADDRESS` varchar(25) DEFAULT NULL,
  `POSTAL_CODE` varchar(12) DEFAULT NULL,
  `CITY` varchar(30) DEFAULT NULL,
  `STATE_PROVINCE` varchar(12) DEFAULT NULL,
  `COUNTRY_ID` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`LOCATION_ID`),
  KEY `FK_COUNTRY_ID` (`COUNTRY_ID`),
  CONSTRAINT `FK_COUNTRY_ID` FOREIGN KEY (`COUNTRY_ID`) REFERENCES `countries` (`COUNTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for regions
-- ----------------------------
DROP TABLE IF EXISTS `regions`;
CREATE TABLE `regions` (
  `REGION_ID` decimal(10,0) NOT NULL,
  `REGION_NAME` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`REGION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




DML

#3.write a query to find the location_id, steet_adress,city...------------
SELECT
	l.LOCATION_ID,
	l.STREET_ADDRESS,
	l.CITY,
	l.STATE_PROVINCE,
	c.COUNTRY_NAME
FROM
	locations l
LEFT JOIN countries c ON l.COUNTRY_ID = c.COUNTRY_ID;


#4.----------------------------
SELECT
	e.FIRST_NAME,
	e.LAST_NAME,
	e.DEPARTMENT_ID
FROM
	employees e;


#5.------------------------------
SELECT
	e.FIRST_NAME,
	e.LAST_NAME,
	e.JOB_ID,
	e.DEPARTMENT_ID
FROM
	employees e,
	departments d,
	locations l
WHERE
	e.DEPARTMENT_ID = d.DEPARTMENT_ID
AND d.LOCATION_ID = l.LOCATION_ID
AND l.COUNTRY_ID = 'JP';



#6.-------------------------------------
SELECT
	e.EMPLOYEE_ID,
	e.LAST_NAME,
	e.MANAGER_ID,
	m.LAST_NAME as Manager_name
FROM
	employees e
LEFT JOIN employees m ON e.MANAGER_ID = m.EMPLOYEE_ID;



#7.--------------------------------
SELECT
	e.FIRST_NAME,
	e.LAST_NAME,
	e.HIRE_DATE
FROM
	employees e
WHERE
	e.HIRE_DATE > (
		SELECT
			HIRE_DATE
		FROM
			employees
		WHERE
			CONCAT(
				FIRST_NAME,
				LAST_NAME) = 'Lex De Hann' LIMIT 1
			);

#8.-----------------------------
SELECT
	d.DEPARTMENT_NAME,
	COUNT(e.EMPLOYEE_ID) AS NUM_OF_EMP
FROM
	employees e,
	departments d
WHERE
	e.DEPARTMENT_ID = d.DEPARTMENT_ID
GROUP BY
	d.DEPARTMENT_NAME;


#9.------------------------------
SELECT
	jh.EMPLOYEE_ID,
	j.JOB_TITLE,
	DATEDIFF(jh.END_DATE , jh.START_DATE) AS NUM_OF_DAYS
FROM
	job_history jh,
	jobs j
WHERE
	jh.JOB_ID = j.JOB_ID
AND jh.DEPARTMENT_ID = 30;


#10.------------------------
WITH depart_manager AS (
	SELECT
		d.department_name,
		CONCAT(e.first_name, e.last_name) AS MANAGER_NAME,
		d.location_id
	FROM
		departments d
	LEFT JOIN employees e ON d.manager_id = e.employee_id
) SELECT
	dm.MANAGER_NAME,
	dm.department_name,
	c.country_name,
	l.city
FROM
	depart_manager dm,
	locations l,
	countries c
WHERE
	dm.location_id = l.location_id
AND l.country_id = c.country_id;


#11.-----------------
SELECT
	max(d.DEPARTMENT_NAME) AS DEPARTMENT_NAME,
	ROUND(AVG(e.SALARY),2) AS AVG_SALARY
FROM
	employees e
LEFT JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
GROUP BY
	e.DEPARTMENT_ID


#12
 1) re-design table jobs : REMOVE COLUMN MIN_SALARY , MAX_SALARY, it is better to put it in the grade TABLE
 