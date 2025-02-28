-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.30 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Volcando estructura para tabla agentechatgpt.chats
CREATE TABLE IF NOT EXISTS `chats` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `whatsapp_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `chats_whatsapp_number_unique` (`whatsapp_number`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla agentechatgpt.chats: ~1 rows (aproximadamente)
DELETE FROM `chats`;
INSERT INTO `chats` (`id`, `name`, `whatsapp_number`, `created_at`, `updated_at`) VALUES
	(1, 'AnderCode Pruebas', '51999999999', '2025-02-28 20:50:03', '2025-02-28 20:50:03');

-- Volcando estructura para tabla agentechatgpt.chat_messages
CREATE TABLE IF NOT EXISTS `chat_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `chat_id` bigint unsigned NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender` enum('user','agent') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chat_messages_chat_id_foreign` (`chat_id`),
  CONSTRAINT `chat_messages_chat_id_foreign` FOREIGN KEY (`chat_id`) REFERENCES `chats` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla agentechatgpt.chat_messages: ~1 rows (aproximadamente)
DELETE FROM `chat_messages`;
INSERT INTO `chat_messages` (`id`, `chat_id`, `message`, `sender`, `created_at`, `updated_at`) VALUES
	(1, 1, 'cual es la descripcion del producto maxime totam nesciunt?', 'user', '2025-02-28 20:50:03', '2025-02-28 20:50:03'),
	(2, 1, 'cual es la descripcion del producto maxime totam nesciunt?', 'user', '2025-02-28 20:51:43', '2025-02-28 20:51:43'),
	(3, 1, 'Aquí tienes la información solicitada: Doloremque reiciendis rem nihil accusantium rerum.', 'agent', '2025-02-28 20:51:48', '2025-02-28 20:51:48');

-- Volcando estructura para tabla agentechatgpt.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla agentechatgpt.failed_jobs: ~0 rows (aproximadamente)
DELETE FROM `failed_jobs`;

