// === Read Input Keys ===
right_key = keyboard_check(vk_right) || keyboard_check(ord("D"));
left_key = keyboard_check(vk_left) || keyboard_check(ord("A"));
up_key = keyboard_check(vk_up) || keyboard_check(ord("W"));
down_key = keyboard_check(vk_down) || keyboard_check(ord("S"));

// === Calculate Intended Movement ===
xspd = (right_key - left_key) * move_spd;
yspd = (down_key - up_key) * move_spd;

// === Check for Smash Input ===
if (mouse_check_button_pressed(mb_left) && current_state != GorillaState.SMASH) {
    current_state = GorillaState.SMASH;
    image_index = 0; // Start animation from the beginning
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
        break;

	case GorillaState.SMASH:
	    sprite_index = SPR_Gorilla_Smash;
	    image_speed = 1.1;
	    image_xscale = (facing == "right") ? 1 : -1;

	    // Stop animation at the last frame, then switch state
	    if (image_index >= image_number - 1) {
	        image_speed = 0; // Freeze at last frame to avoid looping
	        current_state = GorillaState.IDLE;
	        image_index = 0; // Reset for next use
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

/// === Gorilla Damage Function ===
function gorilla_take_damage(amount) {
    hp -= amount;

    if (hp <= 0) {
        // Play death animation, effects, etc.
        instance_destroy();
    }
}