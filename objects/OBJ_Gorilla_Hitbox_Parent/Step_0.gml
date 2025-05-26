// Calculate radius of the hitbox itself
var r = max(sprite_width, sprite_height) * 0.5 * image_xscale;

// Loop through enemies and apply knockback + damage
with (OBJ_ParentEnemy) {
    if (distance_to_object(other) < r) {
        var dir = point_direction(other.x, other.y, x, y);
        knockback_x = lengthdir_x(2, dir);
        knockback_y = lengthdir_y(2, dir);
        knockback_timer = knockback_duration;

        // Deal damage from hitbox to this enemy
        damage_entity(id, other.id, other.damage);
    }
}
