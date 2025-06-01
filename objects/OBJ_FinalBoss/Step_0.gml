event_inherited(); 

// === Final Boss State/Skill Logic ===
// If the miniboss is dead, flag it so round can proceed
if (state == states.DEAD && global.finalboss_alive) {
    global.finalboss_alive = false;
}

// ONLY run skill system if boss is alive and not in DEAD state
if (state != states.DEAD) {
    // Single skill state machine handling both laser and rocket
    skill_timer -= 1;
    
    switch(skill_state) {
        case "waiting":
            if (skill_timer <= 0) {
                // Ensure we have skills in pool
                if (array_length(next_skill_pool) == 0) {
                    next_skill_pool = ["laser", "rocket"];  // Reset pool if empty
                }
                
                // Choose random skill from pool
                var skill_index = irandom(array_length(next_skill_pool) - 1);
                current_skill = next_skill_pool[skill_index];
                
                show_debug_message("Chosen skill: " + current_skill); // Debug
                
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
                
                show_debug_message("Starting warning phase for: " + current_skill); // Debug
                
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
    
                show_debug_message("Starting active phase for: " + current_skill); // Debug
    
                if (current_skill == "laser") {
                    skill_timer = room_speed * 5;  // 5 second active for laser
                    if (instance_exists(laser_instance)) {
                        laser_instance.laser_state = "active";
                    }
                    // Set laser sprite and jump to frame 22 for active phase
                    sprite_index = SPR_Godzilla_Lazer;
                    image_index = 22;
                    image_speed = 0;  // Hold frame 22 during active
                } else if (current_skill == "rocket") {
                    skill_timer = room_speed * 2;  // 2 second active for rocket
                    for (var i = 0; i < array_length(rocket_instances); i++) {
                        if (instance_exists(rocket_instances[i])) {
                            rocket_instances[i].rocket_state = "active";
                        }
                    }
                }
            } else {
                // During warning phase - handle laser sprite animation
                if (current_skill == "laser") {
                    // Always ensure we're using the laser sprite
                    sprite_index = SPR_Godzilla_Lazer;
        
                    // Calculate how much time has passed in warning phase
                    var warning_duration = room_speed * 3;  // Total warning time
                    var time_elapsed = warning_duration - skill_timer;  // Time that has passed
                    var progress = time_elapsed / warning_duration;  // 0 to 1 progress
        
                    // Calculate which frame we should be on (0 to 21)
                    var target_frame = progress * 22;  // 22 frames total (0-21)
        
                    // Set the frame directly
                    image_index = min(floor(target_frame), 21);  // Cap at frame 21
                    image_speed = 0;  // We're controlling frames manually
        
                    // Debug output
                    show_debug_message("Warning - Frame: " + string(image_index) + " Progress: " + string(progress));
                }
            }
            break;
            
        case "active":
            if (skill_timer <= 0) {
                // Start cooldown phase
                skill_state = "cooldown";
                
                show_debug_message("Starting cooldown phase for: " + current_skill); // Debug
                
                if (current_skill == "laser") {
                    skill_timer = room_speed * 15;  // 15 second cooldown for laser
                    if (instance_exists(laser_instance)) {
                        instance_destroy(laser_instance);
                        laser_instance = noone;
                    }
                    // Return to normal idle sprite during cooldown
                    sprite_index = s_moveORidle;
                    image_speed = 1;
                } else if (current_skill == "rocket") {
                    skill_timer = room_speed * 20;  // 20 second cooldown for rocket
                    for (var i = 0; i < array_length(rocket_instances); i++) {
                        if (instance_exists(rocket_instances[i])) {
                            instance_destroy(rocket_instances[i]);
                        }
                    }
                    rocket_instances = [];
                }
            } else {
                // During active phase - hold frame 22 for laser
                if (current_skill == "laser") {
                    sprite_index = SPR_Godzilla_Lazer;
                    image_index = 22;
                    image_speed = 0;  // Hold frame 22 throughout active phase
                    show_debug_message("Active - Holding frame 22"); // Debug
                }
            }
            break;
            
        case "cooldown":
            if (skill_timer <= 0) {
                // Back to waiting phase - skill will be randomly chosen next cycle
                skill_state = "waiting";
                skill_timer = room_speed * 3;  // 3 second wait before next skill
                current_skill = "";  // Reset current skill
                
                show_debug_message("Cooldown finished, back to waiting"); // Debug
            }
            break;
    }
}