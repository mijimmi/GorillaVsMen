if (global.is_leveling_up) {
    exit;
}

// The arrow just moves in a straight line using its set speed & direction
x += lengthdir_x(speed, direction);
y += lengthdir_y(speed, direction);


part_particles_create(arrow_ps, x, y, arrow_pt, 1);

// Optional: destroy if out of bounds
if (x < 0 || x > room_width || y < 0 || y > room_height) {
    instance_destroy();
}