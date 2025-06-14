if (!variable_global_exists("game_over")) {
    global.game_over = false;
}
if (global.game_over) {
    exit;
}
spawn_timer = 0;
spawn_delay = 120; // 2 seconds default (60 = 1 sec)
enemy_tiers = [
    [OBJ_Caveman],                                      
    [OBJ_Caveman, OBJ_Roman, OBJ_Roman_Archer],           
    [OBJ_Roman, OBJ_Knight, OBJ_Roman_Archer],                  
    [OBJ_Roman, OBJ_Knight, OBJ_KnightCavalry, OBJ_Musketeer],    
    [OBJ_Caveman, OBJ_Roman, OBJ_Knight, OBJ_Musketeer, OBJ_Soldier],
];
spawn_area_min_x = 64;
spawn_area_max_x = room_width - 64;
spawn_area_min_y = 64;
spawn_area_max_y = room_height - 64;
//  delay between spawns, to be recalculated based on round
base_spawn_delay = 180;  // in frames
min_spawn_delay = 60;    // never go below this
spawn_timer = 0;
spawn_batch_count = 1;
spawn_initialized = false;
// create particle system for spawn effects
spawn_particle_sys = part_system_create();
part_system_depth(spawn_particle_sys, -1000);  // draw above enemies (adjust as needed)
// create a particle type for spawn effect
spawn_particle_sys = part_system_create();
part_system_depth(spawn_particle_sys, -1000); // draw above enemies
spawn_particle_type = part_type_create();
part_type_shape(spawn_particle_type, pt_shape_square);
part_type_size(spawn_particle_type, 0.05, 0.15, 0, 0);
part_type_color1(spawn_particle_type, c_white);
part_type_alpha2(spawn_particle_type, 1, 0);
part_type_speed(spawn_particle_type, 0.2, 0.4, 0, 0);
part_type_direction(spawn_particle_type, 0, 360, 0, 0);
part_type_life(spawn_particle_type, 15, 30);
part_type_gravity(spawn_particle_type, 0, 270);
part_type_blend(spawn_particle_type, true);
finalboss_spawned = false;

// Boss HP threshold tracking
boss_hp_thresholds = [100, 80, 60, 40, 20];  // HP percentages
boss_spawned_at_threshold = [false, false, false, false, false];  // Track which thresholds triggered
boss_tier_for_threshold = [0, 1, 2, 3, 4];  // Tier index for each threshold (0-4)