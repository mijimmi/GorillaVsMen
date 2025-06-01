if (!variable_instance_exists(id, "spawn_initialized")) {
    spawn_initialized = false;
    finalboss_spawned = false;
    spawn_delay = 0;
    spawn_timer = 0;
    spawn_batch_count = 1;
}
// --- stop everything if game is over ---
if (global.game_over) {
    exit;
}

// --- pause spawning if leveling up ---
if (global.is_leveling_up) {
    exit;
}

// --- stop spawning if game not in active round ---
if (global.state != GameState.ROUND_ACTIVE) {
    spawn_initialized = false; // reset for next round
    finalboss_spawned = false;
    // Reset boss threshold tracking for new round
    boss_spawned_at_threshold = [false, false, false, false, false];
    exit;
}

// --- init on round start ---
if (!spawn_initialized) {
    spawn_delay = max(105, 270 - (global.round_num * 7)); 
    spawn_timer = spawn_delay;
    spawn_batch_count = 1;
    spawn_initialized = true;
    
    // Only handle final boss initialization
    if (global.round_num == 10) {
        finalboss_spawned = false;
        global.boss_fight_active = true;
        // Reset boss threshold tracking for boss fight
        boss_spawned_at_threshold = [false, false, false, false, false];
    }
}

// --- Special round 10: spawn exactly one final boss, then handle HP-based spawning ---
if (global.round_num == 10) {
    // Spawn final boss if not spawned yet
    if (!finalboss_spawned) {
        var tries = 0;
        var max_tries = 20;
        var spawn_ok = false;
        var _x, _y;

        while (!spawn_ok && tries < max_tries) {
            _x = random_range(spawn_area_min_x, spawn_area_max_x);
            _y = random_range(spawn_area_min_y, spawn_area_max_y);
            spawn_ok = true;

            with (OBJ_Gorilla) {
                if (point_distance(_x, _y, x, y) < 96) {
                    spawn_ok = false;
                }
            }

            tries++;
        }

        if (spawn_ok) {
            instance_create_layer(_x, _y, "Instances", OBJ_FinalBoss);
            finalboss_spawned = true;

            var snd_inst = audio_play_sound(SND_Spawn, 1, false);
            audio_sound_gain(snd_inst, 0.5, 0);
            audio_sound_pitch(snd_inst, random_range(0.95, 1.05));

            part_particles_create(spawn_particle_sys, _x, _y, spawn_particle_type, 20);
        }
    }
    
    // Handle HP-based enemy spawning during boss fight
    if (finalboss_spawned && global.finalboss_alive) {
        // Find the final boss instance
        var finalboss_instance = instance_find(OBJ_FinalBoss, 0);
        if (instance_exists(finalboss_instance)) {
            var boss_hp_percent = (finalboss_instance.hp / finalboss_instance.hp_max) * 100;
            
            // Check each threshold
            for (var i = 0; i < array_length(boss_hp_thresholds); i++) {
                if (!boss_spawned_at_threshold[i] && boss_hp_percent <= boss_hp_thresholds[i]) {
                    boss_spawned_at_threshold[i] = true;
                    
                    // Spawn 5 enemies of the appropriate tier
                    var tier_to_spawn = boss_tier_for_threshold[i];
                    var enemy_list = enemy_tiers[tier_to_spawn];
                    
                    for (var j = 0; j < 5; j++) {
                        var tries = 0;
                        var max_tries = 10;
                        var spawn_ok = false;
                        var _x, _y;
                        
                        while (!spawn_ok && tries < max_tries) {
                            _x = random_range(spawn_area_min_x, spawn_area_max_x);
                            _y = random_range(spawn_area_min_y, spawn_area_max_y);
                            spawn_ok = true;
                            
                            // Check distance from player
                            with (OBJ_Gorilla) {
                                if (point_distance(_x, _y, x, y) < 96) {
                                    spawn_ok = false;
                                }
                            }
                            
                            // Check distance from boss
                            if (point_distance(_x, _y, finalboss_instance.x, finalboss_instance.y) < 96) {
                                spawn_ok = false;
                            }
                            
                            tries++;
                        }
                        
                        if (spawn_ok) {
                            // Use weighted random selection like normal spawning
                            var weights = [];
                            for (var w = 0; w < array_length(enemy_list); w++) {
                                if (enemy_list[w] == OBJ_Roman_Archer) {
                                    weights[w] = 7;
                                } else if (enemy_list[w] == OBJ_Musketeer) {
                                    weights[w] = 5;
                                } else {
                                    weights[w] = 10;
                                }
                            }
                            
                            var enemy_index = weighted_random(weights);
                            var enemy_to_spawn = enemy_list[enemy_index];
                            
                            instance_create_layer(_x, _y, "Instances", enemy_to_spawn);
                            
                            // Apply same spawn effects as normal spawning
                            var snd_inst = audio_play_sound(SND_Spawn, 1, false);
                            audio_sound_gain(snd_inst, 0.5, 0);
                            audio_sound_pitch(snd_inst, random_range(0.95, 1.05));
                            
                            part_particles_create(spawn_particle_sys, _x, _y, spawn_particle_type, 20);
                        }
                    }
                }
            }
        }
    }
    
    // Skip normal spawning logic during round 10
    exit;
}

