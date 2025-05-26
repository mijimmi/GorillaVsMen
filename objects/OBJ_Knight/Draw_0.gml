// Inherit the parent event
event_inherited();

// draw the spear over the Roman
if (instance_exists(sword_inst)) {
    with (sword_inst) {
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
    }
}