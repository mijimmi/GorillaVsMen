fs = game_get_speed(gamespeed_fps);

// Pause timer logic if leveling up
if (global.is_leveling_up) {
    exit;
}

switch (state) {
    // 1. Round is active
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

    // 2. Round just ended
    case GameState.ROUND_COMPLETE:
        fade_alpha = clamp(fade_alpha + (1 / fs), 0, 1);

        if (!round_end_sound_played) {
            audio_play_sound(SND_Round_End, 1, false);
            round_end_sound_played = true;

            with (OBJ_ParentEnemy) {
                instance_destroy();
            }
        }

        wait_counter--;

        if (wait_counter <= 0) {
            state = GameState.WAITING_NEXT_ROUND;
        }
        break;

    // 3. Waiting for next round to begin
    case GameState.WAITING_NEXT_ROUND:
        round_num += 1;
        global.round_num = round_num;
        time_left = 60 * fs;
        fade_alpha = 0;
        state = GameState.ROUND_ACTIVE;

        // Reset all enemy spawner timers to spawn immediately
        with (OBJ_EnemySpawner) {
            spawn_timer = 0;
        }
        break;
}
