global.boss_fight_active = false;
global.miniboss_alive = false;

// Force the game into ROUND_COMPLETE state
with (OBJ_Timer) {
    state = GameState.ROUND_COMPLETE;
    global.state = GameState.ROUND_COMPLETE;

    time_left = 0;
    wait_counter = wait_timer;
    fade_alpha = 0;
    fade_in_alpha = 1;
    round_end_sound_played = false;
}
