-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour recipe_demo
CREATE DATABASE IF NOT EXISTS `recipe_demo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `recipe_demo`;

-- Listage de la structure de table recipe_demo. category
CREATE TABLE IF NOT EXISTS `category` (
  `id_category` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_category`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table recipe_demo.category : ~3 rows (environ)
INSERT INTO `category` (`id_category`, `category_name`) VALUES
	(1, 'Entrée'),
	(2, 'Plat'),
	(3, 'Dessert');

-- Listage de la structure de table recipe_demo. ingrediant
CREATE TABLE IF NOT EXISTS `ingrediant` (
  `id_ingrediant` int NOT NULL AUTO_INCREMENT,
  `ingrediant_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  `price` float NOT NULL,
  PRIMARY KEY (`id_ingrediant`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table recipe_demo.ingrediant : ~34 rows (environ)
INSERT INTO `ingrediant` (`id_ingrediant`, `ingrediant_name`, `price`) VALUES
	(1, 'Poulet', 3.5),
	(2, 'Salade', 1.5),
	(3, 'Crouton', 0.5),
	(4, 'Fromage', 1.2),
	(5, 'Sauce César', 1.4),
	(6, 'Tomate', 0.8),
	(7, 'Concombre', 1.2),
	(8, 'Olive', 0.7),
	(9, 'Huile d\'olive', 3.5),
	(10, 'Menthe', 1.7),
	(11, 'Lait de coco', 2),
	(12, 'Curry', 1.8),
	(13, 'Riz', 2.7),
	(14, 'Potiron', 1.2),
	(15, 'Carotte', 0.9),
	(16, 'Oignon', 1.3),
	(17, 'Crème fraîche', 2.1),
	(18, 'Bouillon de légume', 1.7),
	(19, 'Saumon', 2),
	(20, 'Avocat', 1.6),
	(21, 'Ciboulette', 0.4),
	(22, 'Citron', 1.1),
	(23, 'Pomme de terre', 1),
	(24, 'Asperge', 1.1),
	(25, 'Herbe de provence', 0.6),
	(26, 'Ail', 0.5),
	(27, 'Beurre', 1.4),
	(28, 'Mascarpone', 2.4),
	(29, 'Biscuit', 1.1),
	(30, 'Café', 0.5),
	(31, 'Oeuf', 1.2),
	(32, 'Sucre', 0.4),
	(33, 'Crème liquide', 1.2),
	(34, 'Vanille', 0.8);

-- Listage de la structure de table recipe_demo. recipe
CREATE TABLE IF NOT EXISTS `recipe` (
  `id_recipe` int NOT NULL AUTO_INCREMENT,
  `recipe_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `preparation_time` int NOT NULL DEFAULT '0',
  `instructions` text,
  `id_category` int NOT NULL,
  PRIMARY KEY (`id_recipe`),
  KEY `id_category` (`id_category`),
  CONSTRAINT `FK_recipe_category` FOREIGN KEY (`id_category`) REFERENCES `category` (`id_category`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table recipe_demo.recipe : ~10 rows (environ)
INSERT INTO `recipe` (`id_recipe`, `recipe_name`, `preparation_time`, `instructions`, `id_category`) VALUES
	(1, 'Salade César au Poulet', 35, NULL, 1),
	(2, 'Salade Méditerranéenne', 20, NULL, 2),
	(3, 'Poulet au curry', 30, NULL, 2),
	(4, 'Soupe de potiron', 40, NULL, 1),
	(5, 'Tartare de saumon', 15, NULL, 1),
	(6, 'Filets de saumon rôti', 30, NULL, 2),
	(7, 'Gratin dauphinois', 70, NULL, 2),
	(8, 'Poulet rôti aux légumes', 75, NULL, 2),
	(9, 'Tiramisu', 30, NULL, 3),
	(10, 'Crème brûlée', 45, NULL, 3);

-- Listage de la structure de table recipe_demo. recipe_ingredients
CREATE TABLE IF NOT EXISTS `recipe_ingredients` (
  `quantity` float NOT NULL,
  `unity` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  `id_ingredient` int DEFAULT NULL,
  `id_recipe` int DEFAULT NULL,
  KEY `id_ingredient` (`id_ingredient`),
  KEY `id_recipe` (`id_recipe`),
  CONSTRAINT `FK_recipe_ingredients_ingredient` FOREIGN KEY (`id_ingredient`) REFERENCES `ingrediant` (`id_ingrediant`),
  CONSTRAINT `FK_recipe_ingredients_recipe` FOREIGN KEY (`id_recipe`) REFERENCES `recipe` (`id_recipe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table recipe_demo.recipe_ingredients : ~49 rows (environ)
INSERT INTO `recipe_ingredients` (`quantity`, `unity`, `id_ingredient`, `id_recipe`) VALUES
	(300, 'g', 1, 1),
	(200, 'g', 2, 1),
	(50, 'g', 3, 1),
	(50, 'g', 4, 1),
	(100, 'ml', 5, 1),
	(400, 'g', 6, 2),
	(200, 'g', 7, 2),
	(100, 'g', 4, 2),
	(50, 'g', 8, 2),
	(30, 'ml', 9, 2),
	(10, 'g', 10, 2),
	(300, 'g', 1, 3),
	(200, 'ml', 11, 3),
	(20, 'g', 12, 3),
	(200, 'g', 13, 3),
	(500, 'g', 14, 4),
	(300, 'g', 15, 4),
	(100, 'g', 16, 4),
	(100, 'ml', 17, 4),
	(500, 'ml', 18, 4),
	(200, 'g', 19, 5),
	(100, 'g', 20, 5),
	(10, 'g', 21, 5),
	(50, 'g', 22, 5),
	(10, 'ml', 9, 5),
	(300, 'g', 19, 6),
	(400, 'g', 23, 6),
	(200, 'g', 24, 6),
	(50, 'g', 22, 6),
	(10, 'g', 25, 6),
	(600, 'g', 23, 7),
	(300, 'ml', 17, 7),
	(5, 'g', 26, 7),
	(40, 'g', 27, 7),
	(150, 'g', 4, 7),
	(1.5, 'kg', 1, 8),
	(600, 'g', 23, 8),
	(300, 'g', 15, 8),
	(150, 'g', 16, 8),
	(10, 'g', 25, 8),
	(250, 'g', 28, 9),
	(100, 'g', 29, 9),
	(100, 'ml', 30, 9),
	(150, 'g', 31, 9),
	(80, 'g', 32, 9),
	(500, 'ml', 33, 10),
	(90, 'g', 31, 10),
	(100, 'g', 32, 10),
	(5, 'g', 34, 10);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
recipe