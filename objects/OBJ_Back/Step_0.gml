// Change color when mouse hovers over button
if (position_meeting(mouse_x, mouse_y, id)) {
    image_blend = c_red; // Highlight color when hovering
    image_scale = 1.1;      // Slightly bigger when hovering
} else {
    image_blend = c_white;  // Normal color
    image_scale = 1.0;      // Normal size
}
