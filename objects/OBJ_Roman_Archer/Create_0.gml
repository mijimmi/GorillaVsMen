// Inherit the parent event
event_inherited();
//assign_sprites
s_moveORidle = SPR_Roman;
s_hurt = SPR_Roman_Hurt;
move_spd = 0.6;
bow_inst = instance_create_layer(x, y, "Instances", OBJ_Bow);
bow_inst.owner = id; // so the bow knows who it's attached to
attack_dis = 150;
hp_max = 20;
hp = hp_max;
enemy_tier = 1;