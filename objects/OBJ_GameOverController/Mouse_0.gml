if (visible) {
    var btn_x = display_get_gui_width() / 2 - 50;
    var btn_y = display_get_gui_height() / 2 + 80;

    if (mouse_x >= btn_x && mouse_x <= btn_x + 100 &&
        mouse_y >= btn_y && mouse_y <= btn_y + 30) {
        room_goto(RM_Menu); // Replace with your main menu room name
    }
	if (visible) {
	    if (keyboard_check_pressed(ord("R"))) {
			global.game_over = false;
	        room_restart();
	    }
	}
}
