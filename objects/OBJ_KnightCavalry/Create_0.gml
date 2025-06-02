disable_parent_melee = true;
event_inherited();

// Move speed and stats
move_spd = 0.6;
s_moveORidle = SPR_Cavalry;
s_hurt = SPR_Cavalry_Hurt;
s_dead = SPR_Blood_3;
hp_max = 120;
hp = hp_max;
enemy_tier = 3;

dash_spd = 8;
dash_duration = 15;
dash_timer = 0;

dash_cooldown = 40;           // Original short cooldown (optional to keep)
long_dash_cooldown = 120;     // Long cooldown before next dash (adjust as needed)
dash_cooldown_timer = 60;

dashing = false;
dash_windup_duration = 60 + irandom_range(-5, 5); // slight timing variance  // How long to "charge" before dashing (frames)
dash_windup_timer = dash_windup_duration;
is_winding_up = false;
can_dash_attack = false;
dash_windup_offset = irandom_range(0, 30); // adds up to 30 frames of randomness

aim_delay_duration = 5;
aim_delay_timer = aim_delay_duration;

// Create particle system for line effect
particle_sys = part_system_create();
part_line = part_type_create();

part_type_shape(part_line, pt_shape_square);     // Square shape
part_type_color1(part_line, c_red);              // Red color
part_type_size(part_line, 0.04, 0.04, 0, 0);        // Optional: tweak size if needed
part_type_alpha2(part_line, 0.9, 0);              // Sharper fade out
part_type_speed(part_line, 0, 0, 0, 0);
part_type_direction(part_line, 0, 360, 0, 0);
part_type_life(part_line, 10, 10);
part_type_blend(part_line, false);

dash_target_x = x;
dash_target_y = y;

melee_hitbox.damage = 8;

melee_hitbox = instance_create_layer(x, y, "Hitboxes", OBJ_Cavalry_Hitbox);
melee_hitbox.enemy_parent = id;
