// DRAW EVENT:
if (rocket_state == "warning") {
    // Only show red indicator for non-boss AOE rockets
    if (!is_boss_aoe) {
        // Fade in red horizontal oval indicator (narrower)
        draw_set_alpha(warning_alpha);
        draw_set_color(c_red);
        draw_ellipse(x - aoe_radius, y - aoe_radius/3, x + aoe_radius, y + aoe_radius/3, false);
        draw_set_alpha(1);  // Reset alpha
    }
} else if (rocket_state == "active") {
	with (OBJ_CameraController) {
		            shake_timer = 12;
		            shake_magnitude = 5;
		        }
    // Calculate scale to match the red oval size
    var exp_width = sprite_get_width(explosion_sprite);
    var exp_height = sprite_get_height(explosion_sprite);
    
    // Scale to match the oval dimensions (aoe_radius * 2 for width, aoe_radius for height)
    var scale_x = (aoe_radius * 2) / exp_width;
    var scale_y = aoe_radius / exp_height;
    
    // Draw explosion sprite scaled to match the red oval area
    draw_sprite_ext(explosion_sprite, explosion_image_index, x, y, scale_x, scale_y, 0, c_white, 1);
}