// Margins
var margin_x = 24;
var margin_y = 24;

// Position
var x_pos = margin_x;
var y_pos = margin_y;

// Set font and alignment
draw_set_font(FNT_Main_XL);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Get level text
var lvl_text = "Lvl 1";  // fallback
var gorilla_inst = instance_find(OBJ_Gorilla, 0);
if (gorilla_inst != noone) {
    lvl_text = "Lvl " + string(gorilla_inst.level);
}

// Draw border (outline) by drawing the text multiple times with an offset
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

// Draw the main white text on top
draw_set_color(c_white);
draw_text(x_pos, y_pos, lvl_text);
