var radius = max(sprite_width, sprite_height) * 0.5 * image_xscale;

with (OBJ_ParentEnemy) {
    if (distance_to_object(other) < radius) {
        var dir = point_direction(other.x, other.y, x, y);
        knockback_x = lengthdir_x(2, dir);
        knockback_y = lengthdir_y(2, dir);
        knockback_timer = knockback_duration;
    }
}
