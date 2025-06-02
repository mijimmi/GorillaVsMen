
if (room != GameEnd) {
    if (audio_is_playing(global.end_bgm)) {
        audio_stop_sound(global.end_bgm);
        global.end_bgm = -1;
    }
    instance_destroy();
}