// Inherit base enemy behavior
event_inherited();

// Miniboss properties
hp_max = 60;
hp = hp_max;
enemy_tier = 5;
is_miniboss = true;

// Sprite setup
s_moveORidle = SPR_Soldier_Hurt;       // Change this if miniboss has a unique sprite
s_hurt = SPR_Caveman_Hurt;        // Same here
s_dead_selected = -1;             // Randomized in parent

// Special miniboss logic
global.miniboss_alive = true;
