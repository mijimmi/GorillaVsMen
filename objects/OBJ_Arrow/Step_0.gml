// The arrow just moves in a straight line using its set speed & direction
x += lengthdir_x(speed, direction);
y += lengthdir_y(speed, direction);

// Optional: destroy if out of bounds
if (x < 0 || x > room_width || y < 0 || y > room_height) {
    instance_destroy();
}