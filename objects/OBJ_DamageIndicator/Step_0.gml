y += vy;
lifespan--;

if (lifespan < 10) {
    alpha = lifespan / 10; // fast fade out
} else {
    alpha = 1;
}

if (lifespan <= 0) {
    instance_destroy();
}
