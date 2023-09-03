<?php declare(strict_types=1);

namespace Custom\BlogPlugin\Migration;

use Doctrine\DBAL\Connection;
use Shopware\Core\Framework\Migration\MigrationStep;

class Migration1693418444CustomBlogsTable extends MigrationStep
{
    public function getCreationTimestamp(): int
    {
        return 1693418444;
    }

    public function update(Connection $connection): void
    {
        $sql = '
            CREATE TABLE IF NOT EXISTS custom_blog_post (
                id BINARY(16) NOT NULL PRIMARY KEY,
                title VARCHAR(255) NOT NULL,
                content LONGTEXT,
                publish_date DATETIME,
                status VARCHAR(255) NOT NULL,
                created_at DATETIME NOT NULL,
                updated_at DATETIME NULL
            );
        ';

        $connection->executeStatement($sql);

    }

    public function updateDestructive(Connection $connection): void
    {
        $sql = 'DROP TABLE IF EXISTS custom_blog_post;';
        $connection->executeStatement($sql);
    }
}
