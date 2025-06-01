event_inherited(); // Retain core logic from parent

// === Final Boss State/Skill Logic ===
// If the miniboss is dead, flag it so round can proceed
if (state == states.DEAD && global.finalboss_alive) {
    global.finalboss_alive = false;
}

// Single skill state machine handling both laser and rocket
skill_timer -= 1;
switch(skill_state) {
    case "waiting":
        if (skill_timer <= 0) {
            // Choose random skill from pool
            var skill_index = irandom(array_length(next_skill_pool) - 1);
            current_skill = next_skill_pool[skill_index];
            
            // Remove chosen skill from pool and add the other skill
            next_skill_pool = [];
            if (current_skill == "laser") {
                array_push(next_skill_pool, "rocket");
            } else {
                array_push(next_skill_pool, "laser");
            }
            
            // Start warning phase
            skill_state = "warning";
            skill_timer = room_speed * 3;  // 3 second warning
            
            // Create instances based on chosen skill
            if (current_skill == "laser") {
                laser_instance = instance_create_layer(x, y, "Instances", OBJ_BossLaser);
                laser_instance.owner = id;
                laser_instance.laser_state = "warning";
            } else if (current_skill == "rocket") {
                // Create 8 rocket AOE instances at random positions
                rocket_instances = [];
                for (var i = 0; i < 8; i++) {
                    var rocket_x = random(room_width);
                    var rocket_y = random(room_height);
                    var rocket = instance_create_layer(rocket_x, rocket_y, "Instances", OBJ_BossRocket);
                    rocket.owner = id;
                    rocket.rocket_state = "warning";
                    array_push(rocket_instances, rocket);
                }
            }
        }
        break;
        
    case "warning":
        if (skill_timer <= 0) {
            // Start active phase
            skill_state = "active";
            
            if (current_skill == "laser") {
                skill_timer = room_speed * 5;  // 5 second active for laser
                if (instance_exists(laser_instance)) {
                    laser_instance.laser_state = "active";
                }
            } else if (current_skill == "rocket") {
                skill_timer = room_speed * 2;  // 2 second active for rocket
                for (var i = 0; i < array_length(rocket_instances); i++) {
                    if (instance_exists(rocket_instances[i])) {
                        rocket_instances[i].rocket_state = "active";
                    }
                }
            }
        }
        break;
        
    case "active":
        if (skill_timer <= 0) {
            // Start cooldown phase
            skill_state = "cooldown";
            
            if (current_skill == "laser") {
                skill_timer = room_speed * 15;  // 15 second cooldown for laser
                if (instance_exists(laser_instance)) {
                    instance_destroy(laser_instance);
                    laser_instance = noone;
                }
            } else if (current_skill == "rocket") {
                skill_timer = room_speed * 20;  // 20 second cooldown for rocket
                for (var i = 0; i < array_length(rocket_instances); i++) {
                    if (instance_exists(rocket_instances[i])) {
                        instance_destroy(rocket_instances[i]);
                    }
                }
                rocket_instances = [];
            }
        }
        break;
        
    case "cooldown":
        if (skill_timer <= 0) {
            // Back to waiting phase - skill will be randomly chosen next cycle
            skill_state = "waiting";
            skill_timer = room_speed * 3;  // 3 second wait before next skill
            current_skill = "";  // Reset current skill
        }
        break;
}