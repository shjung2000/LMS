-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema is212g8t6
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `is212g8t6` ;

-- -----------------------------------------------------
-- Schema is212g8t6
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `is212g8t6` DEFAULT CHARACTER SET utf8 ;
USE `is212g8t6` ;

-- -----------------------------------------------------
-- Table `is212g8t6`.`LMS_Role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `is212g8t6`.`LMS_Role` (
  `LMS_Role_ID` INT NOT NULL AUTO_INCREMENT,
  `LMS_Role_Name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`LMS_Role_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `is212g8t6`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `is212g8t6`.`Staff` (
  `Staff_ID` INT NOT NULL AUTO_INCREMENT,
  `Staff_FName` VARCHAR(50) NOT NULL,
  `Staff_LName` VARCHAR(50) NOT NULL,
  `Dept` VARCHAR(50) NOT NULL,
  `Email` VARCHAR(50) NOT NULL,
  `LMS_Role_ID` INT NOT NULL,
  PRIMARY KEY (`Staff_ID`),
  INDEX `fk_Staff_LMS_Role1_idx` (`LMS_Role_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Staff_LMS_Role1`
    FOREIGN KEY (`LMS_Role_ID`)
    REFERENCES `is212g8t6`.`LMS_Role` (`LMS_Role_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `is212g8t6`.`Role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `is212g8t6`.`Role` (
  `Role_ID` INT NOT NULL AUTO_INCREMENT,
  `Role_Name` VARCHAR(20) NOT NULL,
  `Role_Des` VARCHAR(50) NULL,
  `Role_Is_Active` TINYINT NULL,
  PRIMARY KEY (`Role_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `is212g8t6`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `is212g8t6`.`Course` (
  `Course_ID` VARCHAR(20) NOT NULL,
  `Course_Name` VARCHAR(50) NOT NULL,
  `Course_Desc` VARCHAR(255) NULL,
  `Course_Status` VARCHAR(15) NULL,
  `Course_Type` VARCHAR(10) NULL,
  `Course_Category` VARCHAR(50) NULL,
  `Course_Is_Active` TINYINT NULL,
  PRIMARY KEY (`Course_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `is212g8t6`.`Registration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `is212g8t6`.`Registration` (
  `Reg_ID` INT NOT NULL AUTO_INCREMENT,
  `Course_ID` VARCHAR(20) NOT NULL,
  `Staff_ID` INT NOT NULL,
  `Reg_Status` VARCHAR(20) NOT NULL,
  `Completion_Status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Reg_ID`),
  INDEX `Course_ID_FK_idx` (`Course_ID` ASC) VISIBLE,
  INDEX `Staff_ID_FK_idx` (`Staff_ID` ASC) VISIBLE,
  CONSTRAINT `Course_ID_FK`
    FOREIGN KEY (`Course_ID`)
    REFERENCES `is212g8t6`.`Course` (`Course_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Staff_ID_FK`
    FOREIGN KEY (`Staff_ID`)
    REFERENCES `is212g8t6`.`Staff` (`Staff_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `is212g8t6`.`Skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `is212g8t6`.`Skill` (
  `Skill_ID` INT NOT NULL AUTO_INCREMENT,
  `Skill_Name` VARCHAR(50) NOT NULL,
  `Skill_Des` VARCHAR(50) NULL,
  `Skill_Is_Active` TINYINT NOT NULL,
  PRIMARY KEY (`Skill_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `is212g8t6`.`Learning_Journey`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `is212g8t6`.`Learning_Journey` (
  `LJ_ID` INT NOT NULL AUTO_INCREMENT,
  `Staff_ID` INT NOT NULL,
  `Role_ID` INT NOT NULL,
  `has_start` TINYINT NOT NULL,
  PRIMARY KEY (`LJ_ID`),
  INDEX `fk_Learning_Journey_Role1_idx` (`Role_ID` ASC) VISIBLE,
  INDEX `fk_Learning_Journey_Staff1_idx` (`Staff_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Learning_Journey_Staff1`
    FOREIGN KEY (`Staff_ID`)
    REFERENCES `is212g8t6`.`Staff` (`Staff_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Learning_Journey_Role1`
    FOREIGN KEY (`Role_ID`)
    REFERENCES `is212g8t6`.`Role` (`Role_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `is212g8t6`.`Course_has_Skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `is212g8t6`.`Course_has_Skill` (
  `Course_has_Skill_ID` INT NOT NULL,
  `Course_ID` VARCHAR(20) NOT NULL,
  `Skill_ID` INT NOT NULL,
  PRIMARY KEY (`Course_has_Skill_ID`),
  INDEX `fk_Course_has_Skill_Skill1_idx` (`Skill_ID` ASC) VISIBLE,
  INDEX `fk_Course_has_Skill_Course1_idx` (`Course_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Course_has_Skill_Course1`
    FOREIGN KEY (`Course_ID`)
    REFERENCES `is212g8t6`.`Course` (`Course_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Course_has_Skill_Skill1`
    FOREIGN KEY (`Skill_ID`)
    REFERENCES `is212g8t6`.`Skill` (`Skill_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `is212g8t6`.`Learning_Journey_has_Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `is212g8t6`.`Learning_Journey_has_Course` (
  `LJ_HC_ID` INT NOT NULL,
  `Learning_Journey_LJ_ID` INT NOT NULL,
  `Course_ID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`LJ_HC_ID`),
  INDEX `fk_Learning_Journey_has_Course_Learning_Journey1_idx` (`Learning_Journey_LJ_ID` ASC) VISIBLE,
  INDEX `fk_Learning_Journey_has_Course_Course1_idx` (`Course_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Learning_Journey_has_Course_Learning_Journey1`
    FOREIGN KEY (`Learning_Journey_LJ_ID`)
    REFERENCES `is212g8t6`.`Learning_Journey` (`LJ_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Learning_Journey_has_Course_Course1`
    FOREIGN KEY (`Course_ID`)
    REFERENCES `is212g8t6`.`Course` (`Course_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `is212g8t6`.`Role_has_Skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `is212g8t6`.`Role_has_Skill` (
  `Role_has_Skill_ID` INT NOT NULL,
  `Role_ID` INT NOT NULL,
  `Skill_ID` INT NOT NULL,
  PRIMARY KEY (`Role_has_Skill_ID`),
  INDEX `fk_Role_has_Skill_Skill1_idx` (`Skill_ID` ASC) VISIBLE,
  INDEX `fk_Role_has_Skill_Role1_idx` (`Role_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Role_has_Skill_Role1`
    FOREIGN KEY (`Role_ID`)
    REFERENCES `is212g8t6`.`Role` (`Role_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Role_has_Skill_Skill1`
    FOREIGN KEY (`Skill_ID`)
    REFERENCES `is212g8t6`.`Skill` (`Skill_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `is212g8t6`.`LMS_Role`
-- -----------------------------------------------------
START TRANSACTION;
USE `is212g8t6`;
INSERT INTO `is212g8t6`.`LMS_Role` (`LMS_Role_ID`, `LMS_Role_Name`) VALUES (1, 'Admin');
INSERT INTO `is212g8t6`.`LMS_Role` (`LMS_Role_ID`, `LMS_Role_Name`) VALUES (2, 'User');
INSERT INTO `is212g8t6`.`LMS_Role` (`LMS_Role_ID`, `LMS_Role_Name`) VALUES (3, 'Manager');
INSERT INTO `is212g8t6`.`LMS_Role` (`LMS_Role_ID`, `LMS_Role_Name`) VALUES (4, 'Trainer');

COMMIT;


-- -----------------------------------------------------
-- Data for table `is212g8t6`.`Staff`
-- -----------------------------------------------------
START TRANSACTION;
USE `is212g8t6`;
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (130001, 'John', 'Sim', 'Chariman', 'jack.sim@allinone.com.sg', 1);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (130002, 'Jack', 'Sim', 'CEO', 'jack.sim@allinone.com.sg', 1);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (140001, 'Derek', 'Tan', 'Sales', 'Derek.Tan@allinone.com.sg', 3);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (140002, 'Susan', 'Goh', 'Sales', 'Susan.Goh@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (140003, 'Janice', 'Chan', 'Sales', 'Janice.Chan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (140004, 'Mary', 'Teo', 'Sales', 'Mary.Teo@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (140008, 'Jaclyn', 'Lee', 'Sales', 'Jaclyn.Lee@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (140015, 'Oliva', 'Lim', 'Sales', 'Oliva.Lim@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (140025, 'Emma', 'Heng', 'Sales', 'Emma.Heng@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (140036, 'Charlotte', 'Wong', 'Sales', 'Charlotte.Wong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (140078, 'Amelia', 'Ong', 'Sales', 'Amelia.Ong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (140102, 'Eva', 'Yong', 'Sales', 'Eva.Yong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (140103, 'Sophia', 'Toh', 'Sales', 'Sophia.Toh@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (140108, 'Liam', 'The', 'Sales', 'Liam.The@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (140115, 'Noah', 'Ng', 'Sales', 'Noah.Ng@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (140525, 'Oliver', 'Tan', 'Sales', 'Oliver.Tan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (140736, 'William', 'Fu', 'Sales', 'William.Fu@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (140878, 'James', 'Tong', 'Sales', 'James.Tong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150008, 'Eric', 'Loh', 'Ops', 'Eric.Loh@allinone.com.sg', 3);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150065, 'Noah', 'Goh', 'Ops', 'Noah.Goh@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150075, 'Liam', 'Tan', 'Ops', 'Liam.Tan@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150076, 'Oliver', 'Chan', 'Ops', 'Oliver.Chan@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150085, 'Michael', 'Ng', 'Ops', 'Michael.Ng@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150095, 'Alexander', 'The', 'Ops', 'Alexander.The@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150096, 'Ethan', 'Tan', 'Ops', 'Ethan.Tan@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150115, 'Jaclyn', 'Lee', 'Ops', 'Jaclyn.Lee@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150118, 'William', 'Teo', 'Ops', 'William.Teo@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150125, 'Mary', 'Teo', 'Ops', 'Mary.Teo@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150126, 'Oliva', 'Lim', 'Ops', 'Oliva.Lim@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150138, 'Daniel', 'Fu', 'Ops', 'Daniel.Fu@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150142, 'James', 'Lee', 'Ops', 'James.Lee@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150143, 'John', 'Lim', 'Ops', 'John.Lim@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150148, 'Jack', 'Heng', 'Ops', 'Jack.Heng@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150155, 'Derek', 'Wong', 'Ops', 'Derek.Wong@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150162, 'Jacob', 'Tong', 'Ops', 'Jacob.Tong@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150163, 'Logan', 'Loh', 'Ops', 'Logan.Loh@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150165, 'Oliver', 'Tan', 'Ops', 'Oliver.Tan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150166, 'William', 'Fu', 'Ops', 'William.Fu@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150168, 'Jackson', 'Tan', 'Ops', 'Jackson.Tan@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150175, 'Aiden', 'Tan', 'Ops', 'Aiden.Tan@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150192, 'Emma', 'Heng', 'Ops', 'Emma.Heng@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150193, 'Charlotte', 'Wong', 'Ops', 'Charlotte.Wong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150198, 'Amelia', 'Ong', 'Ops', 'Amelia.Ong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150205, 'Eva', 'Yong', 'Ops', 'Eva.Yong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150208, 'James', 'Tong', 'Ops', 'James.Tong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150215, 'Michael', 'Lee', 'Ops', 'Michael.Lee@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150216, 'Ethan', 'Lim', 'Ops', 'Ethan.Lim@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150232, 'John', 'Loh', 'Ops', 'John.Loh@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150233, 'Jack', 'Tan', 'Ops', 'Jack.Tan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150238, 'Derek', 'Tan', 'Ops', 'Derek.Tan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150245, 'Benjamin', 'Tan', 'Ops', 'Benjamin.Tan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150258, 'Daniel', 'Heng', 'Ops', 'Daniel.Heng@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150265, 'Jaclyn', 'Tong', 'Ops', 'Jaclyn.Tong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150275, 'Mary', 'Fu', 'Ops', 'Mary.Fu@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150276, 'Oliva', 'Loh', 'Ops', 'Oliva.Loh@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150282, 'Jacob', 'Wong', 'Ops', 'Jacob.Wong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150283, 'Logan', 'Ong', 'Ops', 'Logan.Ong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150288, 'Jackson', 'Yong', 'Ops', 'Jackson.Yong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150295, 'Aiden', 'Toh', 'Ops', 'Aiden.Toh@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150318, 'Emma', 'Tan', 'Ops', 'Emma.Tan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150342, 'Charlotte', 'Tan', 'Ops', 'Charlotte.Tan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150343, 'Amelia', 'Tan', 'Ops', 'Amelia.Tan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150345, 'William', 'Heng', 'Ops', 'William.Heng@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150348, 'Eva', 'Goh', 'Ops', 'Eva.Goh@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150355, 'Sophia', 'Chan', 'Ops', 'Sophia.Chan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150356, 'James', 'Wong', 'Ops', 'James.Wong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150398, 'John', 'Ong', 'Ops', 'John.Ong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150422, 'Jack', 'Yong', 'Ops', 'Jack.Yong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150423, 'Derek', 'Toh', 'Ops', 'Derek.Toh@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150428, 'Benjamin', 'The', 'Ops', 'Benjamin.The@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150435, 'Lucas', 'Ng', 'Ops', 'Lucas.Ng@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150445, 'Ethan', 'Loh', 'Ops', 'Ethan.Loh@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150446, 'Daniel', 'Tan', 'Ops', 'Daniel.Tan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150488, 'Jacob', 'Tan', 'Ops', 'Jacob.Tan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150512, 'Logan', 'Tan', 'Ops', 'Logan.Tan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150513, 'Jackson', 'Goh', 'Ops', 'Jackson.Goh@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150518, 'Aiden', 'Chan', 'Ops', 'Aiden.Chan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150525, 'Samuel', 'Teo', 'Ops', 'Samuel.Teo@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150555, 'Jaclyn', 'Wong', 'Ops', 'Jaclyn.Wong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150565, 'Benjamin', 'Ong', 'Ops', 'Benjamin.Ong@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150566, 'Oliva', 'Ong', 'Ops', 'Oliva.Ong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150585, 'Samuel', 'Tan', 'Ops', 'Samuel.Tan@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150608, 'Emma', 'Yong', 'Ops', 'Emma.Yong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150615, 'Sophia', 'Toh', 'Ops', 'Sophia.Toh@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150632, 'Charlotte', 'Toh', 'Ops', 'Charlotte.Toh@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150633, 'Amelia', 'The', 'Ops', 'Amelia.The@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150638, 'Eva', 'Ng', 'Ops', 'Eva.Ng@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150645, 'Sophia', 'Tan', 'Ops', 'Sophia.Tan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150655, 'Lucas', 'Goh', 'Ops', 'Lucas.Goh@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150695, 'William', 'Tan', 'Ops', 'William.Tan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150705, 'Samuel', 'The', 'Ops', 'Samuel.The@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150765, 'Liam', 'Teo', 'Ops', 'Liam.Teo@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150776, 'Lucas', 'Yong', 'Ops', 'Lucas.Yong@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150796, 'Susan', 'Goh', 'Ops', 'Susan.Goh@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150826, 'Liam', 'The', 'Ops', 'Liam.The@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150845, 'Henry', 'Tan', 'Ops', 'Henry.Tan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150866, 'Henry', 'Chan', 'Ops', 'Henry.Chan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150916, 'Susan', 'Ng', 'Ops', 'Susan.Ng@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150918, 'Henry', 'Toh', 'Ops', 'Henry.Toh@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150935, 'Susan', 'Lee', 'Ops', 'Susan.Lee@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150938, 'Janice', 'Chan', 'Ops', 'Janice.Chan@allinone.com.sg', 4);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150968, 'Noah', 'Ng', 'Ops', 'Noah.Ng@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (150976, 'Noah', 'Lee', 'Ops', 'Noah.Lee@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (151008, 'Alexander', 'Teo', 'Ops', 'Alexander.Teo@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (151055, 'Liam', 'Fu', 'Ops', 'Liam.Fu@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (151056, 'Alexander', 'Fu', 'Ops', 'Alexander.Fu@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (151058, 'Janice', 'Tan', 'Ops', 'Janice.Tan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (151118, 'Oliver', 'Lim', 'Ops', 'Oliver.Lim@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (151146, 'Janice', 'Lim', 'Ops', 'Janice.Lim@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (151198, 'Michael', 'Tong', 'Ops', 'Michael.Tong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (151266, 'Noah', 'Tong', 'Ops', 'Noah.Tong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (151288, 'Mary', 'Heng', 'Ops', 'Mary.Heng@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (151408, 'Oliver', 'Loh', 'Ops', 'Oliver.Loh@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160008, 'Sally', 'Loh', 'HR', 'Sally.Loh@allinone.com.sg', 1);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160065, 'John', 'Tan', 'HR', 'John.Tan@allinone.com.sg', 1);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160075, 'James', 'Tan', 'HR', 'James.Tan@allinone.com.sg', 1);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160076, 'Jack', 'Goh', 'HR', 'Jack.Goh@allinone.com.sg', 1);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160118, 'Derek', 'Chan', 'HR', 'Derek.Chan@allinone.com.sg', 1);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160135, 'Jaclyn', 'Ong', 'HR', 'Jaclyn.Ong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160142, 'Benjamin', 'Teo', 'HR', 'Benjamin.Teo@allinone.com.sg', 1);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160143, 'Lucas', 'Lee', 'HR', 'Lucas.Lee@allinone.com.sg', 1);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160145, 'Mary', 'Wong', 'HR', 'Mary.Wong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160146, 'Oliva', 'Yong', 'HR', 'Oliva.Yong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160148, 'Henry', 'Lim', 'HR', 'Henry.Lim@allinone.com.sg', 1);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160155, 'Alexander', 'Heng', 'HR', 'Alexander.Heng@allinone.com.sg', 1);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160188, 'Emma', 'Toh', 'HR', 'Emma.Toh@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160212, 'Charlotte', 'The', 'HR', 'Charlotte.The@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160213, 'Amelia', 'Ng', 'HR', 'Amelia.Ng@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160218, 'Eva', 'Tan', 'HR', 'Eva.Tan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160225, 'Sophia', 'Fu', 'HR', 'Sophia.Fu@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160258, 'Michael', 'Tong', 'HR', 'Michael.Tong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (160282, 'Ethan', 'Loh', 'HR', 'Ethan.Loh@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (170166, 'David', 'Yap', 'Finance', 'David.Yap@allinone.com.sg', 3);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (170208, 'Daniel', 'Tan', 'Finance', 'Daniel.Tan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (170215, 'Mary', 'Wong', 'Finance', 'Mary.Wong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (170216, 'Jaclyn', 'Ong', 'Finance', 'Jaclyn.Ong@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (170232, 'Jacob', 'Tan', 'Finance', 'Jacob.Tan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (170233, 'Logan', 'Goh', 'Finance', 'Logan.Goh@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (170238, 'Jackson', 'Chan', 'Finance', 'Jackson.Chan@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (170245, 'Aiden', 'Teo', 'Finance', 'Aiden.Teo@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (170655, 'Samuel', 'Lee', 'Finance', 'Samuel.Lee@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (170866, 'Susan', 'Lim', 'Finance', 'Susan.Lim@allinone.com.sg', 2);
INSERT INTO `is212g8t6`.`Staff` (`Staff_ID`, `Staff_FName`, `Staff_LName`, `Dept`, `Email`, `LMS_Role_ID`) VALUES (171008, 'Janice', 'Heng', 'Finance', 'Janice.Heng@allinone.com.sg', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `is212g8t6`.`Role`
-- -----------------------------------------------------
START TRANSACTION;
USE `is212g8t6`;
INSERT INTO `is212g8t6`.`Role` (`Role_ID`, `Role_Name`, `Role_Des`, `Role_Is_Active`) VALUES (10021, 'Front-end Developer', 'Front-end Developer', 1);
INSERT INTO `is212g8t6`.`Role` (`Role_ID`, `Role_Name`, `Role_Des`, `Role_Is_Active`) VALUES (10502, 'Back-end Developer', 'Back-end Developer Description', 1);
INSERT INTO `is212g8t6`.`Role` (`Role_ID`, `Role_Name`, `Role_Des`, `Role_Is_Active`) VALUES (10203, 'Full-stack Developer', 'Full-stack Developer Description', 1);
INSERT INTO `is212g8t6`.`Role` (`Role_ID`, `Role_Name`, `Role_Des`, `Role_Is_Active`) VALUES (10024, 'Security Analyst ', 'Security Analyst Description', 1);
INSERT INTO `is212g8t6`.`Role` (`Role_ID`, `Role_Name`, `Role_Des`, `Role_Is_Active`) VALUES (10023, 'CEO', 'CEO Description', 1);
INSERT INTO `is212g8t6`.`Role` (`Role_ID`, `Role_Name`, `Role_Des`, `Role_Is_Active`) VALUES (10025, 'Others', 'Others', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `is212g8t6`.`Course`
-- -----------------------------------------------------
START TRANSACTION;
USE `is212g8t6`;
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('COR001', 'Systems Thinking and Design', 'This foundation module aims to introduce students to the fundamental concepts and underlying principles of systems thinking,', 'Active', 'Internal', 'Core', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('COR002', 'Lean Six Sigma Green Belt Certification', 'Apply Lean Six Sigma methodology and statistical tools such as Minitab to be used in process analytics', 'Active', 'Internal', 'Core', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('COR004', 'Service Excellence', 'The programme provides the learner with the key foundations of what builds customer confidence in the service industr', 'Pending', 'Internal', 'Core', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('COR006', 'Manage Change', 'Identify risks associated with change and develop risk mitigation plans.', 'Retired', 'External', 'Core', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('FIN001', 'Data Collection and Analysis', 'Data is meaningless unless insights and analysis can be drawn to provide useful information for business decision-making. It is imperative that data quality, integrity and security ', 'Active', 'External', 'Finance', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('FIN002', 'Risk and Compliance Reporting', 'Regulatory reporting is a requirement for businesses from highly regulated sectors to demonstrate compliance with the necessary regulatory provisions.', 'Active', 'External', 'Finance', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('FIN003', 'Business Continuity Planning', 'Business continuity planning is essential in any business to minimise loss when faced with potential threats and disruptions.', 'Retired', 'External', 'Finance', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('HRD001', 'Leading and Shaping a Culture in Learning', 'This training programme, delivered by the National Centre of Excellence (Workplace Learning), aims to equip participants with the skills and knowledge of the National workplace learning certification framework,', 'Active', 'External', 'HR', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('MGT001', 'People Management', 'enable learners to manage team performance and development through effective communication, conflict resolution and negotiation skills.', 'Active', 'Internal', 'Management', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('MGT002', 'Workplace Conflict Management for Professionals', 'This course will address the gaps to build consensus and utilise knowledge of conflict management techniques to diffuse tensions and achieve resolutions effectively in the best interests of the organisation.', 'Active', 'External', 'Management', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('MGT003', 'Enhance Team Performance Through Coaching', 'The course aims to upskill real estate team leaders in the area of service coaching for performance.', 'Pending', 'Internal', 'Management', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('MGT004', 'Personal Effectiveness for Leaders', 'Learners will be able to acquire the skills and knowledge to undertake self-assessment in relation to one’s performance and leadership style', 'Active', 'External', 'Management', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('MGT007', 'Supervisory Management Skills', 'Supervisors lead teams, manage tasks, solve problems, report up and down the hierarchy, and much more. ', 'Retired', 'External', 'Management', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('SAL001', 'Risk Management for Smart Business', 'Apply risk management concepts to digital business', 'Retired', 'Internal', 'Sales', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('SAL002', 'CoC in Smart Living Solutions', 'Participants will acquire the knowledge and skills in setting up a smart living solution', 'Pending', 'External', 'Sales', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('SAL003', 'Optimising Your Brand For The Digital Spaces', 'Digital has fundamentally shifted communication between brands and their consumers from a one-way broadcast to a two-way dialogue. In a hastened bid to transform their businesses to be digital market-ready,', 'Active', 'External', 'Sales', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('SAL004', 'Stakeholder Management', 'Develop a stakeholder engagement plan and negotiate with stakeholders to arrive at mutually-beneficial arrangements.', 'Active', 'Internal', 'Sales', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('tch001', 'Print Server Setup', 'Setting up print server in enterprise environment', 'Retired', 'Internal', 'Technical', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('tch002', 'Canon MFC Setup', 'Setting up Canon ImageRUNNER series of products', 'Retired', 'Internal', 'Technical', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('tch003', 'Canon MFC Mainteance and Troubleshooting', 'Troubleshoot and fixing L2,3 issues of Canon ImageRUNNER series of products', 'Active', 'Internal', 'Technical', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('tch004', 'Introduction to Open Platform Communications', 'This course provides the participants with a good in-depth understanding of the SS IEC 62541 standard', 'Pending', 'Internal', 'Technical', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('tch005', 'An Introduction to Sustainability', 'The course provides learners with the multi-faceted basic knowledge of sustainability.', 'Active', 'External', 'Technical', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('tch006', 'Machine Learning DevOps Engineer ', 'The Machine Learning DevOps Engineer Nanodegree program focuses on the software engineering fundamentals needed to successfully streamline the deployment of data and machine-learning models', 'Pending', 'Internal', 'Technical', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('tch008', 'Technology Intelligence and Strategy', 'Participants will be able to gain knowledge and skills on: - establishing technology strategy with technology intelligence framework and tools', 'Active', 'External', 'Technical', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('tch009', 'Smart Sensing Technology', 'This course introduces sensors and sensing systems. The 5G infrastructure enables the many fast-growing IoT applications equipped with sensors ', 'Pending', 'External', 'Technical', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('tch012', 'Internet of Things', 'The Internet of Things (IoT) is integrating our digital and physical world, opening up new and exciting opportunities to deploy, automate, optimize and secure diverse use cases and applications. ', 'Active', 'Internal', 'Technical', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('tch013', 'Managing Cybersecurity and Risks', 'Digital security is the core of our daily lives considering that our dependence on the digital world', 'Active', 'Internal', 'Technical', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('tch014', 'Certified Information Privacy Professional', 'The Certified Information Privacy Professional/ Asia (CIPP/A) is the first publicly available privacy certification', 'Active', 'External', 'Technical', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('tch015', 'Network Security', 'Understanding of the fundamental knowledge of network security including cryptography, authentication and key distribution. The security techniques at various layers of computer networks are examined.', 'Active', 'External', 'Technical', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('tch018', 'Professional Project Management', 'solid foundation in the project management processes from initiating a project, through planning, execution, control,', 'Active', 'Internal', 'Technical', 1);
INSERT INTO `is212g8t6`.`Course` (`Course_ID`, `Course_Name`, `Course_Desc`, `Course_Status`, `Course_Type`, `Course_Category`, `Course_Is_Active`) VALUES ('tch019', 'Innovation and Change Management ', 'the organization that constantly reinvents itself to be relevant has a better chance of making progress', 'Active', 'External', 'Technical', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `is212g8t6`.`Registration`
-- -----------------------------------------------------
START TRANSACTION;
USE `is212g8t6`;
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (1, 'COR002', 130001, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (245, 'COR001', 130001, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (2, 'COR002', 130002, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (3, 'COR002', 140001, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (111, 'SAL004', 140001, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (200, 'MGT001', 140001, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (246, 'COR006', 140001, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (4, 'COR002', 140002, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (112, 'SAL004', 140002, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (247, 'FIN001', 140002, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (5, 'COR002', 140003, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (113, 'SAL003', 140003, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (248, 'FIN002', 140003, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (114, 'SAL003', 140004, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (203, 'COR002', 140004, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (249, 'FIN003', 140004, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (6, 'COR002', 140008, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (115, 'SAL004', 140008, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (250, 'HRD001', 140008, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (204, 'COR002', 140015, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (251, 'MGT001', 140015, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (7, 'COR002', 140025, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (116, 'SAL003', 140025, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (252, 'MGT002', 140025, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (8, 'COR002', 140036, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (253, 'MGT004', 140036, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (9, 'COR002', 140078, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (117, 'SAL004', 140078, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (254, 'MGT007', 140078, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (10, 'COR002', 140102, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (118, 'SAL004', 140102, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (255, 'SAL001', 140102, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (11, 'COR002', 140103, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (119, 'SAL003', 140103, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (12, 'COR002', 140108, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (120, 'SAL003', 140108, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (256, 'SAL004', 140108, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (13, 'COR002', 140115, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (121, 'SAL004', 140115, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (257, 'tch001', 140115, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (14, 'COR002', 140525, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (122, 'SAL004', 140525, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (258, 'tch002', 140525, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (123, 'SAL003', 140736, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (205, 'COR002', 140736, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (259, 'tch003', 140736, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (15, 'COR002', 140878, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (124, 'SAL003', 140878, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (260, 'tch005', 140878, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (201, 'MGT001', 150008, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (206, 'COR002', 150008, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (261, 'tch008', 150008, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (17, 'COR002', 150065, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (126, 'tch003', 150065, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (263, 'tch013', 150065, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (16, 'COR002', 150075, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (125, 'tch002', 150075, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (262, 'tch012', 150075, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (18, 'COR002', 150076, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (264, 'tch014', 150076, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (26, 'COR002', 150085, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (132, 'tch002', 150085, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (273, 'HRD001', 150085, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (25, 'COR002', 150095, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (131, 'tch001', 150095, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (272, 'FIN003', 150095, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (27, 'COR002', 150096, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (133, 'tch003', 150096, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (274, 'MGT001', 150096, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (35, 'COR002', 150115, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (137, 'tch001', 150115, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (284, 'tch005', 150115, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (19, 'COR002', 150118, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (127, 'tch005', 150118, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (265, 'tch015', 150118, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (34, 'COR002', 150125, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (283, 'tch003', 150125, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (36, 'COR002', 150126, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (138, 'tch002', 150126, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (285, 'tch008', 150126, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (28, 'COR002', 150138, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (275, 'MGT002', 150138, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (20, 'COR002', 150142, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (266, 'tch018', 150142, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (21, 'COR002', 150143, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (128, 'tch001', 150143, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (267, 'tch019', 150143, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (22, 'COR002', 150148, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (129, 'tch002', 150148, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (268, 'COR001', 150148, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (23, 'COR002', 150155, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (130, 'tch003', 150155, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (29, 'COR002', 150162, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (134, 'tch005', 150162, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (276, 'MGT004', 150162, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (30, 'COR002', 150163, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (277, 'MGT007', 150163, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (212, 'COR002', 150165, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (43, 'COR002', 150166, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (143, 'tch005', 150166, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (189, 'FIN001', 150166, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (202, 'MGT001', 150166, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (237, 'tch003', 150166, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (293, 'COR006', 150166, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (31, 'COR002', 150168, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (135, 'tch001', 150168, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (278, 'SAL001', 150168, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (32, 'COR002', 150175, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (279, 'SAL003', 150175, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (37, 'COR002', 150192, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (139, 'tch003', 150192, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (286, 'tch012', 150192, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (38, 'COR002', 150193, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (287, 'tch013', 150193, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (39, 'COR002', 150198, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (140, 'tch005', 150198, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (288, 'tch014', 150198, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (40, 'COR002', 150205, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (289, 'tch015', 150205, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (44, 'COR002', 150208, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (190, 'FIN002', 150208, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (238, 'tch005', 150208, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (294, 'FIN001', 150208, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (371, 'MGT002', 150208, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (51, 'COR002', 150215, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (148, 'tch002', 150215, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (198, 'FIN002', 150215, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (243, 'tch001', 150215, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (302, 'SAL001', 150215, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (379, 'tch003', 150215, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (110, 'COR002', 150216, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (149, 'tch003', 150216, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (199, 'FIN001', 150216, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (244, 'tch005', 150216, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (303, 'SAL003', 150216, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (45, 'COR002', 150232, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (144, 'tch001', 150232, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (191, 'FIN001', 150232, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (295, 'FIN002', 150232, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (372, 'MGT004', 150232, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (46, 'COR002', 150233, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (145, 'tch002', 150233, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (192, 'FIN002', 150233, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (296, 'FIN003', 150233, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (373, 'MGT007', 150233, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (47, 'COR002', 150238, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (146, 'tch003', 150238, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (193, 'FIN001', 150238, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (297, 'HRD001', 150238, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (374, 'SAL001', 150238, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (48, 'COR002', 150245, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (194, 'FIN002', 150245, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (239, 'tch001', 150245, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (298, 'MGT001', 150245, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (375, 'SAL003', 150245, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (52, 'COR002', 150258, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (304, 'SAL004', 150258, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (60, 'COR002', 150265, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (153, 'tch001', 150265, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (313, 'tch015', 150265, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (213, 'COR002', 150275, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (312, 'tch014', 150275, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (154, 'tch002', 150276, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (214, 'COR002', 150276, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (314, 'tch018', 150276, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (53, 'COR002', 150282, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (150, 'tch005', 150282, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (305, 'tch001', 150282, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (54, 'COR002', 150283, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (306, 'tch002', 150283, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (55, 'COR002', 150288, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (151, 'tch001', 150288, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (307, 'tch003', 150288, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (56, 'COR002', 150295, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (308, 'tch005', 150295, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (61, 'COR002', 150318, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (155, 'tch003', 150318, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (315, 'tch019', 150318, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (62, 'COR002', 150342, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (316, 'COR001', 150342, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (63, 'COR002', 150343, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (156, 'tch005', 150343, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (159, 'tch005', 150345, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (215, 'COR002', 150345, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (322, 'MGT001', 150345, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (64, 'COR002', 150348, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (317, 'COR006', 150348, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (65, 'COR002', 150355, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (318, 'FIN001', 150355, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (69, 'COR002', 150356, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (323, 'MGT002', 150356, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (160, 'tch001', 150398, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (216, 'COR002', 150398, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (324, 'MGT004', 150398, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (70, 'COR002', 150422, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (161, 'tch002', 150422, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (325, 'MGT007', 150422, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (71, 'COR002', 150423, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (162, 'tch003', 150423, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (326, 'SAL001', 150423, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (72, 'COR002', 150428, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (327, 'SAL003', 150428, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (73, 'COR002', 150435, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (328, 'SAL004', 150435, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (77, 'COR002', 150445, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (165, 'tch003', 150445, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (332, 'tch005', 150445, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (217, 'COR002', 150446, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (333, 'tch008', 150446, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (78, 'COR002', 150488, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (166, 'tch005', 150488, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (334, 'tch012', 150488, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (218, 'COR002', 150512, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (335, 'tch013', 150512, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (79, 'COR002', 150513, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (167, 'tch001', 150513, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (336, 'tch014', 150513, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (80, 'COR002', 150518, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (337, 'tch015', 150518, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (81, 'COR002', 150525, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (338, 'tch018', 150525, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (85, 'COR002', 150555, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (169, 'tch001', 150555, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (341, 'COR006', 150555, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (207, 'COR002', 150565, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (269, 'COR006', 150565, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (86, 'COR002', 150566, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (170, 'tch002', 150566, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (342, 'FIN001', 150566, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (209, 'COR002', 150585, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (280, 'SAL004', 150585, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (171, 'tch003', 150608, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (219, 'COR002', 150608, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (343, 'FIN002', 150608, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (41, 'COR002', 150615, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (290, 'tch018', 150615, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (87, 'COR002', 150632, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (344, 'FIN003', 150632, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (172, 'tch005', 150633, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (220, 'COR002', 150633, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (345, 'HRD001', 150633, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (88, 'COR002', 150638, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (346, 'MGT001', 150638, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (89, 'COR002', 150645, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (347, 'MGT002', 150645, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (49, 'COR002', 150655, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (195, 'FIN001', 150655, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (240, 'tch002', 150655, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (299, 'MGT002', 150655, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (376, 'SAL004', 150655, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (93, 'COR002', 150695, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (175, 'tch005', 150695, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (351, 'SAL003', 150695, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (57, 'COR002', 150705, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (309, 'tch008', 150705, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (66, 'COR002', 150765, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (157, 'tch002', 150765, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (319, 'FIN002', 150765, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (24, 'COR002', 150776, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (270, 'FIN001', 150776, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (33, 'COR002', 150796, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (281, 'tch001', 150796, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (141, 'tch002', 150826, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (211, 'COR002', 150826, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (291, 'tch019', 150826, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (74, 'COR002', 150845, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (329, 'tch001', 150845, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (50, 'COR002', 150866, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (196, 'FIN002', 150866, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (241, 'tch003', 150866, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (300, 'MGT004', 150866, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (377, 'tch001', 150866, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (58, 'COR002', 150916, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (310, 'tch012', 150916, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (208, 'COR002', 150918, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (271, 'FIN002', 150918, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (82, 'COR002', 150935, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (339, 'tch019', 150935, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (136, 'tch005', 150938, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (210, 'COR002', 150938, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (282, 'tch002', 150938, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (42, 'COR002', 150968, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (142, 'tch003', 150968, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (292, 'COR001', 150968, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (67, 'COR002', 150976, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (158, 'tch003', 150976, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (320, 'FIN003', 150976, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (109, 'COR002', 151008, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (147, 'tch001', 151008, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (197, 'FIN001', 151008, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (242, 'tch005', 151008, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (301, 'MGT007', 151008, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (378, 'tch002', 151008, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (90, 'COR002', 151055, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (173, 'tch002', 151055, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (348, 'MGT004', 151055, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (75, 'COR002', 151056, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (163, 'tch001', 151056, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (330, 'tch002', 151056, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (59, 'COR002', 151058, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (152, 'tch005', 151058, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (311, 'tch013', 151058, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (68, 'COR002', 151118, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (321, 'HRD001', 151118, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (83, 'COR002', 151146, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (168, 'tch005', 151146, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (340, 'COR001', 151146, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (76, 'COR002', 151198, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (164, 'tch002', 151198, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (331, 'tch003', 151198, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (91, 'COR002', 151266, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (174, 'tch003', 151266, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (349, 'MGT007', 151266, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (84, 'COR002', 151288, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (92, 'COR002', 151408, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (350, 'SAL001', 151408, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (94, 'COR002', 160008, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (176, 'HRD001', 160008, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (352, 'SAL004', 160008, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (178, 'MGT002', 160065, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (221, 'COR002', 160065, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (354, 'tch002', 160065, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (95, 'COR002', 160075, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (177, 'MGT001', 160075, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (353, 'tch001', 160075, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (96, 'COR002', 160076, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (355, 'tch003', 160076, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (179, 'MGT004', 160118, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (222, 'SAL004', 160118, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (356, 'tch005', 160118, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (102, 'COR002', 160135, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (182, 'MGT004', 160135, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (228, 'SAL004', 160135, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (362, 'tch018', 160135, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (97, 'COR002', 160142, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (223, 'SAL004', 160142, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (357, 'tch008', 160142, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (98, 'COR002', 160143, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (224, 'SAL003', 160143, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (358, 'tch012', 160143, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (101, 'COR002', 160145, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (227, 'SAL003', 160145, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (361, 'tch015', 160145, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (103, 'COR002', 160146, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (183, 'MGT007', 160146, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (229, 'SAL004', 160146, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (363, 'tch019', 160146, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (99, 'COR002', 160148, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (180, 'MGT001', 160148, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (225, 'SAL003', 160148, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (359, 'tch013', 160148, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (100, 'COR002', 160155, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (181, 'MGT002', 160155, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (226, 'SAL004', 160155, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (360, 'tch014', 160155, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (104, 'COR002', 160188, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (184, 'HRD001', 160188, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (230, 'SAL003', 160188, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (364, 'COR001', 160188, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (185, 'MGT001', 160212, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (231, 'SAL003', 160212, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (365, 'COR002', 160212, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (105, 'COR002', 160213, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (186, 'MGT002', 160213, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (232, 'SAL004', 160213, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (366, 'COR006', 160213, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (233, 'SAL004', 160218, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (367, 'FIN001', 160218, 'Rejected', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (106, 'COR002', 160225, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (234, 'SAL003', 160225, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (368, 'FIN002', 160225, 'Registered', 'OnGoing');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (107, 'COR002', 160258, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (187, 'MGT007', 160258, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (235, 'SAL003', 160258, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (369, 'FIN003', 160258, 'Registered', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (108, 'COR002', 160282, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (188, 'MGT001', 160282, 'Waitlist', '');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (236, 'tch002', 160282, 'Registered', 'Completed');
INSERT INTO `is212g8t6`.`Registration` (`Reg_ID`, `Course_ID`, `Staff_ID`, `Reg_Status`, `Completion_Status`) VALUES (370, 'HRD001', 160282, 'Waitlist', '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `is212g8t6`.`Skill`
-- -----------------------------------------------------
START TRANSACTION;
USE `is212g8t6`;
INSERT INTO `is212g8t6`.`Skill` (`Skill_ID`, `Skill_Name`, `Skill_Des`, `Skill_Is_Active`) VALUES (1, 'C++ Programming', 'C++ Programming Description', 1);
INSERT INTO `is212g8t6`.`Skill` (`Skill_ID`, `Skill_Name`, `Skill_Des`, `Skill_Is_Active`) VALUES (2, 'Python Programming', 'Python Programming Description', 1);
INSERT INTO `is212g8t6`.`Skill` (`Skill_ID`, `Skill_Name`, `Skill_Des`, `Skill_Is_Active`) VALUES (3, 'Vue JS Framework', 'Vue JS Framework Description', 1);
INSERT INTO `is212g8t6`.`Skill` (`Skill_ID`, `Skill_Name`, `Skill_Des`, `Skill_Is_Active`) VALUES (4, 'React JS', 'React JS Description', 1);
INSERT INTO `is212g8t6`.`Skill` (`Skill_ID`, `Skill_Name`, `Skill_Des`, `Skill_Is_Active`) VALUES (5, 'Express JS', 'Express JS Description', 1);
INSERT INTO `is212g8t6`.`Skill` (`Skill_ID`, `Skill_Name`, `Skill_Des`, `Skill_Is_Active`) VALUES (6, 'Javascript', 'Javascript Description', 1);
INSERT INTO `is212g8t6`.`Skill` (`Skill_ID`, `Skill_Name`, `Skill_Des`, `Skill_Is_Active`) VALUES (7, 'Java', 'Java Description', 1);
INSERT INTO `is212g8t6`.`Skill` (`Skill_ID`, `Skill_Name`, `Skill_Des`, `Skill_Is_Active`) VALUES (8, 'Springboot', 'Springboot Description', 1);
INSERT INTO `is212g8t6`.`Skill` (`Skill_ID`, `Skill_Name`, `Skill_Des`, `Skill_Is_Active`) VALUES (9, 'Bootstrap', 'Bootstrap Description', 1);
INSERT INTO `is212g8t6`.`Skill` (`Skill_ID`, `Skill_Name`, `Skill_Des`, `Skill_Is_Active`) VALUES (10, 'Excel Basics 1', 'Excel Basics 1 Description', 1);
INSERT INTO `is212g8t6`.`Skill` (`Skill_ID`, `Skill_Name`, `Skill_Des`, `Skill_Is_Active`) VALUES (11, 'Excel Basics 2', 'Excel Basics 2 Description', 1);
INSERT INTO `is212g8t6`.`Skill` (`Skill_ID`, `Skill_Name`, `Skill_Des`, `Skill_Is_Active`) VALUES (12, 'Reason and Writing', 'Reason and Writing', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `is212g8t6`.`Learning_Journey`
-- -----------------------------------------------------
START TRANSACTION;
USE `is212g8t6`;
INSERT INTO `is212g8t6`.`Learning_Journey` (`LJ_ID`, `Staff_ID`, `Role_ID`, `has_start`) VALUES (1, 130001, 10021, 1);
INSERT INTO `is212g8t6`.`Learning_Journey` (`LJ_ID`, `Staff_ID`, `Role_ID`, `has_start`) VALUES (2, 130002, 10021, 1);
INSERT INTO `is212g8t6`.`Learning_Journey` (`LJ_ID`, `Staff_ID`, `Role_ID`, `has_start`) VALUES (3, 140001, 10023, 1);
INSERT INTO `is212g8t6`.`Learning_Journey` (`LJ_ID`, `Staff_ID`, `Role_ID`, `has_start`) VALUES (4, 140002, 10203, 1);
INSERT INTO `is212g8t6`.`Learning_Journey` (`LJ_ID`, `Staff_ID`, `Role_ID`, `has_start`) VALUES (5, 140002, 10024, 1);
INSERT INTO `is212g8t6`.`Learning_Journey` (`LJ_ID`, `Staff_ID`, `Role_ID`, `has_start`) VALUES (6, 140002, 10025, 1);
INSERT INTO `is212g8t6`.`Learning_Journey` (`LJ_ID`, `Staff_ID`, `Role_ID`, `has_start`) VALUES (7, 140004, 10021, 1);
INSERT INTO `is212g8t6`.`Learning_Journey` (`LJ_ID`, `Staff_ID`, `Role_ID`, `has_start`) VALUES (8, 140004, 10025, 1);
INSERT INTO `is212g8t6`.`Learning_Journey` (`LJ_ID`, `Staff_ID`, `Role_ID`, `has_start`) VALUES (9, 150065, 10025, 1);
INSERT INTO `is212g8t6`.`Learning_Journey` (`LJ_ID`, `Staff_ID`, `Role_ID`, `has_start`) VALUES (10, 150008, 10203, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `is212g8t6`.`Course_has_Skill`
-- -----------------------------------------------------
START TRANSACTION;
USE `is212g8t6`;
INSERT INTO `is212g8t6`.`Course_has_Skill` (`Course_has_Skill_ID`, `Course_ID`, `Skill_ID`) VALUES (1, 'MGT001', 10);
INSERT INTO `is212g8t6`.`Course_has_Skill` (`Course_has_Skill_ID`, `Course_ID`, `Skill_ID`) VALUES (2, 'MGT001', 11);
INSERT INTO `is212g8t6`.`Course_has_Skill` (`Course_has_Skill_ID`, `Course_ID`, `Skill_ID`) VALUES (3, 'tch003', 7);
INSERT INTO `is212g8t6`.`Course_has_Skill` (`Course_has_Skill_ID`, `Course_ID`, `Skill_ID`) VALUES (4, 'tch003', 8);
INSERT INTO `is212g8t6`.`Course_has_Skill` (`Course_has_Skill_ID`, `Course_ID`, `Skill_ID`) VALUES (5, 'COR001', 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `is212g8t6`.`Role_has_Skill`
-- -----------------------------------------------------
START TRANSACTION;
USE `is212g8t6`;
INSERT INTO `is212g8t6`.`Role_has_Skill` (`Role_has_Skill_ID`, `Role_ID`, `Skill_ID`) VALUES (201, 10203, 7);
INSERT INTO `is212g8t6`.`Role_has_Skill` (`Role_has_Skill_ID`, `Role_ID`, `Skill_ID`) VALUES (202, 10203, 7);
INSERT INTO `is212g8t6`.`Role_has_Skill` (`Role_has_Skill_ID`, `Role_ID`, `Skill_ID`) VALUES (203, 10502, 8);
INSERT INTO `is212g8t6`.`Role_has_Skill` (`Role_has_Skill_ID`, `Role_ID`, `Skill_ID`) VALUES (204, 10023, 10);
INSERT INTO `is212g8t6`.`Role_has_Skill` (`Role_has_Skill_ID`, `Role_ID`, `Skill_ID`) VALUES (205, 10023, 11);

COMMIT;

