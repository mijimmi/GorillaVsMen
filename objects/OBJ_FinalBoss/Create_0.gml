// Inherit the parent event
event_inherited();
// final boss properties
hp_max = 500;
hp = hp_max;
enemy_tier = 5;
is_finalboss = true;
// Sprite setup
s_moveORidle = SPR_Soldier_Hurt;
s_hurt = SPR_Caveman_Hurt;
s_dead_selected = -1;
global.finalboss_alive = true;

// Laser timing system
laser_state = "waiting";  // "waiting", "warning", "active", "cooldown"
laser_timer = room_speed * 5;  // Start with 5 second wait
laser_instance = noone;
