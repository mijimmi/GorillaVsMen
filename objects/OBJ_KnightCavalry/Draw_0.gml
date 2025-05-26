if keyboard_check(ord("P")){
	draw_path(path, x, y, 0);
}

//shadow
draw_sprite_ext(SPR_Shadow, 0, x, y + 1, 1, 0.25, 0, c_black, 0.3);



draw_sprite_ext(sprite_index, image_index, x, y, facing, 1, 0, c_white,1);

// drawing sprite
