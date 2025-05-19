var fs = game_get_speed(gamespeed_fps);

if (round_complete) {
    fade_alpha = clamp(fade_alpha + (1 / fs), 0, 1);

    wait_counter--;

    if (wait_counter <= 0) {
        round_num += 1;
        time_left = 60 * fs;
        round_complete = false;
        fade_alpha = 0;
    }
} else {
    time_left--;

    if (time_left <= 0) {
        time_left = 0;
        round_complete = true;
        wait_counter = wait_timer;
        fade_alpha = 0;
    }
}