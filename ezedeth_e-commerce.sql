-- crear una nueva base de datos
CREATE SCHEMA `ezedeth`;

-- colocar en uso la base de datos `ezedeth`
USE `ezedeth`;

-- crear la tabla de productos
CREATE TABLE `ezedeth`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `price` INT NOT NULL,
  `discount` INT NULL DEFAULT 0,
  `image` VARCHAR(255) NULL,
  PRIMARY KEY (`id`));
  
  -- crear la tabla de usuarios
  CREATE TABLE `ezedeth`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `suername` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `image` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE);

-- crear la tabla categorias
CREATE TABLE `ezedeth`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `image` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));
  
-- añadir la columna donde se va a crear la clave foranea
ALTER TABLE `ezedeth`.`products` 
ADD COLUMN `category_id` INT NULL AFTER `image`;

-- crear la clave foranea que vincula productos con categorias
ALTER TABLE `ezedeth`.`products` 
ADD INDEX `fk_products_categories_idx` (`category_id` ASC) VISIBLE;
ALTER TABLE `ezedeth`.`products` 
ADD CONSTRAINT `fk_products_categories`
  FOREIGN KEY (`category_id`)
  REFERENCES `ezedeth`.`categories` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- crear tabla de roles 
CREATE TABLE `ezedeth`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));
  
-- crear tabla de roles para usuarios
ALTER TABLE `ezedeth`.`users` 
ADD COLUMN `rol_id` INT NULL AFTER `image`;

-- crear la clave foranea que vincula usuarios con roles 
ALTER TABLE `ezedeth`.`users` 
ADD INDEX `fk_users_roles_idx` (`rol_id` ASC) VISIBLE;
ALTER TABLE `ezedeth`.`users` 
ADD CONSTRAINT `fk_users_roles`
  FOREIGN KEY (`rol_id`)
  REFERENCES `ezedeth`.`roles` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- crear la tabla carrito
CREATE TABLE `ezedeth`.`cart` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `cuantity` INT NULL DEFAULT 1,
  PRIMARY KEY (`id`));

-- crear las claves foraneas que vinculan productos con usuarios y viceversa
ALTER TABLE `ezedeth`.`cart` 
ADD INDEX `fk_users_products_idx` (`user_id` ASC) VISIBLE,
ADD INDEX `fk_products_users_idx` (`product_id` ASC) VISIBLE;
ALTER TABLE `ezedeth`.`cart` 
ADD CONSTRAINT `fk_users_products`
  FOREIGN KEY (`user_id`)
  REFERENCES `ezedeth`.`users` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_products_users`
  FOREIGN KEY (`product_id`)
  REFERENCES `ezedeth`.`products` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;






