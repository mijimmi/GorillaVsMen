// Set font and alignment
draw_set_font(FNT_Main_Large);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// GUI dimensions
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

if (round_complete) {
    // Fade in the "Round Complete" message
    draw_set_alpha(fade_alpha);
    draw_set_font(FNT_Main_XL); // Bigger font for this message
    draw_text(gui_w * 0.5, gui_h * 0.5, "Round Complete");
    draw_set_alpha(1); // reset alpha for anything else
} else {
    // Timer display
    var tx = gui_w * 0.5;
    var ty = 60;

    var total_seconds = ceil(time_left / room_speed);
    var minutes = total_seconds div 60;
    var seconds = total_seconds mod 60;
    var seconds_str = (seconds < 10) ? "0" + string(seconds) : string(seconds);
    var time_string = string(minutes) + ":" + seconds_str;

    draw_text(tx, ty, "Round " + string(round_num) + "  " + time_string);
}
