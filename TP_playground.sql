-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(255) NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `categoria_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_ussuarios_categorias_idx` (`categoria_id` ASC) VISIBLE,
  CONSTRAINT `fk_ussuarios_categorias`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `mydb`.`categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cursos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `image` VARCHAR(45) NULL,
  `fecha_inicio` DATE NULL,
  `fecha _finalizacion` DATE NULL,
  `cupo` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`unidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`unidades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `fecha_inicio` DATE NULL,
  `curso_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_unidades_cursos_idx` (`curso_id` ASC) VISIBLE,
  CONSTRAINT `fk_unidades_cursos`
    FOREIGN KEY (`curso_id`)
    REFERENCES `mydb`.`cursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`inscripciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`inscripciones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `curso_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuarios_cursos_idx` (`usuario_id` ASC) VISIBLE,
  INDEX `fk_cursos_usuarios_idx` (`curso_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_cursos`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `mydb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cursos_usuarios`
    FOREIGN KEY (`curso_id`)
    REFERENCES `mydb`.`cursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`clases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`clases` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `fecha_inicio` DATE NULL,
  `visible` TINYINT NULL DEFAULT 0,
  `unidad_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_clases_unidades_idx` (`unidad_id` ASC) VISIBLE,
  CONSTRAINT `fk_clases_unidades`
    FOREIGN KEY (`unidad_id`)
    REFERENCES `mydb`.`unidades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`bloques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bloques` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NULL,
  `visible` TINYINT NULL,
  `contenido` VARCHAR(45) NULL,
  `tipo_id` INT NULL,
  `clase_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_bloques_tipos_idx` (`tipo_id` ASC) VISIBLE,
  INDEX `fk_bloques_clases_idx` (`clase_id` ASC) VISIBLE,
  CONSTRAINT `fk_bloques_tipos`
    FOREIGN KEY (`tipo_id`)
    REFERENCES `mydb`.`tipos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bloques_clases`
    FOREIGN KEY (`clase_id`)
    REFERENCES `mydb`.`clases` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
