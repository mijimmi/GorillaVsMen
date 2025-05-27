
// Create a particle system
bullet_ps = part_system_create();
part_system_depth(bullet_ps, depth + 1); // behind the bullet

// Create a particle type for the bullet trail
bullet_pt = part_type_create();
part_type_shape(bullet_pt, pt_shape_pixel);
part_type_size(bullet_pt, 1.0, 1.6, 0, 0); // slightly larger than arrow
part_type_alpha2(bullet_pt, 1, 0); // fade out
part_type_color1(bullet_pt, c_yellow); // muzzle flare style
part_type_speed(bullet_pt, 0.1, 0.3, 0, 0);
part_type_life(bullet_pt, 25, 40); // longer trail lifetime

//Hitbox
var hitbox = instance_create_layer(x, y, "Hitboxes", OBJ_ProjectileHitbox);
hitbox.follow_target = id;
hitbox.damage = 5;
