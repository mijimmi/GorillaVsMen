if (global.game_over) {
    exit;
}

if (!global.finalboss_alive) {
	exit;
}
fs = game_get_speed(gamespeed_fps);

// Pause timer logic if leveling up
if (global.is_leveling_up) {
    exit;
}

switch (state) {

    case GameState.ROUND_ACTIVE:
        global.state = GameState.ROUND_ACTIVE;

		
		if (global.round_num == 10 && global.finalboss_alive) {
		    exit; // pause timer during final boss fight
		}
		
		// Check if final boss was killed - immediately complete the round
		if (global.round_num == 10 && !global.finalboss_alive && global.boss_fight_active) {
		    // Final boss defeated! Complete the round immediately
		    time_left = 0;
		    state = GameState.ROUND_COMPLETE;
		    wait_counter = wait_timer;
		    fade_alpha = 0;
		    round_end_sound_played = false;
		    fade_in_alpha = 1;
		    global.boss_fight_active = false; // Reset boss fight flag
		    break;
		}
        // Fade volume back up gradually over 1 second
        fade_in_alpha = clamp(fade_in_alpha - (1 / fs), 0, 1);

        if (variable_global_exists("bgm")) {
            var new_vol = lerp(0.1, 0.2, 1 - fade_in_alpha);
            audio_sound_gain(global.bgm, new_vol, 0);
        }

        time_left--;

        if (time_left <= 0) {
            time_left = 0;
            state = GameState.ROUND_COMPLETE;
            wait_counter = wait_timer;
            fade_alpha = 0;
            round_end_sound_played = false;

            fade_in_alpha = 1; // reset fade_in_alpha for next round
        }
        break;

    case GameState.ROUND_COMPLETE:
        fade_alpha = clamp(fade_alpha + (1 / fs), 0, 1);

        if (variable_global_exists("bgm")) {
            var new_vol = lerp(0.2, 0.1, fade_alpha);
            audio_sound_gain(global.bgm, new_vol, 0);
        }

        global.state = GameState.ROUND_COMPLETE;

        if (!round_end_sound_played) {
            audio_play_sound(SND_Round_End, 1, false);
            round_end_sound_played = true;

            with (OBJ_ParentEnemy) {
                instance_destroy();
            }
            with (OBJ_ExpBanana) {
                instance_destroy();
            }
            with (OBJ_HealthBanana) {
                instance_destroy();
            }
        }

        wait_counter--;

        if (wait_counter <= 0) {
            global.state = GameState.WAITING_NEXT_ROUND;
            state = GameState.WAITING_NEXT_ROUND;
        }
        break;

    case GameState.WAITING_NEXT_ROUND:
        round_num += 1;
        global.round_num = round_num;
        time_left = 60 * fs;
        fade_alpha = 0;

        fade_in_alpha = 1;

        state = GameState.ROUND_ACTIVE;

        // Reset enemy spawner timers to spawn immediately
        with (OBJ_EnemySpawner) {
            spawn_timer = 0;
        }
        break;
}
