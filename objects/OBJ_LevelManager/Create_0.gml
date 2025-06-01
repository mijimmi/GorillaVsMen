//enum for all the powertypes in the game, when you wanna add new shit just add it here
enum PowerType {
    HP,
    ATK,
    SPD,
	SWORD,
	BOULDER,
	BOOMERANG,
	FLOAT,
	DASH,
	DART,
	POOP
}

global.is_leveling_up = true;
var lvl_up_volume = 0.7; // adjust volume here
audio_play_sound(SND_LVL, 1, false);
audio_sound_gain(SND_LVL, lvl_up_volume, 0);

base_y = 1080/2;

// Create power-up list
power_ups = ds_list_create();
ds_list_add(power_ups, PowerType.HP, PowerType.SPD, PowerType.ATK);

// Add special powers if not maxed/unlocked
if (global.sword_level < 3)        { ds_list_add(power_ups, PowerType.SWORD); }
if (global.boulder_level < 3)      { ds_list_add(power_ups, PowerType.BOULDER); }
if (global.boomerang_level < 3)    { ds_list_add(power_ups, PowerType.BOOMERANG); }
if (global.float_level < 3)        { ds_list_add(power_ups, PowerType.FLOAT);} 
if (global.dart_level < 3)		   {ds_list_add(power_ups, PowerType.DART)}
if (global.poop_level < 3)		   {ds_list_add(power_ups, PowerType.POOP)}
if (!global.has_dash)              { ds_list_add(power_ups, PowerType.DASH); } 

//draws power ups from the power up list after it is shuffled
draw_powerups(power_ups, base_y)

//switch case that decides what to do deoending on the power you chose
function apply_powerup(type)
{
    switch (type)
    {
		case PowerType.HP:
		    var hp_increase = 10;
		    global.gorilla.hp_max += hp_increase;
		    global.gorilla.hp += hp_increase; // maintain current gap between max and current
		    break;

        case PowerType.ATK:
            global.gorilla.attack += 3;
            break;

        case PowerType.SPD:
            global.gorilla.move_spd += 0.2;
            break;
			
		case PowerType.SWORD:
			global.sword_level++
			break

		case PowerType.BOULDER:
			global.boulder_level++
			break
		
		case PowerType.BOOMERANG:
			global.boomerang_level++
			break
		
		case PowerType.DASH:
            global.has_dash = true;
            break;
			
		case PowerType.FLOAT:
			global.float_level++
			if (global.float_level == 3) {
				// Cleanup all float rocks
				for (var i = 0; i < array_length(global.floatRocks); i++) {
					if (instance_exists(global.floatRocks[i])) {
						with (global.floatRocks[i]) {
							instance_destroy();
						}
					}
				}
				global.floatRocks = [];
				with(OBJ_Gorilla){
					float_current_state = floatState.CONSTANT
				}
			}
			break
		//add the rest of the cases here
		case PowerType.DART:
			global.dart_level++
			//increases the amount of darts you can shoot in a burst
			if (global.dart_level == 1) {global.dart_max = 3}
			if (global.dart_level == 2) {global.dart_max = 6}
			if (global.dart_level == 3) {global.dart_max = 9}
			
		case PowerType.POOP:
			global.poop_level++
			if (global.poop_level == 1) {global.poop_max = 1}
			if (global.poop_level == 2) {global.poop_max = 2}
			if (global.poop_level == 3) {global.poop_max = 3}
			
    }	
	
}

//slam shuffle function 
function draw_powerups(power_ups, base_y)
{
    var screen_width = 1920;
    var screen_height = 1080;

    var scale = 7;
    var button_width = 32 * scale;
    var button_spacing = 24 * scale;
    var total_width = (button_width * 3) + (button_spacing * 2);

    // Center horizontally - account for sprite origin
    var start_x = (screen_width - total_width) / 2 + (button_width / 2);

    // Center vertically if base_y is not given
    if (argument_count < 2) {
        base_y = (screen_height / 2) + (button_width / 2);
    }

    ds_list_shuffle(power_ups);

    for (var i = 0; i < 3; i++) {
        var power_type = power_ups[| i];
        var draw_x = start_x + i * (button_width + button_spacing);

        var b = instance_create_layer(draw_x, base_y, "LevelUI", OBJ_LevelOption);
        b.button_id = i + 1;
        b.power_type = power_type;

        b.image_xscale = scale;
        b.image_yscale = scale;
    }
}

//destroys the level manager as well as the options upon picking an option
function cleanup() {
    with(OBJ_LevelOption) {
        instance_destroy();
    }
    
    if (ds_exists(power_ups, ds_type_list)) {
        ds_list_destroy(power_ups);
    }

    global.is_leveling_up = false;  // <-- UNPAUSE 

    instance_destroy(); // destroys the level manager itself
}
//add pauses

//to do next week: add a shuffling function. will do once i got power ups
//shufflin function done. implement function later that makes it so that when
//its max level it is removed from the list

