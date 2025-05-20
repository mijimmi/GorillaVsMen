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
attack = 5;


//levels
level = 1;
xp = 0;
required_xp= 100;

function add_xp(_xp_to_add){
	xp += _xp_to_add;
	if (xp >= required_xp){
		level ++;
		effect_create_above(ef_flare, x, y, 1 , c_orange);
		level_up();
		xp -= required_xp;
		required_xp *= 1.2 //just change this value, this is how much the required EXP scales per level
	}
}

function level_up(){
//logic for leveling up here, set up a random number generator and a menu
//create instance of menu
hp_max += 5;
}