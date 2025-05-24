// Inherit the parent event
if (keyboard_check(ord("P"))){
    draw_path(path, x, y, 0);
}

// shadow
draw_sprite_ext(SPR_Shadow, 0, x, y + 1, 0.5, 0.25, 0, c_black, 0.3);

// draw the archer sprite
draw_sprite_ext(sprite_index, image_index, x, y, facing, 1, 0, c_white, 1);

// draw bow over the archer
if (instance_exists(bow_inst)) {
    with (bow_inst) {
        // draw bow at current bow position and angle
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
    }
}
