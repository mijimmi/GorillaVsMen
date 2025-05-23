// Check for enemies in range
with (OBJ_ParentEnemy) {
    if (distance_to_object(other) < 24) { // You can tweak this radius
        // Calculate knockback direction (away from gorilla)
        var dir = point_direction(other.x, other.y, x, y);
        knockback_x = lengthdir_x(4, dir); // 4 = knockback strength
        knockback_y = lengthdir_y(4, dir);
        knockback_timer = knockback_duration;
    }
}
