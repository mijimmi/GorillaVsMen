// Loop through all enemies touching this hitbox
with (OBJ_ParentEnemy) {
    if (place_meeting(x, y, other)) {
        // Check if this enemy has already been hit
        if (ds_list_find_index(other.hit_list, id) == -1) {
            var dir = point_direction(other.x, other.y, x, y);
            knockback_x = lengthdir_x(2, dir);
            knockback_y = lengthdir_y(2, dir);
            knockback_timer = knockback_duration;

            damage_entity(id, other.id, other.damage);
            ds_list_add(other.hit_list, id);
        }
    }
}
