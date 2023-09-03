CREATE TABLE `order` (
    `id` BINARY(16) NOT NULL,
    `version_id` BINARY(16) NOT NULL,
    `auto_increment` INT(11) NULL,
    `order_number` VARCHAR(64) NULL,
    `billing_address_id` BINARY(16) NOT NULL,
    `billing_address_version_id` BINARY(16) NOT NULL,
    `currency_id` BINARY(16) NOT NULL,
    `language_id` BINARY(16) NOT NULL,
    `sales_channel_id` BINARY(16) NOT NULL,
    `order_date_time` DATETIME(3) NOT NULL,
    `order_date` DATE NULL,
    `price` JSON NULL,
    `amount_total` DOUBLE NULL,
    `amount_net` DOUBLE NULL,
    `position_price` DOUBLE NULL,
    `tax_status` VARCHAR(255) NULL,
    `shipping_costs` JSON NULL,
    `shipping_total` DOUBLE NULL,
    `currency_factor` DOUBLE NOT NULL,
    `deep_link_code` VARCHAR(255) NULL,
    `affiliate_code` VARCHAR(255) NULL,
    `campaign_code` VARCHAR(255) NULL,
    `customer_comment` LONGTEXT NULL,
    `source` VARCHAR(255) NULL,
    `state_id` BINARY(16) NOT NULL,
    `rule_ids` JSON NULL,
    `custom_fields` JSON NULL,
    `created_by_id` BINARY(16) NULL,
    `updated_by_id` BINARY(16) NULL,
    `item_rounding` JSON NOT NULL,
    `total_rounding` JSON NOT NULL,
    `created_at` DATETIME(3) NOT NULL,
    `updated_at` DATETIME(3) NULL,
    PRIMARY KEY (`id`,`version_id`),
    CONSTRAINT `json.order.price` CHECK (JSON_VALID(`price`)),
    CONSTRAINT `json.order.shipping_costs` CHECK (JSON_VALID(`shipping_costs`)),
    CONSTRAINT `json.order.rule_ids` CHECK (JSON_VALID(`rule_ids`)),
    CONSTRAINT `json.order.custom_fields` CHECK (JSON_VALID(`custom_fields`)),
    CONSTRAINT `json.order.item_rounding` CHECK (JSON_VALID(`item_rounding`)),
    CONSTRAINT `json.order.total_rounding` CHECK (JSON_VALID(`total_rounding`)),
    KEY `fk.order.state_id` (`state_id`),
    KEY `fk.order.currency_id` (`currency_id`),
    KEY `fk.order.language_id` (`language_id`),
    KEY `fk.order.sales_channel_id` (`sales_channel_id`),
    KEY `fk.order.billing_address_id` (`billing_address_id`,`billing_address_version_id`),
    KEY `fk.order.created_by_id` (`created_by_id`),
    KEY `fk.order.updated_by_id` (`updated_by_id`),
    CONSTRAINT `fk.order.state_id` FOREIGN KEY (`state_id`) REFERENCES `state_machine_state` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order.currency_id` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order.language_id` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order.sales_channel_id` FOREIGN KEY (`sales_channel_id`) REFERENCES `sales_channel` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order.created_by_id` FOREIGN KEY (`created_by_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order.updated_by_id` FOREIGN KEY (`updated_by_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `order_address` (
    `id` BINARY(16) NOT NULL,
    `version_id` BINARY(16) NOT NULL,
    `country_id` BINARY(16) NOT NULL,
    `country_state_id` BINARY(16) NULL,
    `order_id` BINARY(16) NOT NULL,
    `order_version_id` BINARY(16) NOT NULL,
    `salutation_id` BINARY(16) NULL,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `street` VARCHAR(255) NOT NULL,
    `zipcode` VARCHAR(255) NULL,
    `city` VARCHAR(255) NOT NULL,
    `company` VARCHAR(255) NULL,
    `department` VARCHAR(255) NULL,
    `title` VARCHAR(255) NULL,
    `vat_id` VARCHAR(255) NULL,
    `phone_number` VARCHAR(255) NULL,
    `additional_address_line1` VARCHAR(255) NULL,
    `additional_address_line2` VARCHAR(255) NULL,
    `custom_fields` JSON NULL,
    `created_at` DATETIME(3) NOT NULL,
    `updated_at` DATETIME(3) NULL,
    PRIMARY KEY (`id`,`version_id`),
    CONSTRAINT `json.order_address.custom_fields` CHECK (JSON_VALID(`custom_fields`)),
    KEY `fk.order_address.country_id` (`country_id`),
    KEY `fk.order_address.country_state_id` (`country_state_id`),
    KEY `fk.order_address.order_id` (`order_id`,`order_version_id`),
    KEY `fk.order_address.salutation_id` (`salutation_id`),
    CONSTRAINT `fk.order_address.country_id` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order_address.country_state_id` FOREIGN KEY (`country_state_id`) REFERENCES `country_state` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order_address.order_id` FOREIGN KEY (`order_id`,`order_version_id`) REFERENCES `order` (`id`,`version_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk.order_address.salutation_id` FOREIGN KEY (`salutation_id`) REFERENCES `salutation` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `order_customer` (
    `id` BINARY(16) NOT NULL,
    `version_id` BINARY(16) NOT NULL,
    `customer_id` BINARY(16) NULL,
    `order_id` BINARY(16) NOT NULL,
    `order_version_id` BINARY(16) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `salutation_id` BINARY(16) NOT NULL,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `company` VARCHAR(255) NULL,
    `title` VARCHAR(255) NULL,
    `vat_ids` JSON NULL,
    `customer_number` VARCHAR(255) NULL,
    `custom_fields` JSON NULL,
    `remote_address` VARCHAR(255) NULL,
    `created_at` DATETIME(3) NOT NULL,
    `updated_at` DATETIME(3) NULL,
    PRIMARY KEY (`id`,`version_id`),
    CONSTRAINT `json.order_customer.vat_ids` CHECK (JSON_VALID(`vat_ids`)),
    CONSTRAINT `json.order_customer.custom_fields` CHECK (JSON_VALID(`custom_fields`)),
    KEY `fk.order_customer.customer_id` (`customer_id`),
    KEY `fk.order_customer.salutation_id` (`salutation_id`),
    CONSTRAINT `fk.order_customer.customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order_customer.salutation_id` FOREIGN KEY (`salutation_id`) REFERENCES `salutation` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `order_delivery` (
    `id` BINARY(16) NOT NULL,
    `version_id` BINARY(16) NOT NULL,
    `order_id` BINARY(16) NOT NULL,
    `order_version_id` BINARY(16) NOT NULL,
    `shipping_order_address_id` BINARY(16) NOT NULL,
    `shipping_order_address_version_id` BINARY(16) NOT NULL,
    `shipping_method_id` BINARY(16) NOT NULL,
    `state_id` BINARY(16) NOT NULL,
    `tracking_codes` JSON NOT NULL,
    `shipping_date_earliest` DATETIME(3) NOT NULL,
    `shipping_date_latest` DATETIME(3) NOT NULL,
    `shipping_costs` JSON NULL,
    `custom_fields` JSON NULL,
    `created_at` DATETIME(3) NOT NULL,
    `updated_at` DATETIME(3) NULL,
    PRIMARY KEY (`id`,`version_id`),
    CONSTRAINT `json.order_delivery.tracking_codes` CHECK (JSON_VALID(`tracking_codes`)),
    CONSTRAINT `json.order_delivery.shipping_costs` CHECK (JSON_VALID(`shipping_costs`)),
    CONSTRAINT `json.order_delivery.custom_fields` CHECK (JSON_VALID(`custom_fields`)),
    KEY `fk.order_delivery.state_id` (`state_id`),
    KEY `fk.order_delivery.order_id` (`order_id`,`order_version_id`),
    KEY `fk.order_delivery.shipping_order_address_id` (`shipping_order_address_id`,`shipping_order_address_version_id`),
    KEY `fk.order_delivery.shipping_method_id` (`shipping_method_id`),
    CONSTRAINT `fk.order_delivery.state_id` FOREIGN KEY (`state_id`) REFERENCES `state_machine_state` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order_delivery.order_id` FOREIGN KEY (`order_id`,`order_version_id`) REFERENCES `order` (`id`,`version_id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order_delivery.shipping_order_address_id` FOREIGN KEY (`shipping_order_address_id`,`shipping_order_address_version_id`) REFERENCES `order_address` (`id`,`version_id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order_delivery.shipping_method_id` FOREIGN KEY (`shipping_method_id`) REFERENCES `shipping_method` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `order_delivery_position` (
    `id` BINARY(16) NOT NULL,
    `version_id` BINARY(16) NOT NULL,
    `order_delivery_id` BINARY(16) NOT NULL,
    `order_delivery_version_id` BINARY(16) NOT NULL,
    `order_line_item_id` BINARY(16) NOT NULL,
    `order_line_item_version_id` BINARY(16) NOT NULL,
    `price` JSON NULL,
    `unit_price` DOUBLE NULL,
    `total_price` DOUBLE NULL,
    `quantity` INT(11) NULL,
    `custom_fields` JSON NULL,
    `created_at` DATETIME(3) NOT NULL,
    `updated_at` DATETIME(3) NULL,
    PRIMARY KEY (`id`,`version_id`),
    CONSTRAINT `json.order_delivery_position.price` CHECK (JSON_VALID(`price`)),
    CONSTRAINT `json.order_delivery_position.custom_fields` CHECK (JSON_VALID(`custom_fields`)),
    KEY `fk.order_delivery_position.order_delivery_id` (`order_delivery_id`,`order_delivery_version_id`),
    KEY `fk.order_delivery_position.order_line_item_id` (`order_line_item_id`,`order_line_item_version_id`),
    CONSTRAINT `fk.order_delivery_position.order_delivery_id` FOREIGN KEY (`order_delivery_id`,`order_delivery_version_id`) REFERENCES `order_delivery` (`id`,`version_id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order_delivery_position.order_line_item_id` FOREIGN KEY (`order_line_item_id`,`order_line_item_version_id`) REFERENCES `order_line_item` (`id`,`version_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `order_line_item` (
    `id` BINARY(16) NOT NULL,
    `version_id` BINARY(16) NOT NULL,
    `order_id` BINARY(16) NOT NULL,
    `order_version_id` BINARY(16) NOT NULL,
    `product_id` BINARY(16) NULL,
    `product_version_id` BINARY(16) NOT NULL,
    `promotion_id` BINARY(16) NULL,
    `parent_id` BINARY(16) NULL,
    `parent_version_id` BINARY(16) NOT NULL,
    `cover_id` BINARY(16) NULL,
    `identifier` VARCHAR(255) NOT NULL,
    `referenced_id` VARCHAR(255) NULL,
    `quantity` INT(11) NOT NULL,
    `label` VARCHAR(255) NOT NULL,
    `payload` JSON NULL,
    `good` TINYINT(1) NULL DEFAULT '0',
    `removable` TINYINT(1) NULL DEFAULT '0',
    `stackable` TINYINT(1) NULL DEFAULT '0',
    `position` INT(11) NOT NULL,
    `states` JSON NOT NULL,
    `price` JSON NOT NULL,
    `price_definition` JSON NULL,
    `unit_price` DOUBLE NULL,
    `total_price` DOUBLE NULL,
    `description` LONGTEXT NULL,
    `type` VARCHAR(255) NULL,
    `custom_fields` JSON NULL,
    `created_at` DATETIME(3) NOT NULL,
    `updated_at` DATETIME(3) NULL,
    PRIMARY KEY (`id`,`version_id`),
    CONSTRAINT `json.order_line_item.payload` CHECK (JSON_VALID(`payload`)),
    CONSTRAINT `json.order_line_item.states` CHECK (JSON_VALID(`states`)),
    CONSTRAINT `json.order_line_item.price` CHECK (JSON_VALID(`price`)),
    CONSTRAINT `json.order_line_item.price_definition` CHECK (JSON_VALID(`price_definition`)),
    CONSTRAINT `json.order_line_item.custom_fields` CHECK (JSON_VALID(`custom_fields`)),
    KEY `fk.order_line_item.cover_id` (`cover_id`),
    KEY `fk.order_line_item.order_id` (`order_id`,`order_version_id`),
    KEY `fk.order_line_item.product_id` (`product_id`,`product_version_id`),
    KEY `fk.order_line_item.promotion_id` (`promotion_id`),
    KEY `fk.order_line_item.parent_id` (`parent_id`,`version_id`),
    CONSTRAINT `fk.order_line_item.cover_id` FOREIGN KEY (`cover_id`) REFERENCES `media` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order_line_item.order_id` FOREIGN KEY (`order_id`,`order_version_id`) REFERENCES `order` (`id`,`version_id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order_line_item.product_id` FOREIGN KEY (`product_id`,`product_version_id`) REFERENCES `product` (`id`,`version_id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order_line_item.promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `promotion` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order_line_item.parent_id` FOREIGN KEY (`parent_id`,`version_id`) REFERENCES `order_line_item` (`id`,`version_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `order_line_item_download` (
    `id` BINARY(16) NOT NULL,
    `version_id` BINARY(16) NOT NULL,
    `order_line_item_id` BINARY(16) NOT NULL,
    `order_line_item_version_id` BINARY(16) NOT NULL,
    `media_id` BINARY(16) NOT NULL,
    `position` INT(11) NOT NULL,
    `access_granted` TINYINT(1) NOT NULL DEFAULT '0',
    `custom_fields` JSON NULL,
    `created_at` DATETIME(3) NOT NULL,
    `updated_at` DATETIME(3) NULL,
    PRIMARY KEY (`id`,`version_id`),
    CONSTRAINT `json.order_line_item_download.custom_fields` CHECK (JSON_VALID(`custom_fields`)),
    KEY `fk.order_line_item_download.order_line_item_id` (`order_line_item_id`,`order_line_item_version_id`),
    KEY `fk.order_line_item_download.media_id` (`media_id`),
    CONSTRAINT `fk.order_line_item_download.order_line_item_id` FOREIGN KEY (`order_line_item_id`,`order_line_item_version_id`) REFERENCES `order_line_item` (`id`,`version_id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order_line_item_download.media_id` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `order_tag` (
    `order_id` BINARY(16) NOT NULL,
    `order_version_id` BINARY(16) NOT NULL,
    `tag_id` BINARY(16) NOT NULL,
    PRIMARY KEY (`order_id`,`order_version_id`,`tag_id`),
    KEY `fk.order_tag.order_id` (`order_id`,`order_version_id`),
    KEY `fk.order_tag.tag_id` (`tag_id`),
    CONSTRAINT `fk.order_tag.order_id` FOREIGN KEY (`order_id`,`order_version_id`) REFERENCES `order` (`id`,`version_id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order_tag.tag_id` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `order_transaction` (
    `id` BINARY(16) NOT NULL,
    `version_id` BINARY(16) NOT NULL,
    `order_id` BINARY(16) NOT NULL,
    `order_version_id` BINARY(16) NOT NULL,
    `payment_method_id` BINARY(16) NOT NULL,
    `amount` JSON NOT NULL,
    `state_id` BINARY(16) NOT NULL,
    `custom_fields` JSON NULL,
    `created_at` DATETIME(3) NOT NULL,
    `updated_at` DATETIME(3) NULL,
    PRIMARY KEY (`id`,`version_id`),
    CONSTRAINT `json.order_transaction.amount` CHECK (JSON_VALID(`amount`)),
    CONSTRAINT `json.order_transaction.custom_fields` CHECK (JSON_VALID(`custom_fields`)),
    KEY `fk.order_transaction.state_id` (`state_id`),
    KEY `fk.order_transaction.order_id` (`order_id`,`order_version_id`),
    KEY `fk.order_transaction.payment_method_id` (`payment_method_id`),
    CONSTRAINT `fk.order_transaction.state_id` FOREIGN KEY (`state_id`) REFERENCES `state_machine_state` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order_transaction.order_id` FOREIGN KEY (`order_id`,`order_version_id`) REFERENCES `order` (`id`,`version_id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order_transaction.payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `order_transaction_capture` (
    `id` BINARY(16) NOT NULL,
    `order_transaction_id` BINARY(16) NOT NULL,
    `order_transaction_version_id` BINARY(16) NOT NULL,
    `state_id` BINARY(16) NOT NULL,
    `external_reference` VARCHAR(255) NULL,
    `amount` JSON NOT NULL,
    `custom_fields` JSON NULL,
    `created_at` DATETIME(3) NOT NULL,
    `updated_at` DATETIME(3) NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `json.order_transaction_capture.amount` CHECK (JSON_VALID(`amount`)),
    CONSTRAINT `json.order_transaction_capture.custom_fields` CHECK (JSON_VALID(`custom_fields`)),
    KEY `fk.order_transaction_capture.state_id` (`state_id`),
    KEY `fk.order_transaction_capture.order_transaction_id` (`order_transaction_id`,`order_transaction_version_id`),
    CONSTRAINT `fk.order_transaction_capture.state_id` FOREIGN KEY (`state_id`) REFERENCES `state_machine_state` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order_transaction_capture.order_transaction_id` FOREIGN KEY (`order_transaction_id`,`order_transaction_version_id`) REFERENCES `order_transaction` (`id`,`version_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `order_transaction_capture_refund` (
    `id` BINARY(16) NOT NULL,
    `capture_id` BINARY(16) NOT NULL,
    `state_id` BINARY(16) NOT NULL,
    `external_reference` VARCHAR(255) NULL,
    `reason` VARCHAR(255) NULL,
    `amount` JSON NOT NULL,
    `custom_fields` JSON NULL,
    `created_at` DATETIME(3) NOT NULL,
    `updated_at` DATETIME(3) NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `json.order_transaction_capture_refund.amount` CHECK (JSON_VALID(`amount`)),
    CONSTRAINT `json.order_transaction_capture_refund.custom_fields` CHECK (JSON_VALID(`custom_fields`)),
    KEY `fk.order_transaction_capture_refund.state_id` (`state_id`),
    KEY `fk.order_transaction_capture_refund.capture_id` (`capture_id`),
    CONSTRAINT `fk.order_transaction_capture_refund.state_id` FOREIGN KEY (`state_id`) REFERENCES `state_machine_state` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order_transaction_capture_refund.capture_id` FOREIGN KEY (`capture_id`) REFERENCES `order_transaction_capture` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `order_transaction_capture_refund_position` (
    `id` BINARY(16) NOT NULL,
    `refund_id` BINARY(16) NOT NULL,
    `order_line_item_id` BINARY(16) NOT NULL,
    `order_line_item_version_id` BINARY(16) NOT NULL,
    `external_reference` VARCHAR(255) NULL,
    `reason` VARCHAR(255) NULL,
    `quantity` INT(11) NULL,
    `amount` JSON NOT NULL,
    `custom_fields` JSON NULL,
    `created_at` DATETIME(3) NOT NULL,
    `updated_at` DATETIME(3) NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `json.order_transaction_capture_refund_position.amount` CHECK (JSON_VALID(`amount`)),
    CONSTRAINT `json.order_transaction_capture_refund_position.custom_fields` CHECK (JSON_VALID(`custom_fields`)),
    KEY `fk.order_transaction_capture_refund_position.order_line_item_id` (`order_line_item_id`,`order_line_item_version_id`),
    KEY `fk.order_transaction_capture_refund_position.order_transaction_capture_refund.id` (`order_transaction_capture_refund.id`),
    CONSTRAINT `fk.order_transaction_capture_refund_position.order_line_item_id` FOREIGN KEY (`order_line_item_id`,`order_line_item_version_id`) REFERENCES `order_line_item` (`id`,`version_id`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk.order_transaction_capture_refund_position.order_transaction_capture_refund.id` FOREIGN KEY (`order_transaction_capture_refund.id`) REFERENCES `order_transaction_capture_refund` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;