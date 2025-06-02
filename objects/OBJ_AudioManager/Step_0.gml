// --- Game Over Music Logic ---
if (global.game_over) {
    // Only trigger once
    if (!global.bgm_gameover_played) {
        global.bgm_gameover_played = true;

        // Fade out current BGM
        if (audio_is_playing(global.bgm)) {
            audio_sound_gain(global.bgm, 0, 1000); // fade out over 1 second
        }

        // Delay game over music by setting negative timer (approx 1 second at 60fps)
        global.bgm_timer = -60;
    }

    // After delay, play game over music once
    if (global.bgm_timer == 0) {
        global.bgm = audio_play_sound(global.bgm_gameover, 1, false); // play once
        audio_sound_gain(global.bgm, 0.2, 0); // play at full volume
    }

    global.bgm_timer++;
    exit; // stop regular BGM cycling
}

// --- Game Winner Music Logic ---
if (!global.finalboss_alive) {
    // Only trigger once
    if (!global.bgm_winner_played) {
        global.bgm_winner_played = true;

        // Fade out current BGM
        if (audio_is_playing(global.bgm)) {
            audio_sound_gain(global.bgm, 0, 1000); // fade out over 1 second
        }

        // Delay winner music by setting negative timer
        global.bgm_timer = -60;
    }

    // After delay, play winner music once
    if (global.bgm_timer == 0) {
        global.bgm = audio_play_sound(global.bgm_winner, 1, false); // play once
        audio_sound_gain(global.bgm, 0.2, 0);
    }

    global.bgm_timer++;
    exit; // stop regular BGM cycling
}


// Increment timer
global.bgm_timer++;

// Time to switch BGM?
if (global.bgm_timer >= global.bgm_duration) {
    global.bgm_timer = 0;

    // Fade out current song (over 1 second)
    if (audio_is_playing(global.bgm)) {
        audio_sound_gain(global.bgm, 0, 1000); // fade out to volume 0 over 1000 ms
    }

    // Build list of available tracks (exclude last played)
    var available = [];
    for (var i = 0; i < array_length(global.bgm_tracks); i++) {
        if (global.bgm_tracks[i] != global.last_bgm_track) {
            array_push(available, global.bgm_tracks[i]);
        }
    }

    // Pick a new track
    var chosen = available[irandom(array_length(available) - 1)];

    // Wait for fade-out duration (1000ms) before starting the next track
    // Since GameMaker doesn't support true waiting without alarms or coroutines,
    // we start playing immediately but mute it, and fade it in over 1000ms
    global.bgm = audio_play_sound(chosen, 1, true);

    if (global.bgm != -1) {
        // Start silent and fade in to target volume (0.15)
        audio_sound_gain(global.bgm, 0, 0);              // Start at volume 0
        audio_sound_gain(global.bgm, 0.15, 1000);        // Fade to 0.15 over 1 second
        global.last_bgm_track = chosen;
    } else {
        show_debug_message("❌ Failed to play BGM: " + string(chosen));
    }
}
