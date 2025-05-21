fs = game_get_speed(gamespeed_fps);

// Pause timer logic
if (global.is_leveling_up) {
    exit;
}

switch (state) {
    case GameState.ROUND_ACTIVE:
        time_left--;

        if (time_left <= 0) {
            time_left = 0;
            state = GameState.ROUND_COMPLETE;
            wait_counter = wait_timer;
            fade_alpha = 0;
            round_end_sound_played = false;
        }
        break;

    case GameState.ROUND_COMPLETE:
        fade_alpha = clamp(fade_alpha + (1 / fs), 0, 1);

        if (!round_end_sound_played) {
            audio_play_sound(SND_Round_End, 1, false);
            round_end_sound_played = true;
        }

        wait_counter--;

        if (wait_counter <= 0) {
            state = GameState.WAITING_NEXT_ROUND;
        }
        break;

    case GameState.WAITING_NEXT_ROUND:
        round_num += 1;
        global.round_num = round_num;
        time_left = 60 * fs;
        fade_alpha = 0;
        state = GameState.ROUND_ACTIVE;
        break;
}