disable_parent_melee = true;
event_inherited();

// final boss properties
hp_max = 20000;
hp = hp_max;
enemy_tier = 5;
is_finalboss = true;
s_moveORidle = SPR_Godzilla_Right;
s_hurt = SPR_Godzilla_Hurt;
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

// Roar system
roar_state = "none";  // "none", "active"
roar_timer = 0;
roar_triggered = [false, false, false, false, false];  // Track which HP thresholds triggered roar
roar_hp_thresholds = [1.0, 0.8, 0.6, 0.4, 0.2];  

// Rocket jump system
rocket_jump_state = "none";  
rocket_jump_timer = 0;

// Default laser attack system (NEW)
default_laser_state = "waiting";  // "waiting", "warning", "active"
default_laser_timer = room_speed * 2;  // Start with 2 second cooldown
default_laser_instance = noone;
default_laser_direction = 0;  // Direction to aim at player

// Melee hitbox
melee_hitbox = instance_create_layer(x, y, "Hitboxes", OBJ_Godzilla_Hitbox);
melee_hitbox.damage = 10;
melee_hitbox.enemy_parent = id;