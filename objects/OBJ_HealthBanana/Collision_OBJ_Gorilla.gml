// Play heal sound (optional)
var snd_inst = audio_play_sound(SND_Heal, 1, false);
audio_sound_pitch(snd_inst, random_range(0.9, 1.1));

// Heal the gorilla
var heal_amount = OBJ_Gorilla.hp_max * 0.15;
OBJ_Gorilla.hp = clamp(OBJ_Gorilla.hp + heal_amount, 0, OBJ_Gorilla.hp_max);

// Particle effect
var part_sys = part_system_create();
part_system_depth(part_sys, depth);

var part_type = part_type_create();
part_type_shape(part_type, pt_shape_pixel);
part_type_size(part_type, 1, 2, 0, 0);
part_type_color1(part_type, c_lime); // green for health
part_type_speed(part_type, 1, 2, 0, 0);
part_type_direction(part_type, 0, 360, 0, 0);
part_type_life(part_type, 15, 30);

part_particles_create(part_sys, x, y, part_type, 20);

instance_destroy();
