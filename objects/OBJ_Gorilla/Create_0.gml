// === Read Input Keys ===
right_key = keyboard_check(vk_right) || keyboard_check(ord("D"));
left_key = keyboard_check(vk_left) || keyboard_check(ord("A"));
up_key = keyboard_check(vk_up) || keyboard_check(ord("W"));
down_key = keyboard_check(vk_down) || keyboard_check(ord("S"));

// Enum for states
enum GorillaState {
    IDLE,
    MOVING,
    SMASH
}

// Initialize variables
current_state = GorillaState.IDLE;  // Start in the idle state
xspd = 0;
yspd = 0;
sprite_index = SPR_Gorilla_Idle;
image_speed = 1;
move_spd = 2;
facing = "right"; // "left" or "right"
hp = 20;