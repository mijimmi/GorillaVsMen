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

hp_max = 1;   // fallback default
hp = hp_max;

death_timer = 0;
death_duration = 30; // how many steps to show the blood sprite before destroying
hurt_duration = 30;  // 30 steps @60fps ≈ 0.5 seconds
is_hurt = false;
hurt_timer = 0;
s_dead = [SPR_Blood_1, SPR_Blood_2, SPR_Blood_3, SPR_Blood_4];
s_dead_selected = -1;