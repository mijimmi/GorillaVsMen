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
    spawn_delay = max(60, 240 - (global.round_num * 15)); // delay between spawn batches
    spawn_timer = spawn_delay;
    spawn_batch_count = 1;
    spawn_initialized = true;
}

// --- countdown timer ---
spawn_timer--;

// --- allow dynamic spawn_delay update mid-round (optional) ---
spawn_delay = max(60, 240 - (global.round_num * 15));

// --- time to spawn ---
if (spawn_timer <= 0) {
    var tier_index = clamp(floor((global.round_num - 1) / 2), 0, 4);
    var enemy_list = enemy_tiers[tier_index];
    var max_enemies = 12 + global.round_num;

    for (var i = 0; i < spawn_batch_count; i++) {
        if (instance_number(OBJ_ParentEnemy) >= max_enemies) break;

        // use local vars properly
		var tries = 0,
		    max_tries = 10,
		    spawn_ok = false,
		    _x = 0,
		    _y = 0,
		    enemy_to_spawn = -1;

        while (!spawn_ok && tries < max_tries) {
            enemy_to_spawn = enemy_list[irandom(array_length(enemy_list) - 1)];
            _x = random_range(spawn_area_min_x, spawn_area_max_x);
            _y = random_range(spawn_area_min_y, spawn_area_max_y);

            spawn_ok = true;

            with (OBJ_Gorilla) {
                if (point_distance(_x, _y, x, y) < 64) {
                    spawn_ok = false;
                }
            }

            tries++;
        }

        if (spawn_ok) {
            instance_create_layer(_x, _y, "Instances", enemy_to_spawn);
            part_particles_create(spawn_particle_sys, _x, _y, spawn_particle_type, 20);
        }
    }

    // reset spawn timer
    spawn_timer = spawn_delay;

    // increase spawn batch count based on round number
    if (global.round_num <= 5) {
        spawn_batch_count = min(spawn_batch_count + 1, 8);
    } else {
        spawn_batch_count = min(spawn_batch_count * 2, 16);
    }
}
