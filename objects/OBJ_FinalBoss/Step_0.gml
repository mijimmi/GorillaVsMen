event_inherited(); // Retain core logic from parent

// === Final Boss State/Skill Logic ===
// If the miniboss is dead, flag it so round can proceed
// If the miniboss is dead, flag it so round can proceed
if (state == states.DEAD && global.finalboss_alive) {
    global.finalboss_alive = false;
}

// Laser state machine
laser_timer -= 1;

switch(laser_state) {
    case "waiting":
        if (laser_timer <= 0) {
            // Start warning phase
            laser_state = "warning";
            laser_timer = room_speed * 3;  // 3 second warning
            laser_instance = instance_create_layer(x, y, "Instances", OBJ_BossLaser);
            laser_instance.owner = id;
            laser_instance.laser_state = "warning";
        }
        break;
        
    case "warning":
        if (laser_timer <= 0) {
            // Start active phase
            laser_state = "active";
            laser_timer = room_speed * 5;  // 8 second active
            if (instance_exists(laser_instance)) {
                laser_instance.laser_state = "active";
            }
        }
        break;
        
    case "active":
        if (laser_timer <= 0) {
            // Start cooldown phase
            laser_state = "cooldown";
            laser_timer = room_speed * 15;  // 15 second cooldown
            if (instance_exists(laser_instance)) {
                instance_destroy(laser_instance);
                laser_instance = noone;
            }
        }
        break;
        
    case "cooldown":
        if (laser_timer <= 0) {
            // Back to warning phase
            laser_state = "warning";
            laser_timer = room_speed * 3;  // 3 second warning
            laser_instance = instance_create_layer(x, y, "Instances", OBJ_BossLaser);
            laser_instance.owner = id;
            laser_instance.laser_state = "warning";
        }
        break;
}

show_debug_message("Laser state: " + laser_state + ", timer: " + string(laser_timer));