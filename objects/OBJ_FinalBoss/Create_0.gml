event_inherited();
// final boss properties
hp_max = 500;
hp = hp_max;
enemy_tier = 5;
is_finalboss = true;
// Sprite setup
//s_idlegodzilla = SPR_Godzilla_Idle;
s_moveORidle = SPR_Godzilla_Right;
s_hurt = SPR_Godzilla_Idle;
s_dead_selected = -1;
global.finalboss_alive = true;

// Skill system - alternating random skills
skill_state = "waiting";  // "waiting", "warning", "active", "cooldown"
skill_timer = room_speed * 5;  // Start with 5 second wait
current_skill = "";  // "laser" or "rocket"
next_skill_pool = ["laser", "rocket"];  // Pool for random selection

// Laser instances
laser_instance = noone;

// Rocket instances
rocket_instances = [];  // Array to hold rocket instances

roar_state = "none";  // "none", "active"
roar_timer = 0;
roar_triggered = [false, false, false, false, false];  // Track which HP thresholds triggered roar
roar_hp_thresholds = [1.0, 0.8, 0.6, 0.4, 0.2];  
rocket_jump_state = "none";  
rocket_jump_timer = 0;