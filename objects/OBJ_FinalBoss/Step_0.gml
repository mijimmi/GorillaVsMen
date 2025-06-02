//roar system
if (state != states.DEAD && roar_state == "none") {
    var hp_percentage = hp / hp_max;
    
    for (var i = 0; i < array_length(roar_hp_thresholds); i++) {
        if (hp_percentage <= roar_hp_thresholds[i] && !roar_triggered[i]) {
            // Trigger roar
            roar_state = "active";
            roar_timer = sprite_get_number(SPR_Godzilla_Roar) * (60/room_speed);  // Duration based on sprite frames
            roar_triggered[i] = true;
            
            // Stop all movement
            path_end();
            hspeed = 0;
            vspeed = 0;
            speed = 0;
            
            // Set roar sprite
            sprite_index = SPR_Godzilla_Roar;
            image_index = 0;
            image_speed = 1;  // Play animation normally
            
            show_debug_message("Roar triggered at " + string(roar_hp_thresholds[i] * 100) + "% HP");
            break;  // Only trigger one roar at a time
        }
    }
}

// Handle roar state
if (roar_state == "active") {
    roar_timer -= 1/room_speed;
    
    // Keep boss immobilized during roar
    path_end();
    hspeed = 0;
    vspeed = 0;
    speed = 0;
    
    // Check if roar animation is finished
    if (roar_timer <= 0 || image_index >= sprite_get_number(SPR_Godzilla_Roar) - 1) {
        roar_state = "none";
        roar_timer = 0;
        
        // Return to normal sprite
        sprite_index = s_moveORidle;
        image_speed = 1;
        
        show_debug_message("Roar finished");
    }
}

// === ROCKET JUMP SYSTEM ===
// Handle rocket jump animations
if (rocket_jump_state == "pre_jump") {
    rocket_jump_timer -= 1;
    
    // Stop all movement during pre-jump
    path_end();
    hspeed = 0;
    vspeed = 0;
    speed = 0;
    
    // Play jump animation during pre_jump phase
    sprite_index = SPR_GodzillaJump;
    
    // Calculate frame based on sprite's native speed (6 fps)
    var total_frames = 10; // 0-9
    var animation_duration = room_speed * (total_frames / 6); // Duration at 6fps
    var initial_timer = room_speed * (total_frames / 6); // Same as animation_duration
    
    if (rocket_jump_timer > 0) {
        // Calculate progress through animation (0 to 1)
        var progress = 1 - (rocket_jump_timer / initial_timer);
        image_index = min(floor(progress * total_frames), total_frames - 1);
        image_speed = 0; // Manual frame control
    } else {
        // Animation finished, transition to warning
        rocket_jump_state = "warning";
        rocket_jump_timer = 0;
        
        // Create rocket instances now
        rocket_instances = [];
        
        // Create 8 random rockets (no boss position rocket yet)
        for (var i = 0; i < 8; i++) {
            var rocket_x = random(room_width);
            var rocket_y = random(room_height);
            var rocket = instance_create_layer(rocket_x, rocket_y, "Instances", OBJ_BossRocket);
            rocket.owner = id;
            rocket.rocket_state = "warning";
            array_push(rocket_instances, rocket);
        }
        show_debug_message("Jump animation complete, rockets created");
    }
} else if (rocket_jump_state == "warning") {
    // Hold at last frame of jump animation during warning
    sprite_index = SPR_GodzillaJump;
    image_index = 9; // Last frame (0-9, so frame 9)
    image_speed = 0;
    
    // Stop all movement during warning
    path_end();
    hspeed = 0;
    vspeed = 0;
    speed = 0;
} else if (rocket_jump_state == "active") {
    // Continue holding jump frame during active phase
    sprite_index = SPR_GodzillaJump;
    image_index = 9; // Hold last frame
    image_speed = 0;
    
    // Stop all movement during active
    path_end();
    hspeed = 0;
    vspeed = 0;
    speed = 0;
} else if (rocket_jump_state == "landing") {
    // Play landing animation
    sprite_index = SPR_Godzilla_Land;
    image_speed = 1;
    
    // Stop all movement during landing
    path_end();
    hspeed = 0;
    vspeed = 0;
    speed = 0;
    
    // Check if landing animation is complete
    if (image_index >= sprite_get_number(SPR_Godzilla_Land) - 1) {
        rocket_jump_state = "none";
        sprite_index = s_moveORidle;
        image_speed = 1;
        
        // CREATE DELAYED BOSS POSITION AOE AFTER LANDING
        var boss_aoe = instance_create_layer(x, y, "Instances", OBJ_BossRocket);
        boss_aoe.owner = id;
        boss_aoe.rocket_state = "active";  // Start immediately as active
        boss_aoe.warning_alpha = 1;  // Full alpha since it's instant
        boss_aoe.is_boss_aoe = true;  // Flag to identify this as boss AOE
        
        show_debug_message("Landing animation complete - Boss AOE created");
    }
}

