event_inherited(); // inherit from parent if needed

// assign sprites
s_moveORidle = SPR_Roman;
s_hurt = SPR_Roman_Hurt;
move_spd = 0.6;

// create spear instance and assign ownership
spear_inst = instance_create_layer(x, y, "Instances", OBJ_Spear);
spear_inst.owner = id;
