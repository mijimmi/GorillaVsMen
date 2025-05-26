draw_set_alpha(alpha);
draw_set_color(damage_color);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(FNT_Subfont);
draw_text(x, y, text);
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(-1); // reset to default font