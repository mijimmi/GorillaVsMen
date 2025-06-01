// OBJ_MenuAudio Create Event

// define the global variable first
if (!variable_global_exists("menu_bgm")) {
    global.menu_bgm = -1;
}

// now it's safe to check and play the sound
if (!audio_is_playing(global.menu_bgm)) {
    global.menu_bgm = audio_play_sound(SND_BGM_Menu, 1, true);

    if (global.menu_bgm != -1) {
        audio_sound_gain(global.menu_bgm, 0.8, 0); // Set initial volume
    } else {
        show_debug_message("❌ Menu BGM failed to play");
    }
}