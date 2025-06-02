// BGM configuration
global.bgm_tracks = [SND_BGM_Mario, SND_BGM_FFVI, SND_BGM_Desert];
global.bgm_timer = 0;
global.bgm_duration = game_get_speed(gamespeed_fps) * 124;
global.last_bgm_track = -1;

global.bgm_gameover = SND_Gameover; // <- Replace with your actual Game Over sound asset
global.bgm_gameover_played = false;     // To prevent replaying it every step

global.bgm_winner = SND_Winning_Congrats;
global.bgm_winner_played = false;

// Play first track immediately
var available = [];
randomize();
for (var i = 0; i < array_length(global.bgm_tracks); i++) {
    array_push(available, global.bgm_tracks[i]);
}

var chosen = available[irandom(array_length(available) - 1)];
global.bgm = audio_play_sound(chosen, 1, true);

if (global.bgm != -1) {
    audio_sound_gain(global.bgm, 0.15, 0);
    global.last_bgm_track = chosen;
} else {
    show_debug_message("❌ Failed to play initial BGM: " + string(chosen));
}
global.game_over = false;
