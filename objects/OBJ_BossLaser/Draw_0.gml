var directions = [0, 90, 180, 270];

// Different visuals based on state
if (laser_state == "warning") {
    // Thin indicator lines
    for (var i = 0; i < array_length(directions); i++) {
        var dir = angle + directions[i];
        var lx = x + lengthdir_x(1000, dir);
        var ly = y + lengthdir_y(1000, dir);
        
        draw_set_color(c_yellow);
        draw_line_width(x, y, lx, ly, 1);  // Thin warning line
    }
} else if (laser_state == "active") {
    // Thick damage laser
    for (var i = 0; i < array_length(directions); i++) {
        var dir = angle + directions[i];
        var lx = x + lengthdir_x(1000, dir);
        var ly = y + lengthdir_y(1000, dir);
        
        draw_set_color(c_red);
        draw_line_width(x, y, lx, ly, 8);  // Thick border
        draw_set_color(c_white);
        draw_line_width(x, y, lx, ly, 5);  // Thick center
    }
}
// During cooldown, laser object doesn't exist so nothing is drawn