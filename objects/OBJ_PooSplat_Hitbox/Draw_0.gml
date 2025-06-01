draw_self();

var scaled_range = 16 * max(image_xscale, image_yscale);

draw_set_alpha(0.3);

// If any enemy is within range, draw green. Else, red.
if (enemy_in_range) {
    draw_set_color(c_lime);
} else {
    draw_set_color(c_red);
}

draw_circle(x, y, scaled_range, false);
draw_set_alpha(1);
