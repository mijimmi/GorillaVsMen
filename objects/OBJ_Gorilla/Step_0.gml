// === Delta time conversion ===
var dt = delta_time / 1000000; // Convert microseconds to seconds

// === Read Input Keys ===
var right_key = keyboard_check(vk_right) || keyboard_check(ord("D"));
var left_key  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var up_key    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
var down_key  = keyboard_check(vk_down)  || keyboard_check(ord("S"));

// === Calculate Intended Movement ===
var xdir = right_key - left_key;
var ydir = down_key - up_key;

// Normalize movement to prevent faster diagonal movement
var magnitude = point_distance(0, 0, xdir, ydir);
if (magnitude > 0) {
    xdir /= magnitude;
    ydir /= magnitude;
}

xspd = xdir * move_spd * dt;
yspd = ydir * move_spd * dt;

// === Check for Smash Input ===
if (mouse_check_button_pressed(mb_left) && current_state != GorillaState.SMASH) {
    current_state = GorillaState.SMASH;
    image_index = 0; // Start animation from beginning
}

// === State Machine ===
switch (current_state) {
    case GorillaState.IDLE:
        if (xdir != 0 || ydir != 0) {
            current_state = GorillaState.MOVING;
        }
        sprite_index = SPR_Gorilla_Idle;
        image_speed = 1;
        image_xscale = (facing == "right") ? 1 : -1;
        break;

    case GorillaState.MOVING:
        if (xdir == 0 && ydir == 0) {
            current_state = GorillaState.IDLE;
        }

        if (xdir > 0) {
            facing = "right";
            sprite_index = SPR_Gorilla_Right;
            image_xscale = 1;
        } else if (xdir < 0) {
            facing = "left";
            sprite_index = SPR_Gorilla_Right;
            image_xscale = -1;
        } else if (ydir != 0) {
            sprite_index = SPR_Gorilla_Right;
            image_xscale = (facing == "right") ? 1 : -1;
        }

        image_speed = 1;
        break;

    case GorillaState.SMASH:
        sprite_index = SPR_Gorilla_Smash;
        image_speed = 1.1;
        image_xscale = (facing == "right") ? 1 : -1;

        // Freeze animation and return to idle after finishing smash
        if (image_index >= image_number - 1) {
            image_speed = 0;
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