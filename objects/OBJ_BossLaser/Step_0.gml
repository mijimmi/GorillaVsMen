// Follow FinalBoss's position
if (instance_exists(owner)) {
    x = owner.x;
    y = owner.y;
} else {
    instance_destroy();
    exit;
}

// Rotate laser
angle += rotation_speed;

// Only do damage during active state
if (laser_state == "active") {
    // Collision check with Gorilla
    var directions = [0, 90, 180, 270];
    for (var i = 0; i < array_length(directions); i++) {
        var dir = angle + directions[i];
        var lx = x + lengthdir_x(1000, dir);
        var ly = y + lengthdir_y(1000, dir);
        if (collision_line(x, y, lx, ly, OBJ_Gorilla, false, true)) {
            with (OBJ_Gorilla) {
                hp -= 1;
            }
        }
    }
}