// Inherit the parent event
event_inherited();

s_moveORidle = SPR_Musketeer;
s_hurt = SPR_Musketeer_Hurt;
move_spd = 0.6;
bow_inst = instance_create_layer(x, y, "Instances", OBJ_Musket);
bow_inst.owner = id;
attack_dis = 96;