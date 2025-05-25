event_inherited();

//chasing the player
alert = false;
alert_dis = 1000;
//distance from player
attack_dis = 1;
//create path resource
path = path_add();
//move speed
move_spd = 0.7;
//set delay for path
calc_path_delay = 30;
// set timer
calc_path_timer = irandom(60);

// Knockback variables
knockback_x = 0;
knockback_y = 0;
knockback_timer = 0;
knockback_duration = 10; // How long knockback lasts (in steps)
