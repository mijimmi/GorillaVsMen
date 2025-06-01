// Draw the pixelated shadow
draw_sprite_ext(SPR_Shadow, 0, x, y + 4, 1, 1, 0, c_black, 0.3);
// Then draw the sprite
draw_self();
// === Draw Tutorial Instructions ===
if (move_tutorial_alpha > 0 || attack_tutorial_alpha > 0) {
    // Get camera position for UI positioning
    var cam = view_camera[0];
    var cam_x = camera_get_view_x(cam);
    var cam_y = camera_get_view_y(cam);
    var cam_width = camera_get_view_width(cam);
    var cam_height = camera_get_view_height(cam);
    
    // Position tutorials on opposite sides of screen
    var move_tutorial_x = cam_x + cam_width * 0.3;    // Left side
    var attack_tutorial_x = cam_x + cam_width * 0.7;  // Right side
    var tutorial_y = cam_y + cam_height * 0.3;
    
    // Draw movement tutorial (left side)
    if (move_tutorial_alpha > 0) {
        var move_text = "To Move";
        var move_text_x = move_tutorial_x;
        var move_text_y = tutorial_y + 60; // Text position
        var move_sprite_y = move_text_y - 40; // Sprite positioned above text
        
        // Draw sprite above the text
        draw_sprite_ext(SPR_MoveTutorial, 0, move_tutorial_x, move_sprite_y, 1.5, 1.5, 0, c_white, move_tutorial_alpha);
        
        draw_set_font(FNT_Main);
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        
        // Draw text border (8-directional outline)
        draw_set_color(c_black);
        for (var xx = -1; xx <= 1; xx++) {
            for (var yy = -1; yy <= 1; yy++) {
                if (xx != 0 || yy != 0) {
                    draw_text(move_text_x + xx, move_text_y + yy, move_text);
                }
            }
        }
        
        // Draw the main white text on top
        draw_set_color(c_white);
        draw_set_alpha(move_tutorial_alpha);
        draw_text(move_text_x, move_text_y, move_text);
        draw_set_alpha(1.0);
    }
    
    // Draw attack tutorial (right side)
    if (attack_tutorial_alpha > 0) {
        var attack_text = "To Smash";
        var attack_text_x = attack_tutorial_x;
        var attack_text_y = tutorial_y + 60; // Text position
        var attack_sprite_y = attack_text_y - 40; // Sprite positioned above text
        
        // Draw sprite above the text
        draw_sprite_ext(SPR_ATKTutorial, 0, attack_tutorial_x, attack_sprite_y, 1.5, 1.5, 0, c_white, attack_tutorial_alpha);
        
        draw_set_font(FNT_Main);
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        
        // Draw text border (8-directional outline)
        draw_set_color(c_black);
        for (var xx = -1; xx <= 1; xx++) {
            for (var yy = -1; yy <= 1; yy++) {
                if (xx != 0 || yy != 0) {
                    draw_text(attack_text_x + xx, attack_text_y + yy, attack_text);
                }
            }
        }
        
        // Draw the main white text on top
        draw_set_color(c_white);
        draw_set_alpha(attack_tutorial_alpha);
        draw_text(attack_text_x, attack_text_y, attack_text);
        draw_set_alpha(1.0);
    }
}


// Only draw if dash skill is obtained
if (!global.has_dash) exit;
// Margins (same as UILevel)
var margin_x = 24;
var margin_y = 24;
// Get camera position
var cam = view_camera[0];
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);
var cam_height = camera_get_view_height(cam);
// Position for dash icon - bottom left with margins
var icon_x = cam_x + margin_x + 16; // +16 to center the icon within its space
var icon_y = cam_y + cam_height - margin_y - 16; // -16 to center the icon
// Draw dash icon (smaller)
draw_sprite_ext(SPR_Gorilla_Dash, 0, icon_x, icon_y, 0.5, 0.5, 0, c_white, 1);
// Draw cooldown timer overlapping the icon
if (dash_cooldown > 0) {
    var seconds = ceil(dash_cooldown / 60);
    var timer_text = string(seconds) + "s";
    
    // Set font and alignment for timer text (smaller font)
    draw_set_font(FNT_Main_Mini);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var offset = 2; // Smaller offset for mini font
    
    // Draw border (outline) for timer text
    draw_set_color(c_black);
    draw_text(icon_x - offset, icon_y, timer_text);
    draw_text(icon_x + offset, icon_y, timer_text);
    draw_text(icon_x, icon_y - offset, timer_text);
    draw_text(icon_x, icon_y + offset, timer_text);
    draw_text(icon_x - offset, icon_y - offset, timer_text);
    draw_text(icon_x + offset, icon_y - offset, timer_text);
    draw_text(icon_x - offset, icon_y + offset, timer_text);
    draw_text(icon_x + offset, icon_y + offset, timer_text);
    
    // Draw the main white timer text on top
    draw_set_color(c_white);
    draw_text(icon_x, icon_y, timer_text);
}
// Draw prompt text to the right of the icon
if (show_dash_prompt) {
    var prompt_text = "Press SPACEBAR to dash";
    var prompt_x = icon_x + 40; // Position to the right of the icon
    var prompt_y = icon_y;
    
    // Set font and alignment for prompt text (smaller font)
    draw_set_font(FNT_Main_Mini);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    
    var offset = 2; // Smaller offset for mini font
    
    // Draw border (outline) for prompt text
    draw_set_color(c_black);
    draw_text(prompt_x - offset, prompt_y, prompt_text);
    draw_text(prompt_x + offset, prompt_y, prompt_text);
    draw_text(prompt_x, prompt_y - offset, prompt_text);
    draw_text(prompt_x, prompt_y + offset, prompt_text);
    draw_text(prompt_x - offset, prompt_y - offset, prompt_text);
    draw_text(prompt_x + offset, prompt_y - offset, prompt_text);
    draw_text(prompt_x - offset, prompt_y + offset, prompt_text);
    draw_text(prompt_x + offset, prompt_y + offset, prompt_text);
    
    // Draw the main yellow prompt text on top
    draw_set_color(c_yellow);
    draw_text(prompt_x, prompt_y, prompt_text);
}
// Reset font and drawing settings
draw_set_font(-1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);