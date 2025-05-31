/// @description Dart
if (global.is_leveling_up) {
    exit;
}

switch(global.dart_level)
{
	case 0:
		break
	case 1:
		spawnDart(getDirection())
		break
	case 2:
		spawnDart(getDirection())
		break
	case 3:
		spawnDart(getDirection())
		break
}


function spawnDart(dir){
	var dart = instance_create_layer(x, y, "Instances", OBJ_DartMonkey)
	dart.owner = id;
	dart.image_angle = dir
	dart.speed =  4
	dart.direction = dir
	dart.image_xscale = 0.70;
	dart.image_yscale = 0.70;
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
