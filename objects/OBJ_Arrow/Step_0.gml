if (global.is_leveling_up) {
	arrow_ps = -1;
    instance_destroy();
	exit;
}

// The arrow just moves in a straight line using its set speed & direction
x += lengthdir_x(speed, direction);
y += lengthdir_y(speed, direction);


part_particles_create(arrow_ps, x, y, arrow_pt, 1);

// Sync hitbox to this arrow's position
if (instance_exists(hitbox)) {
    hitbox.x = x;
    hitbox.y = y;
    hitbox.image_angle = image_angle; // <-- Add this line
}

// Optional: destroy if out of bounds
if (x < 0 || x > room_width || y < 0 || y > room_height) {
    instance_destroy();
}