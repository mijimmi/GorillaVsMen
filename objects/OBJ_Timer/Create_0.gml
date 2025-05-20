enum GameState {
    ROUND_ACTIVE,
    ROUND_COMPLETE,
    WAITING_NEXT_ROUND
}

state = GameState.ROUND_ACTIVE;

fs = game_get_speed(gamespeed_fps);
round_num = 1;
time_left = 60 * fs;

wait_timer = 4 * fs;
wait_counter = 0;
fade_alpha = 0;
