if (!global.finalboss_alive) {
    if (!variable_global_exists("victory_alpha")) {
        global.victory_alpha = 0;
    }

    global.victory_alpha = clamp(global.victory_alpha + 0.01, 0, 1);

    var _cx = display_get_gui_width() / 2;
    var _cy = display_get_gui_height() / 2;

    draw_set_alpha(global.victory_alpha);

    draw_sprite(SPR_Winner, 0, _cx, _cy); // Replace with your actual sprite name

    if (global.victory_alpha >= 1) {
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        draw_set_color(c_white);
        draw_text(_cx, _cy + 125, "Press R to Restart");
    }

    draw_set_alpha(1); // Reset alpha
}
