// Check if owner still exists
if (!instance_exists(owner)) {
    instance_destroy();
    exit;
}

// Handle warning fade-in effect
if (rocket_state == "warning") {
    warning_alpha = min(warning_alpha + 0.02, 1);  // Fade in over time
}

// Only do damage during active state
if (rocket_state == "active") {
    // Check collision with Gorilla
    if (instance_exists(OBJ_Gorilla)) {
        var dist = point_distance(x, y, OBJ_Gorilla.x, OBJ_Gorilla.y);
        if (dist <= aoe_radius) {
            with (OBJ_Gorilla) {
			    gorilla_take_damage(50, other.x, other.y);
			}
        }
    }
}