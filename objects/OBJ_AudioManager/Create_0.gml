// Only play music if it hasn't been initialized yet
if (!variable_global_exists("bgm") || !audio_is_playing(global.bgm)) {
    
    // Define tracks
    var _tracks = [SND_BGM_Main, SND_BGM_Main2, SND_BGM_Main3];
    
    // Ensure last track is stored
    if (!variable_global_exists("last_bgm_track")) {
        global.last_bgm_track = -1; // -1 = none played yet
    }

    // Build a list excluding the last played track
    var _available = [];
    for (var i = 0; i < array_length(_tracks); i++) {
        if (_tracks[i] != global.last_bgm_track) {
            array_push(_available, _tracks[i]);
        }
    }

    // Choose one from the filtered list
    var _chosen_track = choose(_available[0], _available[1]); // now guaranteed different

    // Play the track
    global.bgm = audio_play_sound(_chosen_track, 1, true); // Loop = true
    audio_sound_gain(global.bgm, 0.15, 0); // Optional: set volume
    
    // Remember the track for next time
    global.last_bgm_track = _chosen_track;
}