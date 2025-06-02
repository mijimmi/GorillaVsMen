
// define the global variable first
if (!variable_global_exists("end_bgm")) {
    global.end_bgm = -1;
}

// now it's safe to check and play the sound
if (!audio_is_playing(global.end_bgm)) {
    global.end_bgm = audio_play_sound(SND_Ending, 1, true);

    if (global.end_bgm != -1) {
        audio_sound_gain(global.end_bgm, 0.8, 0); // Set initial volume
    } else {
        show_debug_message("❌ End BGM failed to play");
    }
}