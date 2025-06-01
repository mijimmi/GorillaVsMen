// OBJ_MenuAudio Step Event
if (room != Menu) {
    if (audio_is_playing(global.menu_bgm)) {
        audio_stop_sound(global.menu_bgm);
        global.menu_bgm = -1;
    }
    instance_destroy();
}