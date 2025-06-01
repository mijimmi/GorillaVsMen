// Left Down event for play button
if (audio_is_playing(global.menu_bgm)) {
    audio_stop_sound(global.menu_bgm);
    global.menu_bgm = -1;
}
room_goto(gamescreen);