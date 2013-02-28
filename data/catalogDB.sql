SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `catalog` DEFAULT CHARACTER SET utf8 ;
USE `catalog` ;

-- -----------------------------------------------------
-- Table `catalog`.`faculties`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `catalog`.`faculties` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `faculty_name` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catalog`.`users`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `catalog`.`users` (
  `id` INT NULL AUTO_INCREMENT ,
  `login` VARCHAR(20) NULL ,
  `email` VARCHAR(50) NULL ,
  `quota` VARCHAR(45) NULL ,
  `rating` FLOAT NULL ,
  `moderator` ENUM('0','1') NULL ,
  `lastlogin` VARCHAR(10) NULL ,
  `faculties_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_users_faculties1` (`faculties_id` ASC) ,
  CONSTRAINT `fk_users_faculties1`
    FOREIGN KEY (`faculties_id` )
    REFERENCES `catalog`.`faculties` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catalog`.`files`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `catalog`.`files` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(50) NULL ,
  `real_name` VARCHAR(50) NULL ,
  `description` TEXT NULL ,
  `downloads` INT NULL ,
  `size` BIGINT NULL ,
  `type` INT NULL ,
  `created` VARCHAR(10) NULL ,
  `status` ENUM('0','1','2','3') NULL DEFAULT '0' COMMENT '0 - not checked\n1 - in process\n2 - checked, need a little work\n3 - file is perfect' ,
  `updated` VARCHAR(10) NULL ,
  `author_created` INT NULL ,
  `permission` ENUM('0','1','2') NULL DEFAULT '1' COMMENT '0-my,\n1-loggined\n2-all' ,
  PRIMARY KEY (`id`) ,
  INDEX `to_user` (`author_created` ASC) ,
  CONSTRAINT `to_user_ff`
    FOREIGN KEY (`author_created` )
    REFERENCES `catalog`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catalog`.`tags`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `catalog`.`tags` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name_en` VARCHAR(45) NULL ,
  `name_visible` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catalog`.`files_to_tags`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `catalog`.`files_to_tags` (
  `file_id` INT NOT NULL ,
  `tag_id` INT NOT NULL ,
  PRIMARY KEY (`file_id`, `tag_id`) ,
  INDEX `to_file` (`file_id` ASC) ,
  INDEX `to_tag` (`tag_id` ASC) ,
  CONSTRAINT `to_file`
    FOREIGN KEY (`file_id` )
    REFERENCES `catalog`.`files` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `to_tag`
    FOREIGN KEY (`tag_id` )
    REFERENCES `catalog`.`tags` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catalog`.`types`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `catalog`.`types` (
  `id` INT NOT NULL ,
  `extension` VARCHAR(5) NULL ,
  `mimetype` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catalog`.`courses`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `catalog`.`courses` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `faculties_id` INT NULL ,
  `course_name` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_courses_faculties1_idx` (`faculties_id` ASC) ,
  CONSTRAINT `fk_courses_faculties1`
    FOREIGN KEY (`faculties_id` )
    REFERENCES `catalog`.`faculties` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catalog`.`files_to_courses`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `catalog`.`files_to_courses` (
  `file_id` INT NOT NULL ,
  `course_id` INT NOT NULL ,
  PRIMARY KEY (`file_id`, `course_id`) ,
  INDEX `to_file` (`file_id` ASC) ,
  INDEX `to_course` (`course_id` ASC) ,
  CONSTRAINT `to_file_fcr`
    FOREIGN KEY (`file_id` )
    REFERENCES `catalog`.`files` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `to_course`
    FOREIGN KEY (`course_id` )
    REFERENCES `catalog`.`courses` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catalog`.`votes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `catalog`.`votes` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user_id` INT NULL ,
  `vote` ENUM('1','-1') NULL ,
  `created` VARCHAR(45) NULL ,
  `file_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `to_user` (`user_id` ASC) ,
  INDEX `to_file` (`id` ASC) ,
  CONSTRAINT `to_user_fv`
    FOREIGN KEY (`user_id` )
    REFERENCES `catalog`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `to_file_fv`
    FOREIGN KEY (`id` )
    REFERENCES `catalog`.`files` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catalog`.`comments`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `catalog`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `author_created` INT NULL ,
  `created` VARCHAR(10) NULL ,
  `updated` VARCHAR(10) NULL ,
  `comment` TEXT NULL ,
  `file_id` INT NULL ,
  `parent_id` INT NULL DEFAULT 0 ,
  `author_ip` VARCHAR(20) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `to_user` (`author_created` ASC) ,
  INDEX `to_file` (`file_id` ASC) ,
  CONSTRAINT `to_user_fc`
    FOREIGN KEY (`author_created` )
    REFERENCES `catalog`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `to_file_fc`
    FOREIGN KEY (`file_id` )
    REFERENCES `catalog`.`files` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catalog`.`favorites`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `catalog`.`favorites` (
  `user_id` INT NOT NULL ,
  `file_id` INT NOT NULL ,
  INDEX `fk_favorites_users1` (`user_id` ASC) ,
  INDEX `fk_favorites_files1` (`file_id` ASC) ,
  PRIMARY KEY (`user_id`, `file_id`) ,
  CONSTRAINT `fk_favorites_users1`
    FOREIGN KEY (`user_id` )
    REFERENCES `catalog`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favorites_files1`
    FOREIGN KEY (`file_id` )
    REFERENCES `catalog`.`files` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
