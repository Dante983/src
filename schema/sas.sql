CREATE TABLE `sas_blog_entries` (
    `id` BINARY(16) NOT NULL,
    `active` TINYINT(1) NULL DEFAULT '0',
    `detail_teaser_image` TINYINT(1) NULL DEFAULT '0',
    `media_id` BINARY(16) NULL,
    `author_id` BINARY(16) NOT NULL,
    `cms_page_id` BINARY(16) NULL,
    `cms_page_version_id` BINARY(16) NOT NULL,
    `published_at` DATE NOT NULL,
    `created_at` DATETIME(3) NOT NULL,
    `updated_at` DATETIME(3) NULL,
    PRIMARY KEY (`id`,`cms_page_version_id`),
    CONSTRAINT `json.sas_blog_entries.translated` CHECK (JSON_VALID(`translated`)),
    KEY `fk.sas_blog_entries.author_id` (`author_id`),
    CONSTRAINT `fk.sas_blog_entries.author_id` FOREIGN KEY (`author_id`) REFERENCES `sas_blog_author` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `sas_blog_entries_translation` (
    `title` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(255) NOT NULL,
    `teaser` VARCHAR(255) NULL,
    `meta_title` VARCHAR(255) NULL,
    `meta_description` VARCHAR(255) NULL,
    `content` LONGTEXT NULL,
    `custom_fields` JSON NULL,
    `created_at` DATETIME(3) NOT NULL,
    `updated_at` DATETIME(3) NULL,
    `sas_blog_entries_id` BINARY(16) NOT NULL,
    `language_id` BINARY(16) NOT NULL,
    PRIMARY KEY (`sas_blog_entries_id`,`language_id`),
    CONSTRAINT `json.sas_blog_entries_translation.custom_fields` CHECK (JSON_VALID(`custom_fields`)),
    KEY `fk.sas_blog_entries_translation.sas_blog_entries_id` (`sas_blog_entries_id`),
    KEY `fk.sas_blog_entries_translation.language_id` (`language_id`),
    CONSTRAINT `fk.sas_blog_entries_translation.sas_blog_entries_id` FOREIGN KEY (`sas_blog_entries_id`) REFERENCES `sas_blog_entries` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.sas_blog_entries_translation.language_id` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `sas_blog_category` (
    `id` BINARY(16) NOT NULL,
    `version_id` BINARY(16) NOT NULL,
    `parent_id` BINARY(16) NULL,
    `parent_version_id` BINARY(16) NULL,
    `after_category_id` BINARY(16) NULL,
    `level` INT NULL,
    `path` LONGTEXT NULL,
    `child_count` INT(11) NULL,
    `created_at` DATETIME(3) NOT NULL,
    `updated_at` DATETIME(3) NULL,
    PRIMARY KEY (`id`,`version_id`),
    CONSTRAINT `json.sas_blog_category.translated` CHECK (JSON_VALID(`translated`)),
    KEY `fk.sas_blog_category.parent_id` (`parent_id`,`version_id`),
    CONSTRAINT `fk.sas_blog_category.parent_id` FOREIGN KEY (`parent_id`,`version_id`) REFERENCES `sas_blog_category` (`id`,`version_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `sas_blog_category_translation` (
    `name` VARCHAR(255) NOT NULL,
    `custom_fields` JSON NULL,
    `created_at` DATETIME(3) NOT NULL,
    `updated_at` DATETIME(3) NULL,
    `sas_blog_category_id` BINARY(16) NOT NULL,
    `language_id` BINARY(16) NOT NULL,
    `sas_blog_category_version_id` BINARY(16) NOT NULL,
    PRIMARY KEY (`sas_blog_category_id`,`language_id`,`sas_blog_category_version_id`),
    CONSTRAINT `json.sas_blog_category_translation.custom_fields` CHECK (JSON_VALID(`custom_fields`)),
    KEY `fk.sas_blog_category_translation.sas_blog_category_id` (`sas_blog_category_id`,`sas_blog_category_version_id`),
    KEY `fk.sas_blog_category_translation.language_id` (`language_id`),
    CONSTRAINT `fk.sas_blog_category_translation.sas_blog_category_id` FOREIGN KEY (`sas_blog_category_id`,`sas_blog_category_version_id`) REFERENCES `sas_blog_category` (`id`,`version_id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.sas_blog_category_translation.language_id` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `sas_blog_blog_category` (
    `sas_blog_entries_id` BINARY(16) NOT NULL,
    `sas_blog_category_id` BINARY(16) NOT NULL,
    `sas_blog_category_version_id` BINARY(16) NOT NULL,
    PRIMARY KEY (`sas_blog_entries_id`,`sas_blog_category_id`,`sas_blog_category_version_id`),
    KEY `fk.sas_blog_blog_category.sas_blog_entries_id` (`sas_blog_entries_id`),
    KEY `fk.sas_blog_blog_category.sas_blog_category_id` (`sas_blog_category_id`,`sas_blog_category_version_id`),
    CONSTRAINT `fk.sas_blog_blog_category.sas_blog_entries_id` FOREIGN KEY (`sas_blog_entries_id`) REFERENCES `sas_blog_entries` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.sas_blog_blog_category.sas_blog_category_id` FOREIGN KEY (`sas_blog_category_id`,`sas_blog_category_version_id`) REFERENCES `sas_blog_category` (`id`,`version_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `sas_blog_author` (
    `id` BINARY(16) NOT NULL,
    `media_id` BINARY(16) NULL,
    `salutation_id` BINARY(16) NOT NULL,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `display_name` VARCHAR(255) NULL,
    `created_at` DATETIME(3) NOT NULL,
    `updated_at` DATETIME(3) NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `json.sas_blog_author.translated` CHECK (JSON_VALID(`translated`)),
    KEY `fk.sas_blog_author.salutation_id` (`salutation_id`),
    CONSTRAINT `fk.sas_blog_author.salutation_id` FOREIGN KEY (`salutation_id`) REFERENCES `salutation` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `sas_blog_author_translation` (
    `description` LONGTEXT NULL,
    `custom_fields` JSON NULL,
    `created_at` DATETIME(3) NOT NULL,
    `updated_at` DATETIME(3) NULL,
    `sas_blog_author_id` BINARY(16) NOT NULL,
    `language_id` BINARY(16) NOT NULL,
    PRIMARY KEY (`sas_blog_author_id`,`language_id`),
    CONSTRAINT `json.sas_blog_author_translation.custom_fields` CHECK (JSON_VALID(`custom_fields`)),
    KEY `fk.sas_blog_author_translation.sas_blog_author_id` (`sas_blog_author_id`),
    KEY `fk.sas_blog_author_translation.language_id` (`language_id`),
    CONSTRAINT `fk.sas_blog_author_translation.sas_blog_author_id` FOREIGN KEY (`sas_blog_author_id`) REFERENCES `sas_blog_author` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.sas_blog_author_translation.language_id` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;