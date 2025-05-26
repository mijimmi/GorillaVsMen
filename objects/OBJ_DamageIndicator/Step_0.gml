y += vy;
lifespan--;
alpha = lifespan / 30; // fade out

if (lifespan <= 0) {
    instance_destroy();
}
