event_inherited();
// Setup soldier sprites and parameters
s_moveORidle = SPR_Soldier;
s_hurt = SPR_Soldier_Hurt;
move_spd = 0.7;

rifle_inst = instance_create_layer(x, y, "Instances", OBJ_Rifle);
rifle_inst.owner = id;

attack_dis = 180;
hp_max = 70;
hp = hp_max;
enemy_tier = 5;