-- Volcando estructura para tabla agentechatgpt.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla agentechatgpt.migrations: ~0 rows (aproximadamente)
DELETE FROM `migrations`;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
	(3, '2019_08_19_000000_create_failed_jobs_table', 1),
	(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
	(5, '2025_02_28_144636_create_products_table', 1),
	(6, '2025_02_28_151157_add_url_to_products_table', 1),
	(7, '2025_02_28_154040_create_chats_table', 1),
	(8, '2025_02_28_154249_create_chat_messages_table', 1);

-- Volcando estructura para tabla agentechatgpt.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla agentechatgpt.password_reset_tokens: ~0 rows (aproximadamente)
DELETE FROM `password_reset_tokens`;

-- Volcando estructura para tabla agentechatgpt.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla agentechatgpt.personal_access_tokens: ~0 rows (aproximadamente)
DELETE FROM `personal_access_tokens`;

-- Volcando estructura para tabla agentechatgpt.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `price` decimal(10,2) NOT NULL,
  `discount_price` decimal(10,2) DEFAULT NULL,
  `currency` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USD',
  `category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_sku_unique` (`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla agentechatgpt.products: ~100 rows (aproximadamente)
DELETE FROM `products`;
INSERT INTO `products` (`id`, `name`, `description`, `image`, `video`, `location`, `stock`, `price`, `discount_price`, `currency`, `category`, `sku`, `url`, `active`, `created_at`, `updated_at`) VALUES
	(1, 'voluptas ducimus voluptates', 'Animi consequuntur rerum quos eos quibusdam.', 'https://source.unsplash.com/400x300/?product', NULL, '-57.370188, -103.495729', 12, 1456.34, 1310.71, 'USD', 'Celulares', 'ZDURL-#####', 'http://www.dach.com/ut-nihil-velit-dolor.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(2, 'dolorem id aliquam', 'Optio recusandae autem molestiae sint harum dolores veniam.', 'https://source.unsplash.com/400x300/?product', NULL, '-35.917285, -71.491669', 20, 541.20, 487.08, 'USD', 'Electrodomésticos', 'RHGFM-#####', 'http://www.marvin.com/laboriosam-numquam-libero-non-a-et-deleniti.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(3, 'facere sed fugit', 'Omnis consequatur assumenda quidem dolore.', 'https://source.unsplash.com/400x300/?product', NULL, '-40.984555, 161.734274', 6, 546.21, 491.59, 'USD', 'Accesorios', 'VXKPP-#####', 'http://www.davis.org/', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(4, 'ipsum et repellat', 'Sit est dolor voluptas quos laboriosam id et.', 'https://source.unsplash.com/400x300/?product', NULL, '-79.395526, 114.612194', 26, 794.02, 714.62, 'USD', 'Electrodomésticos', 'TTDID-#####', 'https://gerlach.com/corporis-ea-velit-odio-cum-enim-fugiat.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(5, 'eaque dolorem sint', 'Soluta temporibus molestiae est consequatur occaecati tempora.', 'https://source.unsplash.com/400x300/?product', NULL, '-76.045989, -124.791277', 26, 1765.55, 1589.00, 'USD', 'Celulares', 'JUXAZ-#####', 'https://ziemann.info/sed-corporis-minima-qui-dicta-dolor-eligendi.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(6, 'doloremque eum labore', 'Amet earum in reprehenderit nulla et veniam sint aut.', 'https://source.unsplash.com/400x300/?product', NULL, '-35.677524, -6.382761', 19, 1267.83, 1141.05, 'USD', 'Accesorios', 'PZDAP-#####', 'https://mohr.net/exercitationem-consequuntur-ea-assumenda-sit-fugiat.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(7, 'maxime totam nesciunt', 'Doloremque reiciendis rem nihil accusantium rerum.', 'https://source.unsplash.com/400x300/?product', NULL, '-8.25098, -153.591253', 3, 930.03, 837.03, 'USD', 'Electrodomésticos', 'BRGXB-#####', 'http://www.corkery.biz/consequatur-qui-ratione-alias-repudiandae-exercitationem.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(8, 'laborum aliquam unde', 'Distinctio sit molestias totam et rem numquam aut.', 'https://source.unsplash.com/400x300/?product', NULL, '36.365102, -151.842529', 5, 943.96, 849.56, 'USD', 'Celulares', 'RAICX-#####', 'http://www.klein.com/blanditiis-molestias-iste-eos-harum.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(9, 'rem veritatis velit', 'Optio id provident quae et architecto in omnis.', 'https://source.unsplash.com/400x300/?product', NULL, '-69.792005, 171.639419', 37, 827.94, 745.15, 'USD', 'Laptops', 'LUBKS-#####', 'https://mckenzie.biz/cum-nam-voluptatem-at-accusantium.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(10, 'ut voluptas delectus', 'Dolore et asperiores et esse.', 'https://source.unsplash.com/400x300/?product', NULL, '2.45204, 55.672806', 39, 167.13, 150.42, 'USD', 'Celulares', 'IPOBP-#####', 'http://borer.biz/cumque-asperiores-sint-voluptas-delectus-veritatis-necessitatibus-iure', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(11, 'similique eveniet iusto', 'Fugit ducimus laboriosam non quo.', 'https://source.unsplash.com/400x300/?product', NULL, '64.282112, -14.542884', 7, 364.30, 327.87, 'USD', 'Accesorios', 'QSHKO-#####', 'http://www.stanton.com/', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(12, 'enim et soluta', 'Sapiente numquam vitae eius ex excepturi excepturi.', 'https://source.unsplash.com/400x300/?product', NULL, '83.100985, 170.744881', 15, 1629.75, 1466.78, 'USD', 'Celulares', 'ARMQV-#####', 'http://donnelly.com/quia-quos-nam-dolor-nostrum-aliquid-commodi-dolorem.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(13, 'ducimus est rerum', 'Et est pariatur ea numquam ipsum cum.', 'https://source.unsplash.com/400x300/?product', NULL, '21.273543, 127.395598', 17, 733.02, 659.72, 'USD', 'Accesorios', 'IZJLM-#####', 'http://rutherford.biz/beatae-voluptatem-expedita-nobis-cupiditate-libero.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(14, 'iure delectus nobis', 'Nemo adipisci quo hic culpa ex voluptatibus sequi.', 'https://source.unsplash.com/400x300/?product', NULL, '36.243249, -80.198941', 48, 968.41, 871.57, 'USD', 'Celulares', 'RLALM-#####', 'https://www.cartwright.com/aut-consectetur-animi-culpa-voluptate-ut-officiis', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(15, 'ut facere et', 'Blanditiis nulla dolore praesentium fugiat qui sed.', 'https://source.unsplash.com/400x300/?product', NULL, '-25.741993, -75.252704', 15, 347.77, 312.99, 'USD', 'Accesorios', 'SCNYG-#####', 'http://www.buckridge.biz/dolor-quia-voluptas-similique-vero.html', 0, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(16, 'non repudiandae ipsa', 'Maiores perspiciatis alias commodi necessitatibus qui.', 'https://source.unsplash.com/400x300/?product', NULL, '-74.29736, -154.293641', 8, 685.41, 616.87, 'USD', 'Laptops', 'PQIVL-#####', 'http://www.shields.com/ut-voluptatibus-fuga-qui-atque-corporis.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(17, 'natus perspiciatis at', 'Molestias laboriosam tempore facere quod deserunt expedita.', 'https://source.unsplash.com/400x300/?product', NULL, '36.439396, 128.692503', 42, 1084.68, 976.21, 'USD', 'Electrodomésticos', 'KMOHZ-#####', 'http://bashirian.com/consequatur-a-non-magni-blanditiis-necessitatibus', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(18, 'inventore asperiores inventore', 'Assumenda est reprehenderit et expedita distinctio repellat.', 'https://source.unsplash.com/400x300/?product', NULL, '46.892032, -116.974635', 24, 378.06, 340.25, 'USD', 'Laptops', 'UYFCB-#####', 'http://www.dickens.biz/minima-est-provident-ut-animi-tempora-magnam.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(19, 'beatae id eum', 'Libero sapiente rem voluptatem.', 'https://source.unsplash.com/400x300/?product', NULL, '-34.720856, 68.000072', 47, 201.77, 181.59, 'USD', 'Celulares', 'EXWYT-#####', 'http://www.greenholt.com/numquam-est-explicabo-explicabo-excepturi-dolor.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(20, 'odio aut fugiat', 'Facilis quia ad et esse at quisquam.', 'https://source.unsplash.com/400x300/?product', NULL, '-85.601474, 59.48355', 48, 1702.60, 1532.34, 'USD', 'Celulares', 'MRTQB-#####', 'http://www.labadie.com/molestias-quisquam-distinctio-veniam-impedit-nam-et', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(21, 'dolore quo libero', 'Rerum veniam similique ab est.', 'https://source.unsplash.com/400x300/?product', NULL, '-20.674472, -161.433895', 46, 482.58, 434.32, 'USD', 'Laptops', 'YKQKH-#####', 'http://lakin.com/illo-qui-quia-odit-enim-fugiat-exercitationem-molestiae-doloribus.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(22, 'vel ea magnam', 'Molestiae et fugit omnis asperiores dolore id non.', 'https://source.unsplash.com/400x300/?product', NULL, '50.034223, -124.685279', 44, 86.14, NULL, 'USD', 'Electrodomésticos', 'MKBBY-#####', 'https://hoppe.org/quisquam-ratione-ut-commodi-officiis-libero-voluptas-sunt-non.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(23, 'aspernatur cupiditate voluptatem', 'In ut excepturi est quia.', 'https://source.unsplash.com/400x300/?product', NULL, '-81.100927, -135.346252', 21, 1612.01, 1450.81, 'USD', 'Electrodomésticos', 'AHWKO-#####', 'http://www.emmerich.org/et-quam-voluptatem-maxime-rerum-cupiditate-cupiditate', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(24, 'culpa eos earum', 'Ab molestiae aliquam ut illum voluptate nesciunt amet.', 'https://source.unsplash.com/400x300/?product', NULL, '68.575388, -40.753841', 30, 925.52, 832.97, 'USD', 'Laptops', 'PDWIM-#####', 'http://www.funk.biz/voluptas-autem-nobis-possimus-dolor-libero', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(25, 'aperiam expedita cum', 'Atque et nesciunt et.', 'https://source.unsplash.com/400x300/?product', NULL, '-76.149872, 142.416893', 43, 662.66, 596.39, 'USD', 'Laptops', 'YHQQC-#####', 'http://www.considine.org/natus-earum-ea-velit-blanditiis-vero-et', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(26, 'ea voluptatem inventore', 'Ut id velit aut.', 'https://source.unsplash.com/400x300/?product', NULL, '-22.615306, -61.211151', 37, 814.56, 733.10, 'USD', 'Accesorios', 'ZOJQZ-#####', 'http://dickens.org/illo-enim-dolorum-ex-nisi-eum-consequuntur', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(27, 'excepturi impedit sit', 'Rerum nesciunt ut aut harum.', 'https://source.unsplash.com/400x300/?product', NULL, '41.963089, -152.868736', 35, 803.84, 723.46, 'USD', 'Electrodomésticos', 'DYCPU-#####', 'http://schimmel.com/quia-id-corporis-eum-ad-et', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(28, 'non ut officiis', 'Velit aperiam velit quam ea accusamus excepturi.', 'https://source.unsplash.com/400x300/?product', NULL, '-76.17135, -72.27742', 48, 1155.49, 1039.94, 'USD', 'Laptops', 'SGVWO-#####', 'http://rempel.com/', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(29, 'commodi et non', 'Autem ullam aliquid incidunt iusto molestiae deserunt quam numquam.', 'https://source.unsplash.com/400x300/?product', NULL, '17.924061, 104.577982', 40, 12.48, NULL, 'USD', 'Laptops', 'XLNSX-#####', 'http://www.brown.com/minima-optio-accusamus-velit-quo-tempora-id-ducimus.html', 0, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(30, 'consequatur voluptatem veniam', 'Aut praesentium dolorum pariatur.', 'https://source.unsplash.com/400x300/?product', NULL, '-40.972161, -80.840647', 46, 191.87, 172.68, 'USD', 'Electrodomésticos', 'KGAWP-#####', 'http://www.upton.com/ipsam-facere-deleniti-inventore-est-quo-quia', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(31, 'sint sapiente harum', 'Voluptatum consequatur rerum veritatis.', 'https://source.unsplash.com/400x300/?product', NULL, '28.643489, 134.499093', 7, 222.73, 200.46, 'USD', 'Laptops', 'XCOAY-#####', 'https://www.botsford.com/fuga-qui-sed-quia-ex', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(32, 'tempora voluptatibus provident', 'Eligendi esse voluptates commodi porro aliquam soluta voluptatem dolore.', 'https://source.unsplash.com/400x300/?product', NULL, '26.358909, -30.141525', 27, 729.03, 656.13, 'USD', 'Laptops', 'HMHRN-#####', 'http://bailey.com/rerum-error-et-incidunt-sed-aut-ipsum-rem.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(33, 'ut ea sed', 'Eaque et qui voluptas et excepturi.', 'https://source.unsplash.com/400x300/?product', NULL, '-77.635841, 155.888316', 16, 1868.92, 1682.03, 'USD', 'Electrodomésticos', 'EKKKO-#####', 'https://www.barrows.com/ut-illum-fugiat-voluptatum-magnam-qui-corporis-alias', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(34, 'qui ut qui', 'Repudiandae quod distinctio odio laborum maxime ut.', 'https://source.unsplash.com/400x300/?product', NULL, '89.635317, -89.745766', 25, 1766.27, 1589.64, 'USD', 'Electrodomésticos', 'GKEZM-#####', 'http://mosciski.com/quam-sed-minus-voluptatibus-cumque-velit-omnis', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(35, 'asperiores vero odit', 'Explicabo et ad laboriosam.', 'https://source.unsplash.com/400x300/?product', NULL, '59.43308, 18.793249', 46, 1646.64, 1481.98, 'USD', 'Electrodomésticos', 'GVLMW-#####', 'http://www.predovic.org/est-qui-alias-omnis-doloribus', 0, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(36, 'non omnis dolorum', 'Culpa fugiat ex perferendis enim.', 'https://source.unsplash.com/400x300/?product', NULL, '-74.954528, 87.327951', 2, 299.70, 269.73, 'USD', 'Celulares', 'WEBQK-#####', 'http://gutmann.com/praesentium-quod-perspiciatis-eius-temporibus-quidem', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(37, 'sit est soluta', 'Illo placeat quod iure iusto quis.', 'https://source.unsplash.com/400x300/?product', NULL, '-40.457632, 57.932657', 21, 1618.78, 1456.90, 'USD', 'Celulares', 'CZGLL-#####', 'http://moore.com/', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(38, 'alias recusandae ipsa', 'Sed odio doloribus est iusto tempora.', 'https://source.unsplash.com/400x300/?product', NULL, '36.290311, 120.688159', 17, 1936.01, 1742.41, 'USD', 'Laptops', 'BACQR-#####', 'http://hartmann.net/', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(39, 'dignissimos sint pariatur', 'Voluptas unde non qui velit adipisci at.', 'https://source.unsplash.com/400x300/?product', NULL, '-12.289628, 20.035199', 20, 411.67, 370.50, 'USD', 'Laptops', 'ONNMW-#####', 'http://torphy.com/id-nisi-quasi-facere-quia-expedita-voluptas', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(40, 'est sed tempore', 'Velit voluptatem odio aspernatur est qui.', 'https://source.unsplash.com/400x300/?product', NULL, '-6.70603, -41.547821', 45, 1501.96, 1351.76, 'USD', 'Laptops', 'EGCVV-#####', 'http://www.dare.com/', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(41, 'dolor doloremque numquam', 'Et est et ipsa sunt.', 'https://source.unsplash.com/400x300/?product', NULL, '-57.03083, 166.700034', 28, 1190.57, 1071.51, 'USD', 'Laptops', 'PDIEM-#####', 'http://hamill.biz/fugit-fugiat-dolorum-tempore.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(42, 'non vero optio', 'Fugit illum suscipit eos et.', 'https://source.unsplash.com/400x300/?product', NULL, '65.680459, -132.085391', 36, 785.14, 706.63, 'USD', 'Electrodomésticos', 'ZDUAK-#####', 'http://mante.org/', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(43, 'asperiores velit et', 'In quidem at impedit ut aut accusantium.', 'https://source.unsplash.com/400x300/?product', NULL, '-87.149986, 176.724282', 35, 82.02, NULL, 'USD', 'Laptops', 'ONTYA-#####', 'http://stanton.com/ad-est-temporibus-praesentium-ea-molestiae', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(44, 'iure dolores alias', 'Et eveniet quisquam exercitationem.', 'https://source.unsplash.com/400x300/?product', NULL, '-35.985968, -145.390122', 1, 672.84, 605.56, 'USD', 'Accesorios', 'MARNA-#####', 'http://www.bernier.com/quia-qui-voluptatem-debitis-est-labore.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(45, 'odio beatae dolore', 'Odit id eveniet voluptatum corporis.', 'https://source.unsplash.com/400x300/?product', NULL, '-21.763103, -147.027383', 29, 1607.78, 1447.00, 'USD', 'Celulares', 'QYGNY-#####', 'http://www.nitzsche.com/commodi-eos-cupiditate-soluta-quis-veniam', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(46, 'id unde autem', 'Beatae iste eum et repudiandae temporibus pariatur necessitatibus.', 'https://source.unsplash.com/400x300/?product', NULL, '-49.215071, -163.595734', 44, 29.39, NULL, 'USD', 'Accesorios', 'DBSET-#####', 'https://conn.com/similique-autem-molestias-voluptatibus-ea-accusamus-aut.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(47, 'et officia odit', 'Reiciendis dignissimos sint laudantium pariatur aut omnis hic.', 'https://source.unsplash.com/400x300/?product', NULL, '17.897091, 19.345921', 13, 1261.70, 1135.53, 'USD', 'Laptops', 'PXONS-#####', 'https://www.gorczany.com/voluptatem-ut-asperiores-autem-soluta-fuga-nihil-qui', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(48, 'maiores animi et', 'Non quis hic eaque maiores est fuga ipsa.', 'https://source.unsplash.com/400x300/?product', NULL, '-9.197253, 22.990212', 32, 1904.50, 1714.05, 'USD', 'Accesorios', 'JOWUY-#####', 'https://www.corwin.info/omnis-sint-qui-officiis-dignissimos', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(49, 'eveniet et vel', 'Perferendis sapiente quas et fugiat delectus in est harum.', 'https://source.unsplash.com/400x300/?product', NULL, '52.284898, 94.299287', 37, 1488.98, 1340.08, 'USD', 'Electrodomésticos', 'ALQAQ-#####', 'http://www.goodwin.com/similique-rem-ea-voluptatibus-modi', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(50, 'optio quas veniam', 'Voluptates in maxime recusandae.', 'https://source.unsplash.com/400x300/?product', NULL, '-81.037689, 131.848349', 47, 1578.36, 1420.52, 'USD', 'Electrodomésticos', 'XSLCD-#####', 'https://skiles.com/nihil-nesciunt-perspiciatis-reprehenderit-voluptatem-ut.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(51, 'dicta vel qui', 'Maxime ipsum nisi atque itaque occaecati.', 'https://source.unsplash.com/400x300/?product', NULL, '-41.631733, -129.222835', 16, 360.60, 324.54, 'USD', 'Electrodomésticos', 'QWAQS-#####', 'http://hintz.biz/magnam-eius-minima-dolor-quia-aut', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(52, 'labore vitae qui', 'Quo consequatur sed itaque sed eos eaque.', 'https://source.unsplash.com/400x300/?product', NULL, '-73.079485, -9.117864', 33, 558.49, 502.64, 'USD', 'Electrodomésticos', 'TTCFG-#####', 'http://www.grady.com/mollitia-in-sit-occaecati-aliquid-illo-quibusdam-dolores', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(53, 'recusandae non praesentium', 'Voluptates reiciendis officia voluptatem quam ut ea earum.', 'https://source.unsplash.com/400x300/?product', NULL, '29.77126, 78.068714', 18, 856.27, 770.64, 'USD', 'Celulares', 'UBUBI-#####', 'http://www.lang.com/architecto-doloribus-aliquid-sint', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(54, 'ipsum rerum in', 'Soluta ex ipsa ad totam quo omnis reiciendis.', 'https://source.unsplash.com/400x300/?product', NULL, '-47.74511, 97.700008', 37, 1192.90, 1073.61, 'USD', 'Accesorios', 'JBELU-#####', 'http://www.lowe.info/qui-perspiciatis-repudiandae-sed-est.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(55, 'amet placeat nemo', 'Cum repellendus amet ut hic atque ut.', 'https://source.unsplash.com/400x300/?product', NULL, '85.277057, 165.34231', 12, 1307.39, 1176.65, 'USD', 'Electrodomésticos', 'ZSIAE-#####', 'http://gulgowski.com/quia-qui-est-voluptatem-et', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(56, 'sed natus consectetur', 'Consequatur dolorem quia delectus dolore qui repellendus.', 'https://source.unsplash.com/400x300/?product', NULL, '-17.093857, -49.959449', 2, 1375.49, 1237.94, 'USD', 'Accesorios', 'JYBCD-#####', 'http://corwin.com/eos-minima-voluptates-et-tempore', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(57, 'aut veritatis voluptatem', 'Autem voluptas et pariatur rerum.', 'https://source.unsplash.com/400x300/?product', NULL, '-0.775163, 20.446362', 6, 448.91, 404.02, 'USD', 'Celulares', 'RQPQA-#####', 'http://www.hansen.com/dolores-ut-ipsa-magnam-pariatur', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(58, 'minus quo aut', 'Voluptatem adipisci consequatur quidem fuga laboriosam voluptate.', 'https://source.unsplash.com/400x300/?product', NULL, '59.454041, 21.217281', 42, 556.82, 501.14, 'USD', 'Celulares', 'OFRIO-#####', 'https://conn.com/facere-et-rerum-voluptatum-debitis-aut-error.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(59, 'aut illo officiis', 'Autem expedita nobis voluptas omnis ea.', 'https://source.unsplash.com/400x300/?product', NULL, '-35.151692, -46.035736', 47, 786.89, 708.20, 'USD', 'Laptops', 'VLOQY-#####', 'http://ferry.com/autem-omnis-harum-et-iure-voluptatem-at-exercitationem.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(60, 'consequatur sint dolores', 'Repudiandae doloremque ipsum sint natus magni non fuga.', 'https://source.unsplash.com/400x300/?product', NULL, '54.575762, 133.296857', 21, 816.17, 734.55, 'USD', 'Laptops', 'AEOVD-#####', 'http://cummings.info/', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(61, 'dolore voluptatem perspiciatis', 'Et qui consequatur tenetur et velit aut reprehenderit.', 'https://source.unsplash.com/400x300/?product', NULL, '0.686678, 105.297496', 40, 1938.22, 1744.40, 'USD', 'Electrodomésticos', 'WGVAE-#####', 'https://tillman.info/animi-dolores-recusandae-minus-eligendi-ut-ratione-quis-rerum.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(62, 'quo necessitatibus ipsum', 'Dolores ut perferendis et est tenetur.', 'https://source.unsplash.com/400x300/?product', NULL, '58.97535, 160.517226', 30, 813.50, 732.15, 'USD', 'Celulares', 'OSXMF-#####', 'http://www.abshire.com/harum-sint-ea-accusantium-nobis-sed-tenetur-dicta', 0, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(63, 'iusto asperiores officiis', 'Alias adipisci quae ut doloremque corrupti veritatis omnis adipisci.', 'https://source.unsplash.com/400x300/?product', NULL, '-43.298927, 51.540249', 11, 1570.99, 1413.89, 'USD', 'Celulares', 'OBBAZ-#####', 'https://www.jenkins.com/magnam-fuga-quod-voluptas-aspernatur-nostrum-doloribus-blanditiis', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(64, 'occaecati aut aperiam', 'Iure laboriosam ex ipsam sint ducimus voluptate eos illo.', 'https://source.unsplash.com/400x300/?product', NULL, '-24.566534, 68.621093', 0, 400.81, 360.73, 'USD', 'Laptops', 'JJRXT-#####', 'http://www.hermann.com/aliquid-ut-nostrum-alias-asperiores-commodi-iure', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(65, 'culpa distinctio quis', 'Facilis facere aliquam maxime.', 'https://source.unsplash.com/400x300/?product', NULL, '-86.063531, 26.338419', 14, 1131.46, 1018.31, 'USD', 'Celulares', 'ZLVAA-#####', 'http://auer.info/sunt-repudiandae-voluptatem-dicta-odit-unde-corrupti-autem-et', 0, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(66, 'ipsum voluptates veniam', 'Consequatur minima fugit alias et.', 'https://source.unsplash.com/400x300/?product', NULL, '-85.077885, -137.750018', 22, 893.70, 804.33, 'USD', 'Electrodomésticos', 'JZFDU-#####', 'http://www.kozey.com/voluptatem-quisquam-tempore-vel', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(67, 'quasi nobis quia', 'In dolor doloribus delectus molestias nisi.', 'https://source.unsplash.com/400x300/?product', NULL, '86.28599, -89.62452', 23, 1259.75, 1133.78, 'USD', 'Celulares', 'UHWJH-#####', 'http://www.strosin.com/consequuntur-aliquam-et-deleniti-ab-eligendi', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(68, 'consequatur nihil distinctio', 'Mollitia et quaerat exercitationem.', 'https://source.unsplash.com/400x300/?product', NULL, '-46.718575, -125.804079', 10, 1798.32, 1618.49, 'USD', 'Celulares', 'YYKYF-#####', 'http://www.barrows.org/nesciunt-sunt-dolores-aut-a-aliquid', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(69, 'sequi repellendus voluptatem', 'Ex ea quasi eum consequatur soluta cum ut.', 'https://source.unsplash.com/400x300/?product', NULL, '82.752231, -48.549148', 19, 1759.00, 1583.10, 'USD', 'Accesorios', 'EYKER-#####', 'http://tillman.org/in-officiis-similique-et-minus-ab-quia', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(70, 'officia praesentium eligendi', 'Quo deleniti voluptatem odit et autem.', 'https://source.unsplash.com/400x300/?product', NULL, '8.486135, 7.846753', 17, 598.67, 538.80, 'USD', 'Laptops', 'RTONA-#####', 'http://www.carroll.com/aut-et-reprehenderit-odio-sunt-saepe-repellat-odio', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(71, 'aliquid dolorem nobis', 'Repellendus facere quaerat est.', 'https://source.unsplash.com/400x300/?product', NULL, '-75.614494, 79.996995', 24, 524.84, 472.36, 'USD', 'Electrodomésticos', 'JZGYW-#####', 'http://www.steuber.info/voluptatum-quis-repellat-dolores-accusantium', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(72, 'sit quae deserunt', 'Rerum quaerat et est autem quasi sed.', 'https://source.unsplash.com/400x300/?product', NULL, '9.95873, -8.980217', 18, 426.01, 383.41, 'USD', 'Accesorios', 'IGBPH-#####', 'http://www.mertz.org/', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(73, 'debitis tenetur iste', 'Maxime vero autem sed doloribus omnis.', 'https://source.unsplash.com/400x300/?product', NULL, '-54.80291, -128.387127', 16, 926.85, 834.17, 'USD', 'Laptops', 'BPAOE-#####', 'http://christiansen.net/voluptas-ad-quasi-temporibus-accusamus.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(74, 'at id saepe', 'Ea nemo dicta qui illum quo laborum ex.', 'https://source.unsplash.com/400x300/?product', NULL, '25.868596, -14.183712', 42, 1905.60, 1715.04, 'USD', 'Accesorios', 'ULEOT-#####', 'http://www.mcglynn.biz/', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(75, 'ad enim voluptas', 'Aut aut voluptatem voluptas assumenda iure molestiae nihil iusto.', 'https://source.unsplash.com/400x300/?product', NULL, '-11.735572, -32.570307', 27, 1981.78, 1783.60, 'USD', 'Celulares', 'YIWRT-#####', 'http://www.erdman.net/perferendis-enim-dignissimos-quia.html', 0, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(76, 'quod ipsa laborum', 'Est dicta vel magnam sint quia fuga vitae.', 'https://source.unsplash.com/400x300/?product', NULL, '-71.587929, -50.274655', 46, 1931.77, 1738.59, 'USD', 'Accesorios', 'QHORC-#####', 'https://www.murazik.com/ut-consequuntur-quaerat-perferendis-enim-ab', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(77, 'aut adipisci aut', 'Voluptate in ullam deleniti debitis.', 'https://source.unsplash.com/400x300/?product', NULL, '-1.913115, -129.028943', 8, 1905.60, 1715.04, 'USD', 'Accesorios', 'YLSZK-#####', 'http://www.rolfson.org/reprehenderit-sunt-sint-voluptas-aut.html', 0, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(78, 'ut dolor omnis', 'Est sint adipisci veniam temporibus aut.', 'https://source.unsplash.com/400x300/?product', NULL, '-60.204522, 172.709551', 3, 1702.52, 1532.27, 'USD', 'Laptops', 'AQOSB-#####', 'https://www.schoen.com/alias-deserunt-qui-esse-possimus', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(79, 'quam nihil consequuntur', 'Magni repellendus consectetur esse sequi illo perferendis aliquid.', 'https://source.unsplash.com/400x300/?product', NULL, '2.219539, -113.212856', 35, 1230.19, 1107.17, 'USD', 'Electrodomésticos', 'KYYDV-#####', 'http://sporer.org/', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(80, 'reprehenderit ea reiciendis', 'Maiores velit iusto alias officiis nostrum.', 'https://source.unsplash.com/400x300/?product', NULL, '26.766496, -34.86132', 14, 809.15, 728.24, 'USD', 'Electrodomésticos', 'ZCRHQ-#####', 'http://www.dicki.net/est-laboriosam-libero-assumenda.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(81, 'dolor at omnis', 'Quasi sint doloremque occaecati molestiae itaque sit.', 'https://source.unsplash.com/400x300/?product', NULL, '-56.040528, -157.295264', 12, 777.78, 700.00, 'USD', 'Electrodomésticos', 'USKCH-#####', 'http://www.sipes.com/', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(82, 'consequuntur mollitia vero', 'Ipsam labore cum voluptatem ipsam.', 'https://source.unsplash.com/400x300/?product', NULL, '51.806368, -40.357504', 45, 372.73, 335.46, 'USD', 'Accesorios', 'ZEIAJ-#####', 'http://www.feeney.com/quam-earum-nostrum-aut-dolore-quam.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(83, 'autem iusto laborum', 'Quas nostrum fugit ea nihil molestiae excepturi.', 'https://source.unsplash.com/400x300/?product', NULL, '-78.195837, 27.590997', 37, 1379.71, 1241.74, 'USD', 'Accesorios', 'BZMNR-#####', 'http://www.roberts.com/voluptatibus-mollitia-aspernatur-iusto-repellat-sed', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(84, 'molestiae magnam dolor', 'Corporis et ad voluptatum blanditiis.', 'https://source.unsplash.com/400x300/?product', NULL, '35.601314, -126.10171', 14, 1584.00, 1425.60, 'USD', 'Celulares', 'BMABC-#####', 'http://www.daniel.com/', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(85, 'aut cumque omnis', 'Impedit esse modi eum natus labore eos qui.', 'https://source.unsplash.com/400x300/?product', NULL, '52.869061, -106.056591', 14, 380.76, 342.68, 'USD', 'Electrodomésticos', 'LXHTE-#####', 'http://www.aufderhar.com/', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(86, 'soluta molestias commodi', 'Autem sequi animi et qui quisquam.', 'https://source.unsplash.com/400x300/?product', NULL, '-68.992006, 172.307997', 15, 393.12, 353.81, 'USD', 'Electrodomésticos', 'NVZOW-#####', 'https://www.kuhn.com/est-numquam-facere-et-velit-id', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(87, 'omnis nam qui', 'Nam eveniet nihil qui ut.', 'https://source.unsplash.com/400x300/?product', NULL, '-47.118691, -143.388008', 11, 338.35, 304.52, 'USD', 'Laptops', 'CJLXJ-#####', 'http://block.com/sed-sit-qui-blanditiis-aut-non-sunt-voluptate.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(88, 'autem eum quas', 'Nihil enim velit iste corporis.', 'https://source.unsplash.com/400x300/?product', NULL, '22.802986, -130.727644', 43, 1827.11, 1644.40, 'USD', 'Electrodomésticos', 'FYFAY-#####', 'https://frami.com/quos-in-dolor-voluptas-quia-vero-est-autem-dolor.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(89, 'consequatur ipsam et', 'Omnis delectus rerum quia eos deleniti doloremque.', 'https://source.unsplash.com/400x300/?product', NULL, '73.500634, 49.139704', 36, 1943.86, 1749.47, 'USD', 'Laptops', 'EJJZB-#####', 'http://boyle.biz/incidunt-excepturi-veniam-minus-similique-dolorum-aspernatur-non.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(90, 'iste amet voluptatem', 'Qui nobis et quia temporibus id libero veritatis.', 'https://source.unsplash.com/400x300/?product', NULL, '55.492854, -160.403372', 16, 531.00, 477.90, 'USD', 'Accesorios', 'AVFJP-#####', 'http://www.feeney.com/quia-quidem-sit-soluta-dolorum', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(91, 'velit dolorem officia', 'Explicabo aut eos enim nostrum repudiandae.', 'https://source.unsplash.com/400x300/?product', NULL, '-89.238557, -55.82619', 32, 625.82, 563.24, 'USD', 'Electrodomésticos', 'SRKPX-#####', 'http://www.lemke.com/quasi-corrupti-qui-fugiat-ex-officia-deleniti.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(92, 'dolore soluta impedit', 'Ea ea nobis aut eos aut.', 'https://source.unsplash.com/400x300/?product', NULL, '79.838267, -98.844117', 48, 503.92, 453.53, 'USD', 'Celulares', 'EZACZ-#####', 'http://dooley.biz/occaecati-eveniet-maiores-quasi-et-et-voluptate', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(93, 'dignissimos ad tempora', 'Blanditiis eos consectetur rerum consequatur optio qui et.', 'https://source.unsplash.com/400x300/?product', NULL, '34.782277, 100.947237', 16, 727.64, 654.88, 'USD', 'Laptops', 'VEGZD-#####', 'http://www.wiegand.biz/dolores-dignissimos-et-ea-quasi-aliquam-voluptates', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(94, 'eligendi dignissimos blanditiis', 'Ratione maiores unde consequuntur iste fuga qui.', 'https://source.unsplash.com/400x300/?product', NULL, '32.410559, -57.180525', 46, 28.19, NULL, 'USD', 'Electrodomésticos', 'KTCED-#####', 'http://swaniawski.com/ut-quos-est-sequi-et-impedit-aperiam', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(95, 'voluptatum vero vel', 'Doloribus suscipit quia cum repellendus voluptatem.', 'https://source.unsplash.com/400x300/?product', NULL, '66.178463, 96.620081', 12, 1719.34, 1547.41, 'USD', 'Celulares', 'XBQCD-#####', 'http://padberg.info/', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(96, 'dolor perspiciatis quia', 'Quia similique a quo cumque ut quo voluptatibus.', 'https://source.unsplash.com/400x300/?product', NULL, '21.827693, 93.011576', 15, 784.93, 706.44, 'USD', 'Laptops', 'SQWDQ-#####', 'http://kris.com/', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(97, 'dicta illum deleniti', 'Commodi eum cupiditate quas dolorem sit.', 'https://source.unsplash.com/400x300/?product', NULL, '6.085294, 41.853881', 39, 1859.72, 1673.75, 'USD', 'Accesorios', 'QNZWO-#####', 'http://turcotte.com/beatae-culpa-earum-nostrum-autem-pariatur-perferendis-est-et', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(98, 'porro non ut', 'Doloremque vel molestias explicabo ea beatae delectus.', 'https://source.unsplash.com/400x300/?product', NULL, '46.566096, -86.509456', 19, 1267.33, 1140.60, 'USD', 'Laptops', 'PDOTV-#####', 'http://muller.info/dolorem-ratione-illo-veritatis', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(99, 'soluta temporibus quia', 'Sit ut vel cumque quo.', 'https://source.unsplash.com/400x300/?product', NULL, '6.985627, -43.914131', 28, 927.04, 834.34, 'USD', 'Celulares', 'KMFLV-#####', 'http://www.leuschke.com/facere-dolore-nostrum-voluptatem-voluptatum.html', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(100, 'autem similique blanditiis', 'Autem quisquam autem laboriosam excepturi ut perferendis temporibus.', 'https://source.unsplash.com/400x300/?product', NULL, '-34.335114, -130.320324', 13, 982.54, 884.29, 'USD', 'Accesorios', 'IXERT-#####', 'http://mcclure.biz/voluptatibus-in-autem-sint-voluptatem-porro-nihil-quae', 1, '2025-02-28 20:44:55', '2025-02-28 20:44:55');

-- Volcando estructura para tabla agentechatgpt.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla agentechatgpt.users: ~10 rows (aproximadamente)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'Kendall Mayer', 'granville25@example.com', '2025-02-28 20:44:54', '$2y$12$mQCb8k/ggaGaxvN7GAulB.fPtlRvj7qHmMPLEIkH9XSDYkEJ87Jh6', 'IvMlaPOWXZ', '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(2, 'Francisca Konopelski Jr.', 'iblock@example.com', '2025-02-28 20:44:55', '$2y$12$mQCb8k/ggaGaxvN7GAulB.fPtlRvj7qHmMPLEIkH9XSDYkEJ87Jh6', 'GprJyR3luU', '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(3, 'Jan Schamberger', 'kling.yasmeen@example.org', '2025-02-28 20:44:55', '$2y$12$mQCb8k/ggaGaxvN7GAulB.fPtlRvj7qHmMPLEIkH9XSDYkEJ87Jh6', '8V8I0kmTnc', '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(4, 'Cali Senger', 'marcella59@example.com', '2025-02-28 20:44:55', '$2y$12$mQCb8k/ggaGaxvN7GAulB.fPtlRvj7qHmMPLEIkH9XSDYkEJ87Jh6', '1IVc4Wte8D', '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(5, 'Bert Christiansen', 'samir.mohr@example.com', '2025-02-28 20:44:55', '$2y$12$mQCb8k/ggaGaxvN7GAulB.fPtlRvj7qHmMPLEIkH9XSDYkEJ87Jh6', 'ji3rBRDLcN', '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(6, 'Oda Funk', 'lebsack.tristian@example.net', '2025-02-28 20:44:55', '$2y$12$mQCb8k/ggaGaxvN7GAulB.fPtlRvj7qHmMPLEIkH9XSDYkEJ87Jh6', 'VfgZqOKot1', '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(7, 'Corine Hilpert', 'theresa76@example.com', '2025-02-28 20:44:55', '$2y$12$mQCb8k/ggaGaxvN7GAulB.fPtlRvj7qHmMPLEIkH9XSDYkEJ87Jh6', 'I56vJE5Z6D', '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(8, 'Ransom Roob', 'kelsi04@example.net', '2025-02-28 20:44:55', '$2y$12$mQCb8k/ggaGaxvN7GAulB.fPtlRvj7qHmMPLEIkH9XSDYkEJ87Jh6', '62vCwooMxf', '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(9, 'Kobe Krajcik DDS', 'xander77@example.org', '2025-02-28 20:44:55', '$2y$12$mQCb8k/ggaGaxvN7GAulB.fPtlRvj7qHmMPLEIkH9XSDYkEJ87Jh6', 'arSBMAuCjm', '2025-02-28 20:44:55', '2025-02-28 20:44:55'),
	(10, 'Mrs. Mozell DuBuque', 'wnicolas@example.com', '2025-02-28 20:44:55', '$2y$12$mQCb8k/ggaGaxvN7GAulB.fPtlRvj7qHmMPLEIkH9XSDYkEJ87Jh6', 'MvBn7Yrtt9', '2025-02-28 20:44:55', '2025-02-28 20:44:55');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
