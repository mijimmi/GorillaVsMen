fs = game_get_speed(gamespeed_fps);

switch (state) {
    case GameState.ROUND_ACTIVE:
        time_left--;

        if (time_left <= 0) {
            time_left = 0;
            state = GameState.ROUND_COMPLETE;
            wait_counter = wait_timer;
            fade_alpha = 0;
        }
        break;

    case GameState.ROUND_COMPLETE:
        fade_alpha = clamp(fade_alpha + (1 / fs), 0, 1);
        wait_counter--;

        if (wait_counter <= 0) {
            state = GameState.WAITING_NEXT_ROUND;
        }
        break;

    case GameState.WAITING_NEXT_ROUND:
        round_num += 1;
        time_left = 60 * fs;
        fade_alpha = 0;
        state = GameState.ROUND_ACTIVE;
        break;
}
