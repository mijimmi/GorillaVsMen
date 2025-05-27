if (instance_exists(follow_target)) {
    x = follow_target.x;
    y = follow_target.y;
} else {
    instance_destroy(); // If the projectile dies, kill the hitbox
    exit;
}

if (instance_exists(OBJ_Gorilla)) {
    var gor = instance_nearest(x, y, OBJ_Gorilla);
    if (point_distance(x, y, gor.x, gor.y) < 12) { // Adjust radius as needed
        if (!gor.invincible) {
            gor.gorilla_take_damage(damage, x, y);
            gor.invincible = true;
            gor.invincibility_timer = invincibility_duration;
        }
    }
}
