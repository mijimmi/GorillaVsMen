lifetime--;
image_alpha -= fade_speed;

if (lifetime <= 0 || image_alpha <= 0) {
    instance_destroy();
}