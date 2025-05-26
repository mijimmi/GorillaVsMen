// --- pause spawning if leveling up ---
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
    // Moderate spawn delay, slower than original but faster than very forgiving
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

    // Slightly harder caps than very forgiving but softer than original
    var max_enemies = 6 + (global.round_num * 2.5); // between 5+2*r and 8+3*r
    var spawn_cap = 9 + (global.round_num * 3.5);   // between 8+3*r and 10+4*r

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

    // Batch growth: a little faster but capped lower than original
    if (global.round_num < 10) {
        if (global.round_num mod 1 == 0) { // every round increase
            spawn_batch_count = min(spawn_batch_count + 1, 5); // was 4 forgiving, 6 original
        }
    } else {
        spawn_batch_count = min(spawn_batch_count + 1, 7); // was 6 forgiving, 10 original
    }

    spawn_timer = spawn_delay;
}