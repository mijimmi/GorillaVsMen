// Scale and state enum setup
image_xscale = 0.7;
image_yscale = 0.7;

enum RifleState {
    AIMING,
    FIRE_START,
    FIRE_END
}

state = RifleState.AIMING;
frame_delay = irandom_range(0, 239); // random offset
aim_update_timer = 0;
has_fired = false;
last_owner_x = x;
last_owner_y = y;
shot_count = 0;
shot_delay = 0;

// Particle system for pre-fire warning
part_sys = part_system_create();
part_emitter = part_emitter_create(part_sys);

part_fire_warn = part_type_create();
part_type_shape(part_fire_warn, pt_shape_flare);
part_type_size(part_fire_warn, 0.5, 1.0, 0, 0);
part_type_color3(part_fire_warn, c_blue, c_aqua, c_white);
part_type_alpha3(part_fire_warn, 0.9, 0.5, 0);
part_type_life(part_fire_warn, 20, 30);
part_type_speed(part_fire_warn, 0.3, 0.6, 0, 0);
part_type_direction(part_fire_warn, 0, 360, 0, 0);
part_type_blend(part_fire_warn, true);