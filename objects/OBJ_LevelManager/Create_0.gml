//enum for all the powertypes in the game, when you wanna add new shit just add it here
enum PowerType {
    HP,
    ATK,
    SPD
}

global.is_leveling_up = true;

// Create power-up list
power_ups = ds_list_create();
ds_list_add(power_ups, PowerType.HP, PowerType.ATK, PowerType.SPD); // shuffle later



//switch case that decides what to do deoending on the power you chose
function apply_powerup(type)
{
    switch (type)
    {
        case PowerType.HP:
            global.gorilla.hp_max += 10;
            break;

        case PowerType.ATK:
            global.gorilla.attack += 5;
            break;

        case PowerType.SPD:
            global.gorilla.move_spd += 1;
            break;
			
		//add the rest of the cases here
    }	
	
}

//slam shuffle function 
function draw_powerups(power_ups)
{
	
	// Create buttons
	var scale = 5
	var button_height = 36 * scale

	ds_list_shuffle(power_ups)
	
	for (var i = 0; i < 3; i++) {
		
	
		var power_type = power_ups[|i]
		
	    var b = instance_create_layer(x, y + i * button_height, "LevelUI", OBJ_LevelOption);
	    b.button_id = i + 1;
	    b.power_type = power_type
    
	    // Make the button visually bigger
	    b.image_xscale = 2; // double the width
	    b.image_yscale = 2; // double the height
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

