draw_set_alpha(alpha);
draw_set_font(FNT_Main);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// draw black border (1px thick)
for (var i = -1; i <= 1; i++) {
    for (var j = -1; j <= 1; j++) {
        if (i != 0 || j != 0) {
            draw_set_color(c_black);
            draw_text(x + i, y + j, text);
        }
    }
}

// draw red main text
draw_set_color(c_red);
draw_text(x, y, text);

// reset
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(-1);