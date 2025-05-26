if (!variable_instance_exists(id, "owner") || !instance_exists(owner)) {
    instance_destroy();
    exit;
}

if (instance_exists(owner)) {
    var bob_offset = sin(degtorad(bob_phase)) * 1.5; // adjust 1.5 for bob strength
    bob_phase += 6; // adjust speed of bobbing (6 degrees per step)

    // keep phase within bounds
    if (bob_phase > 360) bob_phase -= 360;

    // position relative to owner + bobbing
    x = owner.x + (owner.facing * 6);
    y = owner.y - 2 + bob_offset;

    image_index = owner.image_index;
	image_angle = (owner.facing == 1) ? -20 : 20;

    image_xscale = owner.facing * 0.7; // flip + scale
    image_yscale = 0.7;
}