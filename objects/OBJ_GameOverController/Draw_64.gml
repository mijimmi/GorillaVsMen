if (global.game_over) {
    if (!variable_global_exists("game_over_alpha")) {
        global.game_over_alpha = 0;
    }

    global.game_over_alpha = clamp(global.game_over_alpha + 0.01, 0, 1);

    var _cx = display_get_gui_width() / 2;
    var _cy = display_get_gui_height() / 2;

    draw_set_alpha(global.game_over_alpha);

    if (variable_global_exists("chosen_game_over_sprite")) {
		draw_sprite(global.chosen_game_over_sprite, 0, _cx, _cy);
	}

    if (global.game_over_alpha >= 1) {
	    draw_set_halign(fa_center);
	    draw_set_valign(fa_top);
	    draw_set_color(c_white);
	    draw_text(_cx, _cy + 125, "Press R to Restart");
	}

    draw_set_alpha(1);
}
