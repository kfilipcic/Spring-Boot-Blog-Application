-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema blogdb2
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `blogdb2` ;

-- -----------------------------------------------------
-- Schema blogdb2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `blogdb2` DEFAULT CHARACTER SET utf8 ;
USE `blogdb2` ;

-- -----------------------------------------------------
-- Table `blogdb2`.`author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blogdb2`.`author` ;

CREATE TABLE IF NOT EXISTS `blogdb2`.`author` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `active` INT NULL DEFAULT NULL,
  `roles` VARCHAR(45) NULL DEFAULT NULL,
  `username` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 105
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `blogdb2`.`tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blogdb2`.`tag` ;

CREATE TABLE IF NOT EXISTS `blogdb2`.`tag` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 37
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `blogdb2`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blogdb2`.`post` ;

CREATE TABLE IF NOT EXISTS `blogdb2`.`post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `author_id` INT NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `content` VARCHAR(4096) NOT NULL,
  `date_created` DATE NOT NULL,
  `tag_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `author_id_idx` (`author_id` ASC) VISIBLE,
  INDEX `post_id_idx` (`tag_id` ASC) VISIBLE,
  CONSTRAINT `fk_post_author_id`
    FOREIGN KEY (`author_id`)
    REFERENCES `blogdb2`.`author` (`id`),
  CONSTRAINT `fk_post_tag_id`
    FOREIGN KEY (`tag_id`)
    REFERENCES `blogdb2`.`tag` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 43
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `blogdb2`.`comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `blogdb2`.`comment` ;

CREATE TABLE IF NOT EXISTS `blogdb2`.`comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `post_id` INT NOT NULL,
  `author_id` INT NOT NULL,
  `content` VARCHAR(256) NOT NULL,
  `date_created` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `post_id_idx` (`post_id` ASC) VISIBLE,
  INDEX `author_id_idx` (`author_id` ASC) VISIBLE,
  CONSTRAINT `fk_comment_author_id`
    FOREIGN KEY (`author_id`)
    REFERENCES `blogdb2`.`author` (`id`),
  CONSTRAINT `fk_comment_post_id`
    FOREIGN KEY (`post_id`)
    REFERENCES `blogdb2`.`post` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 57
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
