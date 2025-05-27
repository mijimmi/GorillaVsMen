// create a particle system
arrow_ps = part_system_create();
part_system_depth(arrow_ps, depth + 1); // behind the arrow

// create a particle type
arrow_pt = part_type_create();
part_type_shape(arrow_pt, pt_shape_pixel);
part_type_size(arrow_pt, 1.0, 1.4, 0, 0); // bigger trail
part_type_alpha2(arrow_pt, 1, 0); // fade out
part_type_color1(arrow_pt, c_red); // red color
part_type_speed(arrow_pt, 0.2, 0.4, 0, 0);
part_type_life(arrow_pt, 15, 25);

// Hitbox
var hitbox = instance_create_layer(x, y, "Instances", OBJ_ProjectileHitbox);
hitbox.follow_target = id;
hitbox.damage = 3;
