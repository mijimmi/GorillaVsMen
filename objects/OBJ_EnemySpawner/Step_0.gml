// Recalculate frames per second (in case it changes)
var fs = game_get_speed(gamespeed_fps);

// increase spawn rate per round (max 2x faster by round 10)
var spawn_delay = max(60, 180 - (global.round_num * 12));

if (!variable_global_exists("spawn_timer")) spawn_timer = 0;

spawn_timer--;

if (spawn_timer <= 0) {

    //  tier index from round number
    var tier_index = clamp(floor((global.round_num - 1) / 2), 0, 4);
    var enemy_list = enemy_tiers[tier_index];


    // Cap total enemy instances
    if (instance_number(OBJ_ParentEnemy) < 10 + global.round_num) {
        // Pick random enemy from tier list
        var enemy_to_spawn = enemy_list[irandom(array_length(enemy_list) - 1)];


        // random spawn position within room bounds 
        var _x = random_range(64, room_width - 64);
        var _y = random_range(64, room_height - 64);

        instance_create_layer(_x, _y, "Instances", enemy_to_spawn);
    }
    spawn_timer = spawn_delay;
}
