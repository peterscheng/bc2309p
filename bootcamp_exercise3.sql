##Question 1a

-- ----------------------------
-- Table structure for city
-- ----------------------------
DROP TABLE IF EXISTS `city`;
CREATE TABLE `city` (
  `id` int NOT NULL,
  `city_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` int NOT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `city_id` int DEFAULT NULL,
  `customer_address` varchar(255) DEFAULT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `phone` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_CITY_ID` (`city_id`),
  CONSTRAINT `FK_CITY_ID` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for invoice
-- ----------------------------
DROP TABLE IF EXISTS `invoice`;
CREATE TABLE `invoice` (
  `id` int NOT NULL,
  `invoice_number` varchar(255) DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `user_account_id` int DEFAULT NULL,
  `total_price` decimal(8,2) DEFAULT NULL,
  `time_issued` varchar(255) DEFAULT NULL,
  `time_due` varchar(255) DEFAULT NULL,
  `time_paid` varchar(255) DEFAULT NULL,
  `time_canceled` varchar(255) DEFAULT NULL,
  `time_refunded` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_CUSTOMER_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for invoice_item
-- ----------------------------
DROP TABLE IF EXISTS `invoice_item`;
CREATE TABLE `invoice_item` (
  `id` int NOT NULL,
  `invoice_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `line_total_price` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_INVOICE_ID` (`invoice_id`),
  KEY `FK_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_INVOICE_ID` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `FK_PRODUCT_ID` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int NOT NULL,
  `sku` varchar(32) DEFAULT NULL,
  `product_name` varchar(128) DEFAULT NULL,
  `product_description` text,
  `current_price` decimal(8,2) DEFAULT NULL,
  `quantity_in_stock` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


##Question 1b
INSERT INTO `city` VALUES ('1', 'aa');
INSERT INTO `city` VALUES ('2', 'bb');
INSERT INTO `city` VALUES ('3', 'cc');
INSERT INTO `city` VALUES ('4', 'dd');
INSERT INTO `customer` VALUES ('1', 'Drogerie', '1', 'Deckergasse 15A', 'Emil Steinbach', 'emil@drogeriewien.com', '094234234');
INSERT INTO `invoice` VALUES ('1', '111', '1', '4', '1436.00', '7/20/2019 3:05:07PM', '7/27/2019 3:05:07PM', '7/25/2019 3:05:07PM', null, null);
INSERT INTO `invoice_item` VALUES ('1', '1', '1', '20', '65.00', '1300.00');
INSERT INTO `product` VALUES ('1', '330120', 'Game of Thrones', 'Game of Thrones Eyeshadow ', '65.00', '122');

##Question 1c
SELECT
	'customer' AS string,
	c.id AS id,
	c.customer_name AS NAME
FROM
	customer c
WHERE
	c.id NOT IN (
		SELECT
			customer_id
		FROM
			invoice
	)
UNION
	SELECT
		'product' AS string,
		p.id AS id,
		p.product_name AS NAME
	FROM
		product p
	WHERE
		p.id NOT IN (
			SELECT
				product_id
			FROM
				invoice_item
		);
		
		
##Question 2


-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `DEPT_CODE` varchar(3) NOT NULL,
  `DEPT_NAME` varchar(200) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `EMPLOYEE_NAME` varchar(30) NOT NULL,
  `SALARY` decimal(8,2) DEFAULT NULL,
  `PHONE` decimal(15,0) DEFAULT NULL,
  `EMAIL` varchar(50) DEFAULT NULL,
  `DEPT_ID` int NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





2a)

SELECT
	D.DEPT_CODE AS 'Department Code',
	count(e.ID) AS 'Number of Employees'
FROM
	department D
LEFT JOIN employee E ON D.ID = E.DEPT_ID
GROUP BY
	D.DEPT_CODE
ORDER BY
	2 DESC,
	1 ASC
	
	
2b)
yes





