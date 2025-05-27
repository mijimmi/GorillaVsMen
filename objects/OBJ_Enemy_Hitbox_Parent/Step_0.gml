if (!instance_exists(enemy_parent)) {
    instance_destroy();
    exit;
}

// Follow the enemy
x = enemy_parent.x;
y = enemy_parent.y;
