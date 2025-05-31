// Play sound effect for collecting banana with pitch variation
var snd_inst = audio_play_sound(SFX_EXP_Collect, 1, false); // Play sound and get instance ID
audio_sound_pitch(snd_inst, random_range(0.9, 1.1)); // Apply random pitch to the instance

//just edit this for xp value
OBJ_Gorilla.add_xp(150);
instance_destroy();

// Create a pixelated burst using particles
var part_sys = part_system_create();
part_system_depth(part_sys, depth); // Set depth to match current layer

var part_type = part_type_create();
part_type_shape(part_type, pt_shape_pixel); // pixelated effect
part_type_size(part_type, 1, 2, 0, 0); // small pixels
part_type_color1(part_type, c_orange);
part_type_speed(part_type, 1, 2, 0, 0);
part_type_direction(part_type, 0, 360, 0, 0);
part_type_life(part_type, 15, 30);

// Emit burst at position
part_particles_create(part_sys, x, y, part_type, 20);