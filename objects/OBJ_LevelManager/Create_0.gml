//enum for all the powertypes in the game, when you wanna add new shit just add it here
enum PowerType {
    HP,
    ATK,
    SPD,
	SWORD,
	BOULDER
}

global.is_leveling_up = true;


// Create power-up list
power_ups = ds_list_create();
ds_list_add(power_ups, PowerType.SWORD, PowerType.BOULDER, PowerType.HP, PowerType.SPD, PowerType.ATK); // shuffle later

//draws power ups from the power up list after it is shuffled
draw_powerups(power_ups, x, y)

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
		//add the rest of the cases here
    }	
	
}

//slam shuffle function 
function draw_powerups(power_ups, base_y)
{
    var screen_center_x = 1920 / 2;
    var scale = 5;
    var sprite_size = 36; // if your button sprite is 36x36
    var button_width = sprite_size * scale;
    var spacing = button_width + 20;
    var total_width = spacing * 3 - 20;
    var start_x = screen_center_x - total_width / 2;

    ds_list_shuffle(power_ups);

    for (var i = 0; i < 3; i++) {
        var power_type = power_ups[|i];
        var draw_x = start_x + i * spacing;

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

