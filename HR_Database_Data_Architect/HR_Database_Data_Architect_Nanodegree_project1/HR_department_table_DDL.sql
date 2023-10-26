
CREATE TABLE `education_level_details` (
  `Eduction_lvl_ID` int NOT NULL AUTO_INCREMENT,
  `Eduction_level` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Eduction_lvl_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `salary` (
  `Salary_ID` int NOT NULL AUTO_INCREMENT,
  `Salary` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Salary_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `location` (
  `Location_ID` int NOT NULL AUTO_INCREMENT,
  `Location` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Location_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `job_title` (
  `Job_ID` int NOT NULL AUTO_INCREMENT,
  `Job_Title` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Job_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `department` (
  `Department_ID` int NOT NULL AUTO_INCREMENT,
  `Depart_Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Department_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `address` (
  `Address_ID` int NOT NULL AUTO_INCREMENT,
  `Street_address` varchar(50) DEFAULT NULL,
  `City` varchar(30) DEFAULT NULL,
  `State` varchar(2) DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  PRIMARY KEY (`Address_ID`),
  KEY `location_map_fk_idx` (`location_id`),
  CONSTRAINT `location_map_fk` FOREIGN KEY (`location_id`) REFERENCES `location` (`Location_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `employee_details` (
  `Employee_ID` varchar(7) NOT NULL,
  `Employee_Name` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Edu_level_ID` int DEFAULT NULL,
  PRIMARY KEY (`Employee_ID`),
  KEY `Eduction_lvl_ID_idx` (`Edu_level_ID`),
  CONSTRAINT `edu_lvl_fk` FOREIGN KEY (`Edu_level_ID`) REFERENCES `education_level_details` (`Eduction_lvl_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `employment_details` (
  `Emp_ID` varchar(7) NOT NULL,
  `Address_ID` int DEFAULT NULL,
  `Job_ID` int DEFAULT NULL,
  `Location_ID` int DEFAULT NULL,
  `Depart_ID` int DEFAULT NULL,
  `Manager_ID` varchar(7) DEFAULT NULL,
  `Salary_ID` int DEFAULT NULL,
  `Hire_DT` date DEFAULT NULL,
  `Start_DT` date NOT NULL,
  `End_DT` date DEFAULT NULL,
  PRIMARY KEY (`Emp_ID`,`Start_DT`),
  KEY `add_mp_fk_idx` (`Address_ID`),
  KEY `job_map_fk_idx` (`Job_ID`),
  KEY `loc_map_fk_idx` (`Location_ID`),
  KEY `dept_map_fk_idx` (`Depart_ID`),
  KEY `sal_map_fk_idx` (`Salary_ID`),
  KEY `emp_map_fk_idx` (`Emp_ID`,`Manager_ID`),
  KEY `mgr_map_fk_idx` (`Manager_ID`),
  CONSTRAINT `add_mp_fk` FOREIGN KEY (`Address_ID`) REFERENCES `address` (`Address_ID`),
  CONSTRAINT `dept_map_fk` FOREIGN KEY (`Depart_ID`) REFERENCES `department` (`Department_ID`),
  CONSTRAINT `emp_map_fk` FOREIGN KEY (`Emp_ID`) REFERENCES `employee_details` (`Employee_ID`),
  CONSTRAINT `job_map_fk` FOREIGN KEY (`Job_ID`) REFERENCES `job_title` (`Job_ID`),
  CONSTRAINT `loc_map_fk` FOREIGN KEY (`Location_ID`) REFERENCES `location` (`Location_ID`),
  CONSTRAINT `mgr_map_fk` FOREIGN KEY (`Manager_ID`) REFERENCES `employee_details` (`Employee_ID`),
  CONSTRAINT `sal_map_fk` FOREIGN KEY (`Salary_ID`) REFERENCES `salary` (`Salary_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

