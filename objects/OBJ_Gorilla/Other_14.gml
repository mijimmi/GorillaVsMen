/// @description DooDooFart
if (global.is_leveling_up) {
    exit;
}

switch(global.poop_level)
{
	case 0: 
		break
	case 1:
		spawnPoopSplat()
		break
	case 2:
		spawnPoopSplat()
		break
	case 3:
		spawnPoopSplat()
		break
}

function spawnPoopSplat()
{
	var pos = randomizeArea()
	var rx = pos[0]
	var ry = pos[1]
	var poop = instance_create_layer(rx,ry,"Instances",OBJ_PooSplat)
	poop.image_xscale = 3
	poop.image_yscale = 2.5
}

function randomizeArea()
{
    var vx = camera_get_view_x(view_camera[0])
    var vy = camera_get_view_y(view_camera[0])
    var vw = camera_get_view_width(view_camera[0])
    var vh = camera_get_view_height(view_camera[0])
	
    var rx = random_range(vx + 32, vx + vw - 32)
    var ry = random_range(vy + 32, vy + vh - 32)
		
	return [rx,ry]
	
}