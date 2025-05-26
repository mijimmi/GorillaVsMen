// Inherit the parent event
event_inherited();
hp_max = 25;
hp = hp_max;

//move speed
move_spd = 0.4;
s_moveORidle = SPR_Knight;
s_hurt = SPR_Knight_Hurt;

// create spear instance and assign ownership
sword_inst = instance_create_layer(x, y, "Instances", OBJ_Sword);
sword_inst.owner = id;
s_dead = SPR_Blood_4;
enemy_tier = 2;


