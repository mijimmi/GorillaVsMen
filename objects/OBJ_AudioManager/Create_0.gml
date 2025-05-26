randomize();
if (!variable_global_exists("bgm") || !audio_is_playing(global.bgm)) {
    
    var _tracks = [SND_BGM_Mario, SND_BGM_FFVI, SND_BGM_Desert];

    if (!variable_global_exists("last_bgm_track")) {
        global.last_bgm_track = -1;
    }

    var _available = [];
    for (var i = 0; i < array_length(_tracks); i++) {
        if (global.last_bgm_track == -1 || _tracks[i] != global.last_bgm_track) {
            array_push(_available, _tracks[i]);
        }
    }

    var _chosen_track = _available[irandom(array_length(_available) - 1)];

    global.bgm = audio_play_sound(_chosen_track, 1, true);
    audio_sound_gain(global.bgm, 0.15, 0);

    global.last_bgm_track = _chosen_track;
}
