event_inherited(); // inherit from parent if needed

// assign sprites
s_moveORidle = SPR_Roman;
s_hurt = SPR_Roman_Hurt;
s_dead = SPR_Blood_2;
move_spd = 0.6;

// create spear instance and assign ownership
spear_inst = instance_create_layer(x, y, "Instances", OBJ_Spear);
spear_inst.owner = id;
enemy_tier = 1;

hp_max = 30;
hp = hp_max;
melee.hitbox_damage = 10;