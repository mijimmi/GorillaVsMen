// Destroy if owner no longer exists
if (!variable_instance_exists(id, "owner") || !instance_exists(owner)) {
    instance_destroy();
    exit;
}

// Exit if leveling up
if (global.is_leveling_up) {
    exit;
}

// Follow the owner
x = owner.x;
y = owner.y - 10;

// --- Track owner movement ---
var owner_moving = false;
if (owner.x != last_owner_x || owner.y != last_owner_y) {
    owner_moving = true;
}
last_owner_x = owner.x;
last_owner_y = owner.y;

// --- Update aim every 15 frames ---
aim_update_timer++;
if (aim_update_timer >= 15) {
    aim_update_timer = 0;
    if (instance_exists(OBJ_Gorilla)) {
        var gor = instance_nearest(x, y, OBJ_Gorilla);
        image_angle = point_direction(x, y, gor.x, gor.y);
    } else {
        image_angle = 0;
    }
}

// Reset fire flag if aiming
if (state == BowState.AIMING) {
    has_fired = false;
}

// --- State Machine ---
switch (state) {
	case BowState.AIMING:
		image_index = 2;

		// Only increment frame_delay if not moving
		if (!owner_moving) {
		    frame_delay++;
		}

		if (frame_delay >= 240) {
		    if (instance_number(OBJ_Arrow) < 4) {
		        state = BowState.FIRE_START;
		        frame_delay = 0;
		    } else {
		        // wait again if too many arrows
		        frame_delay = 0;
		    }
		}
		break;

    case BowState.FIRE_START:
        image_index = 4;
        frame_delay++;
        if (frame_delay >= 10) {
            state = BowState.FIRE_END;
            frame_delay = 0;
        }
        break;

	case BowState.FIRE_END:
	    image_index = 5;
	    global.bowstate = BowState.FIRE_END;

	    if (!has_fired && !owner_moving) {
	        if (instance_exists(OBJ_Gorilla)) {
	            var gor = instance_nearest(x, y, OBJ_Gorilla);
	            var dir = point_direction(x, y, gor.x, gor.y);

	            var arrow = instance_create_layer(x, y, "Instances", OBJ_Arrow);
	            arrow.direction = dir;
	            arrow.speed = 0.5;
	            arrow.image_angle = dir;
	            arrow.image_xscale = 0.8;
	            arrow.image_yscale = 0.8;

	            var offset = 12;
	            arrow.x += lengthdir_x(offset, image_angle);
	            arrow.y += lengthdir_y(offset, image_angle);
				
				//sound
	            var snd_inst = audio_play_sound(SND_BowFire, 1, false);
	            audio_sound_pitch(snd_inst, random_range(0.9, 1.1));
	            audio_sound_gain(snd_inst, 1.3, 0);

	            has_fired = true;
	        }
	    }

	    frame_delay++;
	    if (frame_delay >= 10) {
	        state = BowState.AIMING;
	        frame_delay = 0;
	    }
	    break;
}
if (!instance_exists(owner) || owner.state == states.DEAD) {
    instance_destroy();
}