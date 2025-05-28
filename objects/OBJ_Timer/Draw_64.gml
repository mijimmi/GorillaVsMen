draw_set_font(FNT_Main_Large);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

function draw_text_outline(x, y, str, main_col, outline_col, outline_size) {
    draw_set_color(outline_col);
    draw_text(x - outline_size, y, str);
    draw_text(x + outline_size, y, str);
    draw_text(x, y - outline_size, str);
    draw_text(x, y + outline_size, str);
    draw_text(x - outline_size, y - outline_size, str);
    draw_text(x + outline_size, y - outline_size, str);
    draw_text(x - outline_size, y + outline_size, str);
    draw_text(x + outline_size, y + outline_size, str);

    draw_set_color(main_col);
    draw_text(x, y, str);
}

var tx = gui_w * 0.5;
var ty = 60;

// Hide timer during round complete screen
if (state == GameState.ROUND_COMPLETE) {
    draw_set_alpha(fade_alpha);
    draw_set_font(FNT_Main_XL);
    var mid_y = gui_h * 0.5;
    draw_text_outline(tx, mid_y, "Round Complete", c_white, c_black, 4);
    draw_set_alpha(1);
    exit;
}

// Hide timer during any boss fight (miniboss or final boss)
if (global.boss_fight_active) {
    exit;
}

// Draw timer for regular rounds
var total_seconds = ceil(time_left / fs);
var minutes = total_seconds div 60;
var seconds = total_seconds mod 60;
var seconds_str = (seconds < 10) ? "0" + string(seconds) : string(seconds);
var time_string = string(minutes) + ":" + seconds_str;
var display_text = "Round " + string(global.round_num) + "  " + time_string;

var scale = 3;
var alpha = 0.8;

draw_sprite_ext(SPR_TimerBG, 0, tx, ty, scale, scale, 0, c_white, alpha);
draw_text_outline(tx, ty, display_text, c_white, c_black, 4);
