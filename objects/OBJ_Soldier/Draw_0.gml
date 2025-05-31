// Draw shadow
draw_sprite_ext(SPR_Shadow, 0, x, y + 1, 0.5, 0.25, 0, c_black, 0.3);

// Draw soldier sprite
draw_sprite_ext(sprite_index, image_index, x, y, facing, 1, 0, c_white, 1);

// Draw rifle on soldier
if (instance_exists(rifle_inst)) {
    with (rifle_inst) {
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
    }
}
