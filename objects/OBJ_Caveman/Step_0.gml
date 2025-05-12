// Check if the gorilla object exists
if (instance_exists(OBJ_Gorilla)) {
    // Get the direction to the gorilla
    var dir = point_direction(x, y, OBJ_Gorilla.x, OBJ_Gorilla.y);
    
    // Move towards the gorilla
    x += lengthdir_x(follow_speed, dir);
    y += lengthdir_y(follow_speed, dir);
}