// Check if boss should be immobilized during laser, roar, OR rocket jump
var is_laser_immobilized = (current_skill == "laser" && (skill_state == "warning" || skill_state == "active"));
var is_roar_immobilized = (roar_state == "active");
var is_rocket_immobilized = (rocket_jump_state != "none");
var is_default_laser_immobilized = (default_laser_state == "warning" || default_laser_state == "active");

// Only run parent movement logic if NOT immobilized by any system
if (!is_laser_immobilized && !is_roar_immobilized && !is_rocket_immobilized && !is_default_laser_immobilized) {
    event_inherited(); 
}

//  Final Boss State/Skill Logic 
// If the miniboss is dead, flag it so round can proceed
if (state == states.DEAD && global.finalboss_alive) {
    global.finalboss_alive = false;
}
// Only run default laser during skill cooldowns and when boss is alive
var can_use_default_laser = (state != states.DEAD && 
                           roar_state == "none" && 
                           (skill_state == "cooldown" || skill_state == "waiting") &&
                           instance_exists(OBJ_Gorilla));

if (can_use_default_laser) {
    default_laser_timer -= 1;
    
    switch(default_laser_state) {
        case "waiting":
            if (default_laser_timer <= 0) {
                // Start default laser attack
                default_laser_state = "warning";
                default_laser_timer = room_speed * 1;  // 1 second warning (faster than skill laser)
                
                // Calculate direction to player
                default_laser_direction = point_direction(x, y, OBJ_Gorilla.x, OBJ_Gorilla.y);
                
                // Create default laser instance
                default_laser_instance = instance_create_layer(x, y, "Instances", OBJ_DefaultLaser);
                default_laser_instance.owner = id;
                default_laser_instance.laser_state = "warning";
                default_laser_instance.target_direction = default_laser_direction;
                
                show_debug_message("Default laser warning started, targeting player");
            }
            break;
            
        case "warning":
            // Stop movement during warning
            path_end();
            hspeed = 0;
            vspeed = 0;
            speed = 0;
            
            // Handle default laser sprite animation during warning
            sprite_index = SPR_Godzilla_WeakLazer;
            
            // Calculate animation progress (assuming similar frame structure to main laser)
            var warning_duration = room_speed * 1;  // Total warning time
            var time_elapsed = warning_duration - default_laser_timer;  // Time that has passed
            var progress = time_elapsed / warning_duration;  // 0 to 1 progress
            
            // Get total frames in weak laser sprite (adjust this number based on your sprite)
            var total_warning_frames = sprite_get_number(SPR_Godzilla_WeakLazer);
            
            // If sprite has similar structure to main laser (warning frames + active frame)
            // Assume last frame is for active state, so warning uses all frames except last
            var warning_frames = max(1, total_warning_frames - 1);
            var target_frame = progress * warning_frames;
            
            // Set the frame directly
            image_index = min(floor(target_frame), warning_frames - 1);
            image_speed = 0;  // Manual frame control
            
            if (default_laser_timer <= 0) {
                // Start active phase
                default_laser_state = "active";
                default_laser_timer = room_speed * 1;  // 1 second active duration
                
                if (instance_exists(default_laser_instance)) {
                    default_laser_instance.laser_state = "active";
                }
                
                show_debug_message("Default laser active phase started");
            }
            break;
            
        case "active":
            // Stop movement during active
            path_end();
            hspeed = 0;
            vspeed = 0;
            speed = 0;
            
            // Hold the last frame of weak laser sprite during active phase
            sprite_index = SPR_Godzilla_WeakLazer;
            var total_frames = sprite_get_number(SPR_Godzilla_WeakLazer);
            image_index = total_frames - 1;  // Hold last frame
            image_speed = 0;
            
            if (default_laser_timer <= 0) {
                // End attack and start cooldown
                default_laser_state = "waiting";
                default_laser_timer = room_speed * 2;  // 2 second cooldown
                
                if (instance_exists(default_laser_instance)) {
                    instance_destroy(default_laser_instance);
                    default_laser_instance = noone;
                }
                
                // Return to normal sprite
                sprite_index = s_moveORidle;
                image_speed = 1;
                
                show_debug_message("Default laser finished, starting cooldown");
            }
            break;
    }
} else {
    // Clean up default laser if conditions are no longer met
    if (default_laser_state != "waiting") {
        default_laser_state = "waiting";
        default_laser_timer = room_speed * 2;  // Reset cooldown
        
        if (instance_exists(default_laser_instance)) {
            instance_destroy(default_laser_instance);
            default_laser_instance = noone;
        }
        
        // Return to normal sprite when cleaning up
        if (sprite_index == SPR_Godzilla_WeakLazer) {
            sprite_index = s_moveORidle;
            image_speed = 1;
        }
    }
}

