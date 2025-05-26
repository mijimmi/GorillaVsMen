// Only play music if it hasn't been initialized yet
if (!variable_global_exists("bgm") || !audio_is_playing(global.bgm)) {
    global.bgm = audio_play_sound(SND_BGM_Main, 1, true); // Loop = true
    audio_sound_gain(global.bgm, 0.2, 0); // Optional: set volume
}