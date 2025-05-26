///@description Boulder

switch(global.boulder_level)
{
	case 0:
		break
	case 1:
		spawnBoulder(1)
		break
	//case 2 spawns 2 bolders at once with a bigger size
	case 2:
		spawnBoulder(1.1)
		spawnBoulder(1.1)
		break
	//case 3 spawns 3 boulders at once with a bigger size
	case 3:
		spawnBoulder(1.2)
		spawnBoulder(1.2)
		spawnBoulder(1.2)
		break
}

//takes in boulder size as a argument so it can change dynamically
function spawnBoulder(scale = 1){
	var boulder = instance_create_layer(x , y, "Instances", OBJ_Boulder)
		boulder.direction = irandom_range(45, 135)
		boulder.speed = 4
		boulder.gravity = 0.1
		boulder.friction = 0.01	
}


