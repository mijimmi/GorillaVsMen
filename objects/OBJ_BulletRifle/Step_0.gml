if (global.is_leveling_up) {
    // make sure no particle draw happens
    bullet_ps = -1;
    instance_destroy();
    exit; // optional, just for safety
}

// Move forward
x += lengthdir_x(speed, direction);
y += lengthdir_y(speed, direction);

if (instance_exists(hitbox)) {
    hitbox.x = x;
    hitbox.y = y;
    hitbox.image_angle = image_angle; // <-- Add this line
}

// Trail effect
part_particles_create(bullet_ps, x, y, bullet_pt, 1);

// Destroy if out of bounds
if (x < 0 || x > room_width || y < 0 || y > room_height) {
    instance_destroy();
}
