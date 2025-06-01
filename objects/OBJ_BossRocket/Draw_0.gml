// === DRAW EVENT ===
if (rocket_state == "warning") {
    // Fade in red horizontal oval indicator
    draw_set_alpha(warning_alpha);
    draw_set_color(c_red);
    draw_ellipse(x - aoe_radius, y - aoe_radius/2, x + aoe_radius, y + aoe_radius/2, false);
    draw_set_alpha(1);  // Reset alpha
} else if (rocket_state == "active") {
    // Final hit with border
    draw_set_color(c_red);
    draw_ellipse(x - aoe_radius, y - aoe_radius/2, x + aoe_radius, y + aoe_radius/2, false);  // Filled red
    draw_set_color(c_black);
    draw_ellipse(x - aoe_radius, y - aoe_radius/2, x + aoe_radius, y + aoe_radius/2, true);   // Black border
}