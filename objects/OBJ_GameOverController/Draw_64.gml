if (global.game_over) {
    // Initialize the alpha if not yet created
    if (!variable_global_exists("game_over_alpha")) {
        global.game_over_alpha = 0;
    }

    // Increase alpha gradually
    global.game_over_alpha = clamp(global.game_over_alpha + 0.01, 0, 1);

    var _cx = display_get_gui_width() / 2;
    var _cy = display_get_gui_height() / 2;

    // Set alpha for fading effect
    draw_set_alpha(global.game_over_alpha);

    // Draw the "You Died" sprite with fade-in
    draw_sprite(SPR_YouDied, 0, _cx, _cy);

    // Draw the restart message with same fade-in
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_text(_cx, _cy + 125, "Press R to Restart");

    // Reset alpha back to full after drawing
    draw_set_alpha(1);
}
