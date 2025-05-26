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
