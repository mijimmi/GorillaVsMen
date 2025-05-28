// move outward
x += lengthdir_x(speed, direction);
y += lengthdir_y(speed, direction);

// fade out
life -= 1;
image_alpha = life / max_life;
image_angle += 5;

if (life <= 0) {
    instance_destroy();
}