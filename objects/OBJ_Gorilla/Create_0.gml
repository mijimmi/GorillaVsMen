event_inherited();
//global gorilla ID so that stats can be easily accessed
global.gorilla = id

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
smash_cooldown = 0;

footstep_timer = 0;
footstep_interval = 20; // Number of steps between footstep sounds

// Hitbox Variable
hitbox_spawned = false;


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
		required_xp *= 1.3 //just change this value, this is how much the required EXP scales per level
	}
}

function level_up(){

//puts it down in the UI
var _vx = camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0])/2) //puts stuff on the center
var _vy = camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0])/2)

//creates an instance of the level manager
var a = instance_create_layer(x, y, "LevelUI", OBJ_LevelManager);
}


//ATTACK LOGIC HERE
//global list of variables for the power up levels
global.sword_level = 0
global.boulder_level = 0

//attack timing
global.slashAlarm = 80
global.boulderAlarm = 150

alarm[0] = global.slashAlarm
alarm[1] = global.boulderAlarm

