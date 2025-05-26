// Inherit the parent event
event_inherited();

s_moveORidle = SPR_Musketeer;
s_hurt = SPR_Musketeer_Hurt;
s_dead = SPR_Blood_2;
move_spd = 0.6;
bow_inst = instance_create_layer(x, y, "Instances", OBJ_Musket);
bow_inst.owner = id;
attack_dis = 128;
hp_max = 20;
hp = hp_max;
enemy_tier = 4;
