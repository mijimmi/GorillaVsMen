// Check if owner still exists
if (!instance_exists(owner)) {
    instance_destroy();
    exit;
}

// Handle warning fade-in effect
if (rocket_state == "warning") {
    warning_alpha = min(warning_alpha + 0.02, 1);  // Fade in over time
}

// Handle active state
if (rocket_state == "active") {
    // Increment damage timer
    damage_timer++;
    
    // Only deal damage for a brief window (adjust frames as needed)
    // This gives a 10-frame window for damage (about 1/6 second at 60fps)
    if (damage_timer <= 10 && !damage_dealt) {
        // Check collision with Gorilla using oval/ellipse collision
        if (instance_exists(OBJ_Gorilla)) {
            // Calculate relative position
            var rel_x = OBJ_Gorilla.x - x;
            var rel_y = OBJ_Gorilla.y - y;
            
            // Ellipse collision detection - FIXED TO MATCH DRAW EVENT
            // For horizontal oval: width = aoe_radius*2, height = (aoe_radius/3)*2
            var ellipse_width = aoe_radius;  // Radius, not diameter
            var ellipse_height = aoe_radius / 3;  // Height radius (matches draw event)
            
            // Normalize coordinates to unit circle
            var norm_x = rel_x / ellipse_width;
            var norm_y = rel_y / ellipse_height;
            
            // Check if point is inside ellipse (distance from center <= 1)
            var ellipse_distance = sqrt(norm_x * norm_x + norm_y * norm_y);
            
            if (ellipse_distance <= 1) {
                with (OBJ_Gorilla) {
                    gorilla_take_damage(50, other.x, other.y);
                }
                damage_dealt = true;  // Mark damage as dealt
            }
        }
    }
    
    // Advance explosion animation manually at slower speed
    explosion_image_index += explosion_image_speed;
    
    // Destroy the rocket when animation completes
    if (explosion_image_index >= sprite_get_number(explosion_sprite)) {
        instance_destroy();
        exit;
    }
}