spawn_timer = 0;
spawn_delay = 120; // 2 seconds default (60 = 1 sec)

enemy_tiers = [
    [OBJ_Caveman],                                          // Round 1–2
    [OBJ_Caveman, OBJ_Roman],                               // Round 3–4
    [OBJ_Caveman, OBJ_Roman, OBJ_Knight],                   // Round 5–6
    [OBJ_Caveman, OBJ_Roman, OBJ_Knight, OBJ_Musketeer],    // Round 7–8
    [OBJ_Caveman, OBJ_Roman, OBJ_Knight, OBJ_Musketeer, OBJ_Soldier] // Round 9–10
];

spawn_area_min_x = 64;
spawn_area_max_x = room_width - 64;
spawn_area_min_y = 64;
spawn_area_max_y = room_height - 64;

//  delay between spawns, to be recalculated based on round
base_spawn_delay = 180;  // in frames
min_spawn_delay = 60;    // never go below this