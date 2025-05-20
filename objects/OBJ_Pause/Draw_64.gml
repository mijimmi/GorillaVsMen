if (pause) {
    // Dim the screen
    draw_set_color(c_black);
    draw_set_alpha(0.5);
    draw_rectangle(0, 0, display_get_width(), display_get_height(), false);
    draw_set_alpha(1);

    // Set font and text
    var text = "PAUSED";
    var font = FNT_Main_XL;
    draw_set_font(font);
    draw_set_halign(fa_left);   // We'll handle centering manually
    draw_set_valign(fa_top);

    // Calculate exact center
    var tw = string_width(text);
    var th = string_height(text);
    var scx = 1920 / 2 - tw / 2;
    var scy = 1080 / 2 - th / 2;

    // Draw text border (5px offset in 8 directions)
    var offset = 5;
    draw_set_color(c_black);
    for (var dx = -1; dx <= 1; dx++) {
        for (var dy = -1; dy <= 1; dy++) {
            if (dx != 0 || dy != 0) {
                draw_text(scx + dx * offset, scy + dy * offset, text);
            }
        }
    }

    // Draw main white text
    draw_set_color(c_white);
    draw_text(scx, scy, text);
}
