if (!instance_exists(owner)) exit;

// Calculate the visual center of the boss (since sprite origin is bottom-center)
var boss_center_x = owner.x;
var boss_center_y = owner.y - (sprite_get_height(owner.sprite_index) / 2);

// Different visuals based on state
if (laser_state == "warning") {
    // Thin yellow indicator line from boss visual center to target direction
    var lx = boss_center_x + lengthdir_x(1000, target_direction);
    var ly = boss_center_y + lengthdir_y(1000, target_direction);
    
    draw_set_color(c_yellow);
    draw_line_width(boss_center_x, boss_center_y, lx, ly, 2);  // Slightly thicker warning line
    
} else if (laser_state == "active") {
    // SPR_Lazerbeam from boss visual center in target direction
    var max_distance = 1000;
    
    // Calculate midpoint for sprite positioning (halfway along the laser)
    var mid_x = boss_center_x + lengthdir_x(max_distance / 2, target_direction);
    var mid_y = boss_center_y + lengthdir_y(max_distance / 2, target_direction);
    
    // Scale the sprite to extend the full distance
    var scale_x = max_distance / sprite_get_width(SPR_Lazerbeam);
    var scale_y = 0.7; // Make it thinner (same as original)
    
    // Draw the laser beam sprite
    draw_sprite_ext(SPR_Lazerbeam, 0, mid_x, mid_y, scale_x, scale_y, target_direction, c_white, 1.0);
}