// ONLY run skill system if boss is alive, not in DEAD state, and not roaring
if (state != states.DEAD && roar_state == "none") {
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
                
                show_debug_message("Chosen skill: " + current_skill);
                
                // Remove chosen skill from pool and add the other skill
                next_skill_pool = [];
                if (current_skill == "laser") {
                    array_push(next_skill_pool, "rocket");
                } else {
                    array_push(next_skill_pool, "laser");
                }
                
                // Handle skill initialization
                if (current_skill == "rocket") {
                    // Start rocket jump animation
                    rocket_jump_state = "pre_jump";
                    rocket_jump_timer = room_speed * (10 / 6); // 10 frames at 6fps
                    skill_state = "warning";
                    skill_timer = room_speed * 3;  // 3 second warning after jump
                    show_debug_message("Starting rocket jump sequence");
                } else {
                    // Laser starts warning immediately
                    skill_state = "warning";
                    skill_timer = room_speed * 3;  // 3 second warning
                    
                    // Create laser instance
                    laser_instance = instance_create_layer(x, y, "Instances", OBJ_BossLaser);
                    laser_instance.owner = id;
                    laser_instance.laser_state = "warning";
                }
            }
            break;
            
        case "warning":
            if (skill_timer <= 0) {
                // Start active phase
                skill_state = "active";
    
                show_debug_message("Starting active phase for: " + current_skill);
    
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
                    rocket_jump_state = "active"; // Transition rocket to active
                    for (var i = 0; i < array_length(rocket_instances); i++) {
                        if (instance_exists(rocket_instances[i])) {
                            rocket_instances[i].rocket_state = "active";
                        }
                    }
                }
            } else {
                // During warning phase - handle laser sprite animation
                if (current_skill == "laser") {
                    // STOP MOVEMENT DURING LASER WARNING PHASE
                    path_end();
                    hspeed = 0;
                    vspeed = 0;
                    speed = 0;
                    
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
                // Rocket warning phase is handled by rocket_jump_state = "warning"
            }
            break;
            
        case "active":
            if (skill_timer <= 0) {
                // Start cooldown phase
                skill_state = "cooldown";
                
                show_debug_message("Starting cooldown phase for: " + current_skill);
                
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
                    
                    // Start landing animation
                    rocket_jump_state = "landing";
                    sprite_index = SPR_Godzilla_Land;
                    image_index = 0;
                    image_speed = 1;
                    show_debug_message("Starting landing animation");
                }
            } else {
                // During active phase - hold frame 22 for laser or jump frame for rocket
                if (current_skill == "laser") {
                    sprite_index = SPR_Godzilla_Lazer;
                    image_index = 22;
                    image_speed = 0;  // Hold frame 22 throughout active phase
                    
                    // Stop all movement during laser active phase
                    path_end(); // Stop any active pathfinding
                    hspeed = 0;
                    vspeed = 0;
                    speed = 0;
                    
                    show_debug_message("Active - Holding frame 22, movement stopped");
                }
                // Rocket active phase is handled by rocket_jump_state = "active"
            }
            break;
            
        case "cooldown":
            if (skill_timer <= 0) {
                // Back to waiting phase - skill will be randomly chosen next cycle
                skill_state = "waiting";
                skill_timer = room_speed * 3;  // 3 second wait before next skill
                current_skill = "";  // Reset current skill
                
                show_debug_message("Cooldown finished, back to waiting");
            }
            break;
    }
}

// Handle hurt/death animations even when skills are active
if (state == states.DEAD) {
    death_timer++;
    path_end();
    speed = 0;
    enemy_anim(); // Apply the dead sprite
    if (death_timer > death_duration) {
        instance_destroy();
    }
} else if (is_hurt) {
    hurt_timer--;
    if (hurt_timer <= 0) {
        is_hurt = false;
        hurt_timer = 0;
    }
    // Only apply hurt animation if not doing any special animations
    if (!is_laser_immobilized && !is_rocket_immobilized && !is_default_laser_immobilized) {
        enemy_anim();
    }
}