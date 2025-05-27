//if the level manager is currently onscreen, do NOT read player input.
if(instance_exists(OBJ_LevelManager)) {exit;}

// === Read Input Keys ===
var right_key = keyboard_check(vk_right) || keyboard_check(ord("D"));
var left_key  = keyboard_check(vk_left)  || keyboard_check(ord("A"));	
var up_key    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
var down_key  = keyboard_check(vk_down)  || keyboard_check(ord("S"));

// === Calculate Intended Movement ===
var xdir = right_key - left_key;
var ydir = down_key - up_key;

//pause logic
if (global.is_leveling_up) {
    exit;
}

// Normalize movement to prevent faster diagonal speed
var magnitude = point_distance(0, 0, xdir, ydir);
if (magnitude > 0) {
    xdir /= magnitude;
    ydir /= magnitude;
}

xspd = xdir * move_spd;
yspd = ydir * move_spd;

// === Cooldown Timer ===
if (smash_cooldown > 0) {
    smash_cooldown--;
}

// === Check for Smash Input with Cooldown ===
if (mouse_check_button_pressed(mb_left) && current_state != GorillaState.SMASH && smash_cooldown <= 0) {
    current_state = GorillaState.SMASH;
    image_index = 0; // Start animation from the beginning
}

// === Logic for i-frames ===
if (invincible) {
    invincibility_timer--;
    if (invincibility_timer <= 0) {
        invincible = false;
    }
}

// === State Machine ===
switch (current_state) {
    case GorillaState.IDLE:
        if (xspd != 0 || yspd != 0) {
            current_state = GorillaState.MOVING;
        }
        sprite_index = SPR_Gorilla_Idle;
        image_speed = 1;
        image_xscale = (facing == "right") ? 1 : -1;
        break;

    case GorillaState.MOVING:
        if (xspd == 0 && yspd == 0) {
            current_state = GorillaState.IDLE;
        }

        if (xspd > 0) {
            facing = "right";
            sprite_index = SPR_Gorilla_Right;
            image_xscale = 1;
        } else if (xspd < 0) {
            facing = "left";
            sprite_index = SPR_Gorilla_Right;
            image_xscale = -1;
        } else if (yspd != 0) {
            sprite_index = SPR_Gorilla_Right;
            image_xscale = (facing == "right") ? 1 : -1;
        }

        image_speed = 1;

        // === Footstep Sound Logic ===
        footstep_timer -= 1;
        if (footstep_timer <= 0) {
			var step_sound = choose(SND_Footstep1, SND_Footstep2, SND_Footstep3);
			var snd_step_inst = audio_play_sound(step_sound, 1, false);
			audio_sound_pitch(snd_step_inst, random_range(0.95, 1.05)); // Pitch variation
			audio_sound_gain(snd_step_inst, 0.15, 0);
            footstep_timer = footstep_interval; // Reset timer
        }
        break;

	case GorillaState.SMASH:
	    sprite_index = SPR_Gorilla_Smash;
	    image_speed = 1.1;
	    image_xscale = (facing == "right") ? 1 : -1;

	    // Stop animation at the last frame, then switch state
	    if (image_index >= image_number - 1) {
	        image_speed = 0; // Freeze at last frame to avoid looping
			
			var smash_sound = choose(SND_Smash, SND_Smash2, SND_Smash3);
			var snd_inst = audio_play_sound(smash_sound, 1, false);
			audio_sound_gain(snd_inst, 0.6, 0);
			audio_sound_pitch(snd_inst, random_range(0.95, 1.05)); // slight pitch variation

	        // === Spawn smash effect at correct position ===
	        var fx_x = x + (facing == "right" ? 16 : -16);
	        var fx_y = y;
	        instance_create_layer(fx_x, fx_y, "Effects", OBJ_FX_Smash);
			instance_create_layer(fx_x, fx_y, "Effects", OBJ_FX_Smash2);
			
			// === Spawn smash hitbox at correct position ===
			var hitbox_x = x + (facing == "right" ? 16 : -16);
			var hitbox_y = y;
			instance_create_layer(hitbox_x, hitbox_y, "Hitboxes", OBJ_Gorilla_Hitbox_Smash);

	        // === Trigger camera shake ===
	        with (OBJ_CameraController) {
	            shake_timer = 10;
	            shake_magnitude = 4;
	        }
			
			smash_cooldown = 20;

	        current_state = GorillaState.IDLE;
	        image_index = 0;
	    }

	    // Disable movement
	    xspd = 0;
	    yspd = 0;
	    break;
}

// === Wall Collisions & Apply Movement ===
if (current_state != GorillaState.SMASH) {
    if (place_meeting(x + xspd, y, OBJ_Wall)) {
        xspd = 0;
    }
    if (place_meeting(x, y + yspd, OBJ_Wall)) {
        yspd = 0;
    }

    x += xspd;
    y += yspd;
}

// === Gorilla Damage Function ===
function gorilla_take_damage(amount) {
    hp -= amount;

    if (hp <= 0) {
        // Play death animation, effects, etc.
        instance_destroy();
    }
}
