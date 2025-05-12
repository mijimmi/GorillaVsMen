// === Enum for states ===
enum GorillaState {
    IDLE,
    MOVING,
    SMASH
}

// === Initialize variables ===
if (!variable_global_exists("initialized")) {
    current_state = GorillaState.IDLE;
    xspd = 0;
    yspd = 0;
    sprite_index = SPR_Gorilla_Idle;
    image_speed = 1;
    move_spd = 120; // Pixels per second
    facing = "right"; // "left" or "right"
    hp = 20;
    hp_max = 20;
    global.initialized = true;
}