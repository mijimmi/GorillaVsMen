if (flash_timer > 0) {
	draw_set_alpha((flash_timer / 30) * 0.2);; // fade out over time (30 frames = 1 second)
    draw_set_color(flash_color);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1); // reset alpha
    draw_set_color(c_white); // reset color
    flash_timer--;
}