// --- Normal enemy spawning logic continues here ---
if (global.is_leveling_up) {
    exit;
}

// --- stop spawning if game not in active round ---
if (global.state != GameState.ROUND_ACTIVE) {
    spawn_initialized = false; // reset for next round
    exit;
}

// --- init on round start ---
if (!spawn_initialized) {
    spawn_delay = max(105, 270 - (global.round_num * 7)); 
    spawn_timer = spawn_delay;
    spawn_batch_count = 1;
    spawn_initialized = true;
}

// --- countdown timer ---
spawn_timer--;

// --- allow dynamic spawn_delay update mid-round (optional) ---
spawn_delay = max(105, 270 - (global.round_num * 7));

// Helper function for weighted random selection
function weighted_random(weights_array) {
    var total_weight = 0;
    for (var i = 0; i < array_length(weights_array); i++) {
        total_weight += weights_array[i];
    }
    var r = random(total_weight);
    var accum = 0;
    for (var i = 0; i < array_length(weights_array); i++) {
        accum += weights_array[i];
        if (r < accum) {
            return i;
        }
    }
    return 0; // fallback
}

// --- time to spawn ---
if (spawn_timer <= 0) {
    var tier_index = clamp(floor((global.round_num - 1) / 2), 0, 4);
    var enemy_list = enemy_tiers[tier_index];

    var max_enemies = 6 + (global.round_num * 2.5);
    var spawn_cap = 9 + (global.round_num * 3.5);

    for (var i = 0; i < spawn_batch_count; i++) {
        if (instance_number(OBJ_ParentEnemy) >= max_enemies ||
            instance_number(OBJ_ParentEnemy) >= spawn_cap) {
            break;
        }

        var tries = 0,
            max_tries = 10,
            spawn_ok = false,
            _x = 0,
            _y = 0,
            enemy_to_spawn = -1;

        var weights = [];
        for (var w = 0; w < array_length(enemy_list); w++) {
            if (enemy_list[w] == OBJ_Roman_Archer) {
                weights[w] = 7;
            } else if (enemy_list[w] == OBJ_Musketeer) {
                weights[w] = 5;
            } else {
                weights[w] = 10;
            }
        }

        while (!spawn_ok && tries < max_tries) {
            var enemy_index = weighted_random(weights);
            enemy_to_spawn = enemy_list[enemy_index];
            _x = random_range(spawn_area_min_x, spawn_area_max_x);
            _y = random_range(spawn_area_min_y, spawn_area_max_y);

            spawn_ok = true;

            with (OBJ_Gorilla) {
                if (point_distance(_x, _y, x, y) < 96) {
                    spawn_ok = false;
                }
            }

            tries++;
        }

        if (spawn_ok) {
            instance_create_layer(_x, _y, "Instances", enemy_to_spawn);

            var snd_inst = audio_play_sound(SND_Spawn, 1, false);
            audio_sound_gain(snd_inst, 0.5, 0);
            audio_sound_pitch(snd_inst, random_range(0.95, 1.05));

            part_particles_create(spawn_particle_sys, _x, _y, spawn_particle_type, 20);
        }
    }

    if (global.round_num < 10) {
        if (global.round_num mod 1 == 0) {
            spawn_batch_count = min(spawn_batch_count + 1, 5);
        }
    } else {
        spawn_batch_count = min(spawn_batch_count + 1, 7);
    }

    spawn_timer = spawn_delay;
}