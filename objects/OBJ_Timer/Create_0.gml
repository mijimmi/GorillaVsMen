// Initialize game state and variables
enum GameState {
    ROUND_ACTIVE,
    ROUND_COMPLETE,
    WAITING_NEXT_ROUND
}
state = GameState.ROUND_ACTIVE;
fs = game_get_speed(gamespeed_fps);
global.state = GameState.ROUND_ACTIVE;
global.round_num = 1;
round_num = global.round_num;
time_left = 1 * fs;
wait_timer = 2 * fs;
wait_counter = 0;
fade_alpha = 0;
fade_in_alpha = 1;
round_end_sound_played = false;
global.is_leveling_up = false;
global.finalboss_alive = false;  
global.boss_fight_active = false;