x += hsp;
y += vsp;

// Apply friction to stop over time
hsp *= 0.9;
vsp *= 0.9;

// Despawn countdown
lifetime--;
if (lifetime <= 0) {
    instance_destroy();
}