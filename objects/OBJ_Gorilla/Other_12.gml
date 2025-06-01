/// @description Boomerang
if (global.is_leveling_up) {
    exit;
}

var spread = 0
var dir = 0
switch(global.boomerang_level)
{
	case 0:
		break
	case 1:
		spawnBoomerang(getDirection())
		break
	//level 2 
	case 2:
		spread = 45
		dir = getDirection()
		spawnBoomerang(dir, 1.3)
		spawnSecondaryBoomerang(dir, spread, 1.3)
		break
	//case 3 spawns 3 boulders at once with a bigger size
	case 3:
		spread = 30
		dir = getDirection()
		spawnBoomerang(dir, 1.5)
		spawnSecondaryBoomerang(dir, spread, 1.5)
		spawnSecondaryBoomerang(dir, spread, 1.5)
		break
}

//spawns the main boomerang which tracks targets
function spawnBoomerang(dir, scale = 1.1){
	var boomerang = instance_create_layer(x , y, "Instances", OBJ_Boomerang)
	boomerang.owner = id; 

	boomerang.speed = 4
	boomerang.direction = dir
	
	boomerang.image_xscale = scale
	boomerang.image_yscale = scale
}

//function to get the location of the target
function getDirection(){
	if (instance_exists(OBJ_ParentEnemy)){
		var enem = instance_nearest(x,y, OBJ_ParentEnemy)
		dir = point_direction(x,y, enem.x, enem.y)
	}
	else {
		dir = image_xscale
	}
	return dir
}

//spawns the secondary boomerangs with a spread
function spawnSecondaryBoomerang(dir, spread, scale = 1.1){
	var boomerang = instance_create_layer(x , y, "Instances", OBJ_Boomerang)
	boomerang.speed = 4
	boomerang.direction = dir + random_range(-spread, spread)
	boomerang.image_xscale = scale
	boomerang.image_yscale = scale
}
