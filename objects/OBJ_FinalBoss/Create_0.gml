// Inherit the parent event
event_inherited();
// final boss properties
hp_max = 500;
hp = hp_max;
enemy_tier = 5;
is_finalboss = true;

// Sprite setup
s_moveORidle = SPR_Soldier_Hurt;       // Change this if miniboss has a unique sprite
s_hurt = SPR_Caveman_Hurt;        // Same here
s_dead_selected = -1;             // Randomized in parent


global.finalboss_alive = true;


