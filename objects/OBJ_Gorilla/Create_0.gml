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
move_spd = 1.5;
facing = "right"; // "left" or "right"
hp= 20;
hp_max = 20;
