if (!instance_exists(OBJ_FinalBoss)) exit;

var boss = instance_find(OBJ_FinalBoss, 0);

// Get GUI dimensions
var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

// Calculate health bar dimensions with margins
var bar_width = gui_width - (side_margin * 2);
var bar_height = 130;  // Adjust this value to change height

// Position health bar at bottom center of screen
healthbar_x = side_margin;
healthbar_y = gui_height - bottom_margin;

// Calculate health ratio
var hp_ratio = clamp(boss.hp / boss.hp_max, 0, 1);

// 1) Draw background (bottom layer) - stretched across screen
draw_sprite_stretched(SPR_Godzilla_HealthBG, 0, healthbar_x, healthbar_y, bar_width, bar_height);

// 2) Draw health fill (middle layer) - stretched based on HP
var health_width = bar_width * hp_ratio;
draw_sprite_stretched(SPR_Godzilla_Health, 0, healthbar_x, healthbar_y, health_width, bar_height);

// 3) Draw cover/border (top layer) - stretched across screen
draw_sprite_stretched(SPR_Godzilla_HealthCover, 0, healthbar_x, healthbar_y, bar_width, bar_height);

// Optional: Draw boss name/health text
draw_set_font(FNT_Main_Large);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);

// Boss name at left margin above health bar with black border
// Draw black border (offset in 8 directions)
draw_set_color(c_black);
for (var xx = -1; xx <= 1; xx++) {
    for (var yy = -1; yy <= 1; yy++) {
        if (xx != 0 || yy != 0) {
            draw_text(healthbar_x + xx, healthbar_y  + yy, "GODZILLA");
        }
    }
}
// Draw white text on top
draw_set_color(c_white);
draw_text(healthbar_x, healthbar_y , "GODZILLA");
