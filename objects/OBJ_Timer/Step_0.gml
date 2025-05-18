if (round_complete) {
    fade_alpha = clamp(fade_alpha + (1 / room_speed), 0, 1); // fade over 1 second

    wait_counter--;

    if (wait_counter <= 0) {
        round_num += 1;
        time_left = 60 * room_speed;
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