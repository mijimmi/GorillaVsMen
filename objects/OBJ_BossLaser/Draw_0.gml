// DRAW EVENT:
var directions = [0, 90, 180, 270];
// Calculate the visual center of the boss (since sprite origin is bottom-center)
var boss_center_x = owner.x;
var boss_center_y = owner.y - (sprite_get_height(owner.sprite_index) / 2);

// Different visuals based on state
if (laser_state == "warning") {
    // Thin indicator lines from boss visual center
    for (var i = 0; i < array_length(directions); i++) {
        var dir = angle + directions[i];
        var lx = boss_center_x + lengthdir_x(1000, dir);
        var ly = boss_center_y + lengthdir_y(1000, dir);
        
        draw_set_color(c_yellow);
        draw_line_width(boss_center_x, boss_center_y, lx, ly, 1);  // Thin warning line from boss center
    }
} else if (laser_state == "active") {
    // SPR_Lazerbeam from boss visual center
    for (var i = 0; i < array_length(directions); i++) {
        var dir = angle + directions[i];
        
        // Calculate how far the laser should extend
        var max_distance = 1000;
        
        // Calculate midpoint for sprite positioning (halfway along the laser)
        var mid_x = boss_center_x + lengthdir_x(max_distance / 2, dir);
        var mid_y = boss_center_y + lengthdir_y(max_distance / 2, dir);
        
        // Scale the sprite to extend the full distance
        var scale_x = max_distance / sprite_get_width(SPR_Lazerbeam);
        var scale_y = 0.7; // Make it thinner
        
        // Draw the laser beam sprite
        draw_sprite_ext(SPR_Lazerbeam, 0, mid_x, mid_y, scale_x, scale_y, dir, c_white, 1.0);
    }
}