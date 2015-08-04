SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `TALONDB` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `TALONDB` ;

-- -----------------------------------------------------
-- Table `TALONDB`.`AUTHORITIES`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`AUTHORITIES` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `AUTHORITY` VARCHAR(50) NOT NULL ,
  `ENABLED` TINYINT NOT NULL DEFAULT 0 ,
  `API_URL` VARCHAR(255) NOT NULL ,
  `API__AUTH_TOKEN` VARCHAR(255) NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`USERS`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`USERS` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `UUID` CHAR(36) NOT NULL ,
  `USER_NAME` VARCHAR(75) NOT NULL ,
  `ENABLED` TINYINT NOT NULL DEFAULT 0 ,
  `CRE_USER_ID` INT NULL ,
  `CRE_DTM` DATETIME NOT NULL ,
  `AUTHORITIES_ID` INT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_USERS_AUTHORITIES1_idx` (`AUTHORITIES_ID` ASC) ,
  UNIQUE INDEX `UUID_UNIQUE` (`UUID` ASC) ,
  CONSTRAINT `fk_USERS_AUTHORITIES1`
    FOREIGN KEY (`AUTHORITIES_ID` )
    REFERENCES `TALONDB`.`AUTHORITIES` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`ROLE_AUTH`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`ROLE_AUTH` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `ROLE` VARCHAR(45) NOT NULL ,
  `ENABLED` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`CUSTOMER`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`CUSTOMER` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `UUID` CHAR(36) NOT NULL ,
  `CUST_NAME` VARCHAR(45) NOT NULL ,
  `ENABLED` TINYINT NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`ID`) ,
  UNIQUE INDEX `UUID_UNIQUE` (`UUID` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`GROUPS`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`GROUPS` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `UUID` CHAR(36) NOT NULL ,
  `GROUP_NAME` VARCHAR(50) NOT NULL ,
  `CUST_UUID` CHAR(36) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  UNIQUE INDEX `UUID_UNIQUE` (`UUID` ASC) ,
  INDEX `fk_CustUUId2_idx` (`CUST_UUID` ASC) ,
  CONSTRAINT `fk_CustUUId2`
    FOREIGN KEY (`CUST_UUID` )
    REFERENCES `TALONDB`.`CUSTOMER` (`UUID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`GROUP_MEMBERS`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`GROUP_MEMBERS` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `GROUPS_ID` INT NOT NULL ,
  `USERS_ID` INT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_group_members_groups1_idx` (`GROUPS_ID` ASC) ,
  INDEX `fk_group_members_users1_idx` (`USERS_ID` ASC) ,
  CONSTRAINT `fk_group_members_groups1`
    FOREIGN KEY (`GROUPS_ID` )
    REFERENCES `TALONDB`.`GROUPS` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_members_users1`
    FOREIGN KEY (`USERS_ID` )
    REFERENCES `TALONDB`.`USERS` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`ETL_JOB`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`ETL_JOB` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `JOB_NAME` VARCHAR(75) NOT NULL ,
  `CRE_DTM` DATETIME NOT NULL ,
  `ENABLED` TINYINT NOT NULL DEFAULT 0 ,
  `CUST_UUID` CHAR(36) NOT NULL ,
  `CRE_USER_UUID` CHAR(36) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  UNIQUE INDEX `JOB_NAME_UNIQUE` (`JOB_NAME` ASC) ,
  UNIQUE INDEX `UDX1` (`JOB_NAME` ASC, `CUST_UUID` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`ETL_CONFIG_KEYS`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`ETL_CONFIG_KEYS` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `KEY` VARCHAR(75) NOT NULL ,
  `VALUE` TEXT NOT NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`ETL_JOB_CONFIG_MAP`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`ETL_JOB_CONFIG_MAP` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `ETL_JOB_ID` INT NOT NULL ,
  `ETL_JOB_CONFIG_ID` INT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_ETL_JOB_PROP_MAP_ETL_JOB1_idx` (`ETL_JOB_ID` ASC) ,
  INDEX `fk_ETL_JOB_PROP_MAP_ETL_JOB_PROPERTIES1_idx` (`ETL_JOB_CONFIG_ID` ASC) ,
  CONSTRAINT `fk_ETL_JOB_PROP_MAP_ETL_JOB1`
    FOREIGN KEY (`ETL_JOB_ID` )
    REFERENCES `TALONDB`.`ETL_JOB` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ETL_JOB_PROP_MAP_ETL_JOB_PROPERTIES1`
    FOREIGN KEY (`ETL_JOB_CONFIG_ID` )
    REFERENCES `TALONDB`.`ETL_CONFIG_KEYS` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`ETL_JOB_SCHEDULE`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`ETL_JOB_SCHEDULE` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `RUN_DAY` VARCHAR(2) NOT NULL ,
  `RUN_HOUR` VARCHAR(2) NOT NULL ,
  `RUN_MIN` VARCHAR(2) NOT NULL ,
  `ENABLED` TINYINT NOT NULL DEFAULT false ,
  `CRE_DTM` DATETIME NULL ,
  `CRE_USER` INT NULL ,
  `ETL_JOB_ID` INT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_ETL_JOB_SCHEDULE_ETL_JOB1_idx` (`ETL_JOB_ID` ASC) ,
  CONSTRAINT `fk_ETL_JOB_SCHEDULE_ETL_JOB1`
    FOREIGN KEY (`ETL_JOB_ID` )
    REFERENCES `TALONDB`.`ETL_JOB` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`JOB_SERVER`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`JOB_SERVER` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `HOST` VARCHAR(75) NOT NULL ,
  `ACTIVE` TINYINT(1) NOT NULL DEFAULT false ,
  `IP_ADDRESS` VARCHAR(20) NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`JOB_STATUS`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`JOB_STATUS` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `STATUS` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`ETL_JOB_QUEUE`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`ETL_JOB_QUEUE` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `RUN_DTM` DATETIME NOT NULL ,
  `END_DTM` DATETIME NOT NULL ,
  `RUNNING` TINYINT NOT NULL DEFAULT 0 ,
  `ASSIGNED` TINYINT NOT NULL DEFAULT 0 ,
  `COMPLETE` TINYINT NOT NULL DEFAULT 0 ,
  `JOB_SERVER_ID` INT NOT NULL ,
  `ETL_JOB_ID` INT NOT NULL ,
  `JOB_STATUS_ID` INT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_ETL_JOB_QUEUE_JOB_SERVER1_idx` (`JOB_SERVER_ID` ASC) ,
  INDEX `fk_ETL_JOB_QUEUE_ETL_JOB1_idx` (`ETL_JOB_ID` ASC) ,
  INDEX `fk_ETL_JOB_QUEUE_STATUS1_idx` (`JOB_STATUS_ID` ASC) ,
  CONSTRAINT `fk_ETL_JOB_QUEUE_JOB_SERVER1`
    FOREIGN KEY (`JOB_SERVER_ID` )
    REFERENCES `TALONDB`.`JOB_SERVER` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ETL_JOB_QUEUE_ETL_JOB1`
    FOREIGN KEY (`ETL_JOB_ID` )
    REFERENCES `TALONDB`.`ETL_JOB` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ETL_JOB_QUEUE_STATUS1`
    FOREIGN KEY (`JOB_STATUS_ID` )
    REFERENCES `TALONDB`.`JOB_STATUS` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`DATA_SOURCE`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`DATA_SOURCE` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `NAME` VARCHAR(45) NOT NULL ,
  `CUST_UUID` CHAR(36) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_custUUid_idx` (`CUST_UUID` ASC) ,
  CONSTRAINT `fk_custUUid`
    FOREIGN KEY (`CUST_UUID` )
    REFERENCES `TALONDB`.`CUSTOMER` (`UUID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`STATE_CITY`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`STATE_CITY` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `STATE` VARCHAR(45) NOT NULL ,
  `CITY` VARCHAR(45) NOT NULL ,
  `SUMMARY` TEXT NULL ,
  `IMAGE_URL` VARCHAR(150) NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`ZIP_CODES`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`ZIP_CODES` (
  `ZIP_CODE` INT NOT NULL ,
  `STATE_CITY_ID` INT NOT NULL ,
  PRIMARY KEY (`ZIP_CODE`) ,
  INDEX `fk_ZIP_CODES_STATE_CITY1_idx` (`STATE_CITY_ID` ASC) ,
  CONSTRAINT `fk_ZIP_CODES_STATE_CITY1`
    FOREIGN KEY (`STATE_CITY_ID` )
    REFERENCES `TALONDB`.`STATE_CITY` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`PROPERTY_DATA`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`PROPERTY_DATA` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `UUID` CHAR(36) NOT NULL ,
  `PROP_NAME` VARCHAR(150) NOT NULL ,
  `PRICE` FLOAT NOT NULL DEFAULT 0 ,
  `SQFT` VARCHAR(45) NOT NULL ,
  `DESCRIPTION` TEXT NOT NULL ,
  `NUM_BEDS` FLOAT NOT NULL DEFAULT 0 ,
  `NUM_BATHS` FLOAT NOT NULL DEFAULT 0 ,
  `TYPE` VARCHAR(45) NOT NULL ,
  `STATUS` VARCHAR(45) NOT NULL ,
  `DATA_SOURCE_ID` INT NOT NULL ,
  `ZIP_CODE` INT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  UNIQUE INDEX `UUID_UNIQUE` (`UUID` ASC) ,
  INDEX `fk_PROPERTY_DATA_DATA_SOURCE1_idx` (`DATA_SOURCE_ID` ASC) ,
  INDEX `fk_PROPERTY_DATA_ZIP_CODES1_idx` (`ZIP_CODE` ASC) ,
  CONSTRAINT `fk_PROPERTY_DATA_DATA_SOURCE1`
    FOREIGN KEY (`DATA_SOURCE_ID` )
    REFERENCES `TALONDB`.`DATA_SOURCE` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROPERTY_DATA_ZIP_CODES1`
    FOREIGN KEY (`ZIP_CODE` )
    REFERENCES `TALONDB`.`ZIP_CODES` (`ZIP_CODE` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`RAW_DATA`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`RAW_DATA` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `DATA_VALUE` TEXT NOT NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`DATA_TYPE`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`DATA_TYPE` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `NAME` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`CUSTOM_DATA`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`CUSTOM_DATA` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `NAME` VARCHAR(75) NOT NULL ,
  `VALUE_PREFIX` VARCHAR(255) NOT NULL ,
  `SORT_ORDER` INT NOT NULL DEFAULT 0 ,
  `RAW_DATA_ID` INT NULL ,
  `DATA_TYPE_ID` INT NOT NULL ,
  `PROPERTY_DATA_UUID` CHAR(36) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_DYNAMIC_DATA_RAW_DATA1_idx` (`RAW_DATA_ID` ASC) ,
  INDEX `fk_DYNAMIC_DATA_DATA_TYPE1_idx` (`DATA_TYPE_ID` ASC) ,
  INDEX `fk_CUSTOM_DATA_PROPERTY_DATA1_idx` (`PROPERTY_DATA_UUID` ASC) ,
  UNIQUE INDEX `PROPERTY_DATA_UUID_UNIQUE` (`PROPERTY_DATA_UUID` ASC) ,
  CONSTRAINT `fk_DYNAMIC_DATA_RAW_DATA1`
    FOREIGN KEY (`RAW_DATA_ID` )
    REFERENCES `TALONDB`.`RAW_DATA` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DYNAMIC_DATA_DATA_TYPE1`
    FOREIGN KEY (`DATA_TYPE_ID` )
    REFERENCES `TALONDB`.`DATA_TYPE` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CUSTOM_DATA_PROPERTY_DATA1`
    FOREIGN KEY (`PROPERTY_DATA_UUID` )
    REFERENCES `TALONDB`.`PROPERTY_DATA` (`UUID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`PROPERTY_IMAGES`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`PROPERTY_IMAGES` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `TITLE` VARCHAR(155) NOT NULL ,
  `TYPE` VARCHAR(45) NOT NULL DEFAULT 'header' ,
  `SIZE` INT NOT NULL DEFAULT 0 ,
  `SRC_URL` VARCHAR(150) NOT NULL ,
  `PROPERTY_DATA_ID` INT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_PROPERTY_IMAGES_PROPERTY_DATA1_idx` (`PROPERTY_DATA_ID` ASC) ,
  CONSTRAINT `fk_PROPERTY_IMAGES_PROPERTY_DATA1`
    FOREIGN KEY (`PROPERTY_DATA_ID` )
    REFERENCES `TALONDB`.`PROPERTY_DATA` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`CUSTOMER_CUSTOM_DATA_SET`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`CUSTOMER_CUSTOM_DATA_SET` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `DATA_SET_NAME` VARCHAR(45) NOT NULL ,
  `CUSTOMER_ID` INT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_CUSTOMER_DS_CUSTOMER1_idx` (`CUSTOMER_ID` ASC) ,
  CONSTRAINT `fk_CUSTOMER_DS_CUSTOMER1`
    FOREIGN KEY (`CUSTOMER_ID` )
    REFERENCES `TALONDB`.`CUSTOMER` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`DATA_SET_DATA`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`DATA_SET_DATA` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `FIELD_NAME` VARCHAR(75) NOT NULL ,
  `VALUE_PREFIX` VARCHAR(255) NOT NULL ,
  `SORT_ORDER` INT NOT NULL ,
  `DATA_TYPE_ID` INT NOT NULL ,
  `CUSTOMER_DS_ID` INT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_DS_DATA_DATA_TYPE1_idx` (`DATA_TYPE_ID` ASC) ,
  INDEX `fk_DS_DATA_CUSTOMER_DS1_idx` (`CUSTOMER_DS_ID` ASC) ,
  CONSTRAINT `fk_DS_DATA_DATA_TYPE1`
    FOREIGN KEY (`DATA_TYPE_ID` )
    REFERENCES `TALONDB`.`DATA_TYPE` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DS_DATA_CUSTOMER_DS1`
    FOREIGN KEY (`CUSTOMER_DS_ID` )
    REFERENCES `TALONDB`.`CUSTOMER_CUSTOM_DATA_SET` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`FINACIAL_KEY`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`FINACIAL_KEY` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `KEY` VARCHAR(75) NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`PROPERTY_FINACIAL`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`PROPERTY_FINACIAL` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `VALUE` DECIMAL(5,2) NOT NULL DEFAULT 0.0 ,
  `FINACIAL_KEY_ID` INT NOT NULL ,
  `PROPERTY_DATA_UUID` CHAR(36) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_PROPERTY_FINACIALS_FINACIAL_KEY1_idx` (`FINACIAL_KEY_ID` ASC) ,
  INDEX `fk_PROPERTY_FINACIALS_PROPERTY_DATA1_idx` (`PROPERTY_DATA_UUID` ASC) ,
  UNIQUE INDEX `udx1` (`FINACIAL_KEY_ID` ASC, `PROPERTY_DATA_UUID` ASC) ,
  CONSTRAINT `fk_PROPERTY_FINACIALS_FINACIAL_KEY1`
    FOREIGN KEY (`FINACIAL_KEY_ID` )
    REFERENCES `TALONDB`.`FINACIAL_KEY` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROPERTY_FINACIALS_PROPERTY_DATA1`
    FOREIGN KEY (`PROPERTY_DATA_UUID` )
    REFERENCES `TALONDB`.`PROPERTY_DATA` (`UUID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`PROPERTY_FINACIAL`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`PROPERTY_FINACIAL` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `VALUE` DECIMAL(5,2) NOT NULL DEFAULT 0.0 ,
  `FINACIAL_KEY_ID` INT NOT NULL ,
  `PROPERTY_DATA_UUID` CHAR(36) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_PROPERTY_FINACIALS_FINACIAL_KEY1_idx` (`FINACIAL_KEY_ID` ASC) ,
  INDEX `fk_PROPERTY_FINACIALS_PROPERTY_DATA1_idx` (`PROPERTY_DATA_UUID` ASC) ,
  UNIQUE INDEX `udx1` (`FINACIAL_KEY_ID` ASC, `PROPERTY_DATA_UUID` ASC) ,
  CONSTRAINT `fk_PROPERTY_FINACIALS_FINACIAL_KEY1`
    FOREIGN KEY (`FINACIAL_KEY_ID` )
    REFERENCES `TALONDB`.`FINACIAL_KEY` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROPERTY_FINACIALS_PROPERTY_DATA1`
    FOREIGN KEY (`PROPERTY_DATA_UUID` )
    REFERENCES `TALONDB`.`PROPERTY_DATA` (`UUID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`ETL_JOB_LOG`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`ETL_JOB_LOG` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `LOG` VARCHAR(255) NOT NULL ,
  `CRE_DTM` DATETIME NOT NULL ,
  `ETL_JOB_QUEUE_ID` INT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_ETL_JOB_LOG_ETL_JOB_QUEUE1_idx` (`ETL_JOB_QUEUE_ID` ASC) ,
  CONSTRAINT `fk_ETL_JOB_LOG_ETL_JOB_QUEUE1`
    FOREIGN KEY (`ETL_JOB_QUEUE_ID` )
    REFERENCES `TALONDB`.`ETL_JOB_QUEUE` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`SYSTEM_ROLES`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`SYSTEM_ROLES` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `ROLE` VARCHAR(45) NULL ,
  `ENABLED` TINYINT NOT NULL DEFAULT 0 ,
  `CRE_USER_ID` INT NULL ,
  `CRE_DTM` DATETIME NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TALONDB`.`GROUP_ROLE_MAP`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `TALONDB`.`GROUP_ROLE_MAP` (
  `SYSTEM_ROLES_ID` INT NOT NULL ,
  `GROUPS_ID` INT NOT NULL ,
  INDEX `fk_GROUP_ROLE_MAP_SYSTEM_ROLES1_idx` (`SYSTEM_ROLES_ID` ASC) ,
  INDEX `fk_GROUP_ROLE_MAP_GROUPS1_idx` (`GROUPS_ID` ASC) ,
  CONSTRAINT `fk_GROUP_ROLE_MAP_SYSTEM_ROLES1`
    FOREIGN KEY (`SYSTEM_ROLES_ID` )
    REFERENCES `TALONDB`.`SYSTEM_ROLES` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GROUP_ROLE_MAP_GROUPS1`
    FOREIGN KEY (`GROUPS_ID` )
    REFERENCES `TALONDB`.`GROUPS` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `TALONDB` ;

-- -----------------------------------------------------
-- Placeholder table for view `TALONDB`.`vw_PropertyFinacials`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TALONDB`.`vw_PropertyFinacials` (`ID` INT, `PF_VALUE` INT, `FINACIAL_KEY_ID` INT, `PROPERTY_DATA_UUID` INT, `KEY_ID` INT, `PF_KEY` INT);

-- -----------------------------------------------------
-- Placeholder table for view `TALONDB`.`vw_PropertyFeed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TALONDB`.`vw_PropertyFeed` (`ID` INT, `UUID` INT, `PROP_NAME` INT, `PRICE` INT, `SQFT` INT, `DESCRIPTION` INT, `NUM_BEDS` INT, `NUM_BATHS` INT, `TYPE` INT, `STATUS` INT, `DATA_SOURCE_ID` INT, `CUST_UUID` INT, `DATASOURCE` INT, `STATE` INT, `CITY` INT, `ZIP` INT);

-- -----------------------------------------------------
-- Placeholder table for view `TALONDB`.`vw_CustomerDataSource`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TALONDB`.`vw_CustomerDataSource` (`CUSTOMER_ID` INT, `CUSTOMER_NAME` INT, `ENABLED` INT, `DATA_SOURCE_ID` INT, `DATASOURCE` INT);

-- -----------------------------------------------------
-- Placeholder table for view `TALONDB`.`vw_Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TALONDB`.`vw_Customers` (`ID` INT, `UUID` INT, `CUST_NAME` INT, `ENABLED` INT);

-- -----------------------------------------------------
-- Placeholder table for view `TALONDB`.`vw_propertyImages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TALONDB`.`vw_propertyImages` (`ID` INT, `TITLE` INT, `URL` INT, `PROPERTY_DATA_ID` INT);

-- -----------------------------------------------------
-- Placeholder table for view `TALONDB`.`vw_propertyImages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TALONDB`.`vw_propertyImages` (`ID` INT, `TITLE` INT, `TYPE` INT, `URL` INT, `PROPERTY_DATA_ID` INT);

-- -----------------------------------------------------
-- Placeholder table for view `TALONDB`.`vw_stateCityInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TALONDB`.`vw_stateCityInfo` (`ID` INT, `STATE` INT, `CITY` INT, `SUMMARY` INT, `IMAGE_URL` INT, `ZIP_CODE` INT);

-- -----------------------------------------------------
-- procedure pr_GetPropertyImageData
-- -----------------------------------------------------

DELIMITER $$
USE `TALONDB`$$
CREATE DEFINER=`root`@`%` PROCEDURE `pr_GetPropertyImageData`(IN PropertyDataId INT)
BEGIN
	
	
	/*SELECT propertyUUId = UUID FROM `TALONDB`.`PROPERTY_DATA` WHERE UUID = propertyUUId; */

	SELECT * FROM `TALONDB`.`vw_propertyImages` WHERE PROPERTY_DATA_ID = PropertyDataId;
	
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `TALONDB`.`vw_PropertyFinacials`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TALONDB`.`vw_PropertyFinacials`;
USE `TALONDB`;
CREATE  OR REPLACE VIEW `TALONDB`.`vw_PropertyFinacials` AS
select 
        `pf`.`ID` AS `ID`,
        `pf`.`VALUE` AS `PF_VALUE`,
        `pf`.`FINACIAL_KEY_ID` AS `FINACIAL_KEY_ID`,
        `pf`.`PROPERTY_DATA_UUID` AS `PROPERTY_DATA_UUID`,
        `fk`.`ID` AS `KEY_ID`,
        `fk`.`KEY` AS `PF_KEY`
    from
        (`TALONDB`.`PROPERTY_FINACIAL` `pf`
        join `TALONDB`.`FINACIAL_KEY` `fk`)
    where
        (`pf`.`FINACIAL_KEY_ID` = `fk`.`ID`)
;

-- -----------------------------------------------------
-- View `TALONDB`.`vw_PropertyFeed`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TALONDB`.`vw_PropertyFeed`;
USE `TALONDB`;
CREATE  OR REPLACE VIEW `TALONDB`.`vw_PropertyFeed` AS
select 
        `p`.`ID` AS `ID`,
        `p`.`UUID` AS `UUID`,
        `p`.`PROP_NAME` AS `PROP_NAME`,
        `p`.`PRICE` AS `PRICE`,
        `p`.`SQFT` AS `SQFT`,
        `p`.`DESCRIPTION` AS `DESCRIPTION`,
        `p`.`NUM_BEDS` AS `NUM_BEDS`,
        `p`.`NUM_BATHS` AS `NUM_BATHS`,
        `p`.`TYPE` AS `TYPE`,
        `p`.`STATUS` AS `STATUS`,
        `p`.`DATA_SOURCE_ID` AS `DATA_SOURCE_ID`,
        `d`.`CUST_UUID` AS `CUST_UUID`,
        `d`.`NAME` AS `DATASOURCE`,
        `s`.`STATE` AS `STATE`,
        `s`.`CITY` AS `CITY`,
        `s`.`ZIP_CODE` AS `ZIP`
    from
        ((`TALONDB`.`PROPERTY_DATA` `p`
        join `TALONDB`.`DATA_SOURCE` `d`)
        join `TALONDB`.`vw_stateCityInfo` `s`)
    where
        ((`p`.`DATA_SOURCE_ID` = `d`.`ID`)
            and (`p`.`ZIP_CODE` = `s`.`ZIP_CODE`))
;

-- -----------------------------------------------------
-- View `TALONDB`.`vw_CustomerDataSource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TALONDB`.`vw_CustomerDataSource`;
USE `TALONDB`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `TALONDB`.`vw_CustomerDataSource` AS select `c`.`ID` AS `CUSTOMER_ID`,`c`.`CUST_NAME` AS `CUSTOMER_NAME`,`c`.`ENABLED` AS `ENABLED`,`ds`.`ID` AS `DATA_SOURCE_ID`,`ds`.`NAME` AS `DATASOURCE` from (`TALONDB`.`vw_Customers` `c` join `TALONDB`.`DATA_SOURCE` `ds`) where (`c`.`UUID` = `ds`.`CUST_UUID`);

-- -----------------------------------------------------
-- View `TALONDB`.`vw_Customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TALONDB`.`vw_Customers`;
USE `TALONDB`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `vw_Customers` AS
    select 
        `CUSTOMER`.`ID` AS `ID`,
        `CUSTOMER`.`UUID` AS `UUID`,
        `CUSTOMER`.`CUST_NAME` AS `CUST_NAME`,
        `CUSTOMER`.`ENABLED` AS `ENABLED`
    from
        `CUSTOMER`
;

-- -----------------------------------------------------
-- View `TALONDB`.`vw_propertyImages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TALONDB`.`vw_propertyImages`;
USE `TALONDB`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `vw_propertyImages` AS
    select 
        `i`.`ID` AS `ID`,
        `i`.`TITLE` AS `TITLE`,
        `i`.`TYPE` AS `TYPE`,
        `i`.`SRC_URL` AS `URL`,
        `i`.`PROPERTY_DATA_ID` AS `PROPERTY_DATA_ID`
    from
        `PROPERTY_IMAGES` `i`
;

-- -----------------------------------------------------
-- View `TALONDB`.`vw_propertyImages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TALONDB`.`vw_propertyImages`;
USE `TALONDB`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `vw_propertyImages` AS
    select 
        `i`.`ID` AS `ID`,
        `i`.`TITLE` AS `TITLE`,
        `i`.`TYPE` AS `TYPE`,
        `i`.`SRC_URL` AS `URL`,
        `i`.`PROPERTY_DATA_ID` AS `PROPERTY_DATA_ID`
    from
        `PROPERTY_IMAGES` `i`
;

-- -----------------------------------------------------
-- View `TALONDB`.`vw_stateCityInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TALONDB`.`vw_stateCityInfo`;
USE `TALONDB`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `vw_stateCityInfo` AS
    select 
        `sc`.`ID` AS `ID`,
        `sc`.`STATE` AS `STATE`,
        `sc`.`CITY` AS `CITY`,
        `sc`.`SUMMARY` AS `SUMMARY`,
        `sc`.`IMAGE_URL` AS `IMAGE_URL`,
        `z`.`ZIP_CODE` AS `ZIP_CODE`
    from
        (`STATE_CITY` `sc`
        join `ZIP_CODES` `z`)
    where
        (`sc`.`ID` = `z`.`STATE_CITY_ID`);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
