-- MySQL Script generated by MySQL Workbench
-- Tue Jun 23 21:11:41 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_105408525
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `db_105408525` ;

-- -----------------------------------------------------
-- Schema db_105408525
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_105408525` DEFAULT CHARACTER SET utf8 ;
USE `db_105408525` ;

-- -----------------------------------------------------
-- Table `db_105408525`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_105408525`.`User` ;

CREATE TABLE IF NOT EXISTS `db_105408525`.`User` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `firstname` VARCHAR(100) NOT NULL,
  `lastname` VARCHAR(100) NOT NULL,
  `dob` DATETIME NOT NULL,
  `salt` CHAR(255) NOT NULL,
  `registerDateTime` DATETIME NOT NULL,
  `isDelete` INT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `User_id_UNIQUE` (`user_id` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `salt_UNIQUE` (`salt` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_105408525`.`UserCredential`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_105408525`.`UserCredential` ;

CREATE TABLE IF NOT EXISTS `db_105408525`.`UserCredential` (
  `userCredential` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `hashedPwd` CHAR(255) NOT NULL,
  `createDateTime` DATETIME NOT NULL,
  `isDelete` INT NULL,
  UNIQUE INDEX `HashedPwd_UNIQUE` (`hashedPwd` ASC),
  UNIQUE INDEX `User_id_UNIQUE` (`user_id` ASC),
  UNIQUE INDEX `userCredential_UNIQUE` (`userCredential` ASC),
  PRIMARY KEY (`userCredential`, `user_id`),
  CONSTRAINT `User_2_UserCredential_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `db_105408525`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_105408525`.`Seat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_105408525`.`Seat` ;

CREATE TABLE IF NOT EXISTS `db_105408525`.`Seat` (
  `seat_id` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`seat_id`),
  UNIQUE INDEX `Seat_id_UNIQUE` (`seat_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_105408525`.`Station`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_105408525`.`Station` ;

CREATE TABLE IF NOT EXISTS `db_105408525`.`Station` (
  `station_id` INT NOT NULL,
  `station_name` VARCHAR(100) NULL,
  `location_marker` INT NULL,
  `time_marker` INT NULL,
  PRIMARY KEY (`station_id`),
  UNIQUE INDEX `Station_id_UNIQUE` (`station_id` ASC),
  UNIQUE INDEX `station_name_UNIQUE` (`station_name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_105408525`.`Train`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_105408525`.`Train` ;

CREATE TABLE IF NOT EXISTS `db_105408525`.`Train` (
  `train_id` INT NOT NULL,
  `arrival_time` TIME NULL,
  `departure_time` TIME NULL,
  `departure_station` INT NOT NULL,
  `off_date` DATETIME NULL,
  `on_date` DATETIME NULL,
  PRIMARY KEY (`train_id`, `departure_station`),
  INDEX `train_2_station_idx` (`departure_station` ASC),
  CONSTRAINT `train_2_station`
    FOREIGN KEY (`departure_station`)
    REFERENCES `db_105408525`.`Station` (`station_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_105408525`.`Ticket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_105408525`.`Ticket` ;

CREATE TABLE IF NOT EXISTS `db_105408525`.`Ticket` (
  `ticket_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `train_date` DATETIME NULL,
  `train_id` INT NOT NULL,
  `departure_station` INT NOT NULL,
  `arrival_station` INT NOT NULL,
  `seat_id` VARCHAR(100) NOT NULL,
  `price` INT NOT NULL,
  `book_time` DATETIME NULL,
  `pay_time` DATETIME NULL,
  PRIMARY KEY (`ticket_id`, `user_id`, `seat_id`, `departure_station`, `train_id`, `arrival_station`),
  UNIQUE INDEX `ticket_id_UNIQUE` (`ticket_id` ASC),
  INDEX `ticket_2_user_userID_fk_idx` (`user_id` ASC),
  INDEX `ticket_2_seatid_fk_idx` (`seat_id` ASC),
  INDEX `departure_station_fk_idx` (`departure_station` ASC, `train_id` ASC),
  INDEX `arrival_station_fk_idx` (`arrival_station` ASC),
  CONSTRAINT `ticket_2_user_userID_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `db_105408525`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ticket_2_seatid_fk`
    FOREIGN KEY (`seat_id`)
    REFERENCES `db_105408525`.`Seat` (`seat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `departure_station_fk`
    FOREIGN KEY (`departure_station` , `train_id`)
    REFERENCES `db_105408525`.`Train` (`departure_station` , `train_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `arrival_station_fk`
    FOREIGN KEY (`arrival_station`)
    REFERENCES `db_105408525`.`Station` (`station_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
