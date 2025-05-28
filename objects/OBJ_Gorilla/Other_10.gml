/// @description Sword

if (global.is_leveling_up) {
    exit;
}

switch(global.sword_level)
{
	case 0:
		break
	case 1:
		spawnSword(image_xscale,1)
		break
	case 2: //(make it bigger?)
		spawnSword(image_xscale, 1.2)
		break
	//case 3 (add one slash behind u?)
	case 3:
		spawnSword(image_xscale, 1.3)
		//add a timer in between
		alarm[11] = 20
		break
}

function spawnSword(image_xscale, scale) {
    var offset = (image_xscale == 1 ? 50 : -50) * scale;

    // Create the visual slash object
    var slash = instance_create_layer(x, y, "Instances", OBJ_TreeSword);
    slash.image_xscale = image_xscale * scale;
    slash.image_yscale = scale;
    slash.x += offset;

    slash.addX = offset;

    // Create the hitbox at the same position
    var hitbox = instance_create_layer(x, y, "Hitboxes", OBJ_TreeSword_Hitbox);
    hitbox.image_xscale = image_xscale * scale;
    hitbox.image_yscale = scale;
    hitbox.x += offset;
}

