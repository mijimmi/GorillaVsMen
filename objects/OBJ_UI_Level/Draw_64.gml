// Margins
var margin_x = 24;
var margin_y = 24;

// Position for level text
var x_pos = margin_x;
var y_pos = margin_y;

// Set font and alignment for level text
draw_set_font(FNT_Main_XL);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Get gorilla instance
var gorilla_inst = instance_find(OBJ_Gorilla, 0);

// Default texts
var lvl_text = "Lvl 1";
var xp_text = "XP: 0 / 100";

if (gorilla_inst != noone) {
    lvl_text = "Lvl " + string(gorilla_inst.level);
    xp_text = "XP: " + string(floor(gorilla_inst.xp)) + " / " + string(floor(gorilla_inst.required_xp));
}

// Draw border (outline) for level text
draw_set_color(c_black);
var offset = 5;
draw_text(x_pos - offset, y_pos, lvl_text);
draw_text(x_pos + offset, y_pos, lvl_text);
draw_text(x_pos, y_pos - offset, lvl_text);
draw_text(x_pos, y_pos + offset, lvl_text);
draw_text(x_pos - offset, y_pos - offset, lvl_text);
draw_text(x_pos + offset, y_pos - offset, lvl_text);
draw_text(x_pos - offset, y_pos + offset, lvl_text);
draw_text(x_pos + offset, y_pos + offset, lvl_text);

// Draw the main white level text on top
draw_set_color(c_white);
draw_text(x_pos, y_pos, lvl_text);

// Position for XP text (below level text)
var xp_y_pos = y_pos + 80; // Adjust vertical spacing as needed

// Set font and alignment for XP text
draw_set_font(FNT_Main_Large);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Draw border (outline) for XP text
draw_set_color(c_black);
draw_text(x_pos - offset, xp_y_pos, xp_text);
draw_text(x_pos + offset, xp_y_pos, xp_text);
draw_text(x_pos, xp_y_pos - offset, xp_text);
draw_text(x_pos, xp_y_pos + offset, xp_text);
draw_text(x_pos - offset, xp_y_pos - offset, xp_text);
draw_text(x_pos + offset, xp_y_pos - offset, xp_text);
draw_text(x_pos - offset, xp_y_pos + offset, xp_text);
draw_text(x_pos + offset, xp_y_pos + offset, xp_text);

// Draw the main white XP text on top
draw_set_color(c_white);
draw_text(x_pos, xp_y_pos, xp_text);

// Reset font to default (optional)
draw_set_font(-1);