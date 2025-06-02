disable_parent_melee = true;
event_inherited();

// final boss properties
hp_max = 500;
hp = hp_max;
enemy_tier = 5;
is_finalboss = true;
// Sprite setup
s_moveORidle = SPR_Godzilla_Idle;
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

melee_hitbox = instance_create_layer(x, y, "Hitboxes", OBJ_Godzilla_Hitbox);
melee_hitbox.damage = 10;
melee_hitbox.enemy_parent = id;
