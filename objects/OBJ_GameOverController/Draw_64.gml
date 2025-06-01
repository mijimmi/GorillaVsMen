if (visible) {
    var _cx = display_get_gui_width() / 2;
    var _cy = display_get_gui_height() / 2;
    draw_sprite(SPR_YouDied, 0, _cx, _cy);

	// Draw the restart message below the sprite
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_text(_cx, _cy + 125, "Press R to Restart");
}
