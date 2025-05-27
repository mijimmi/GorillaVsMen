event_inherited();

if (instance_exists(enemy_parent)) {
    if (place_meeting(x, y, OBJ_Gorilla)) {
        with (instance_place(x, y, OBJ_Gorilla)) {
            if (!invincible) {
                hp -= other.damage;
                invincible = true;
                invincibility_timer = other.cooldown;
            }
        }
    }
}
