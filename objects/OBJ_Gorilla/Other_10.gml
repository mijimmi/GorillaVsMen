/// @description Sword

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

function spawnSword(image_xscale, scale){
	var slash = instance_create_layer(x, y, "Instances", OBJ_TreeSword)
		slash.image_xscale = image_xscale * scale
		slash.image_yscale = scale
		if (image_xscale == 1) {slash.addX = 50 * scale}
		if (image_xscale == -1) {slash.addX = -50 * scale}	
}
