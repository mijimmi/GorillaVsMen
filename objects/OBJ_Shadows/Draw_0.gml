if (!surface_exists(shadowSurface)) {
	shadowSurface = surface_create(640, 360);
}

var viewX = camera_get_view_x(view_camera[0]);
var viewY = camera_get_view_y(view_camera[0]);

surface_set_target(shadowSurface);
draw_clear_alpha(c_black, 0);

var sx = skewX;
var sy = shadowHeight;

gpu_set_fog(true, c_black, 0, 1);
with (OBJ_Parent) {
    draw_sprite_pos(sprite_index, image_index,
        x - (sprite_width / 2) - viewX - sx,
        y - viewY - sy,  // <-- moved up by 2
        x + (sprite_width / 2) - viewX - sx,
        y - viewY - sy,  // <-- moved up by 2
        x - (sprite_width / 2) - viewX,
        y - viewY,       // <-- moved up by 2
        x + (sprite_width / 2) - viewX,
        y - viewY,       // <-- moved up by 2
        1);
}
gpu_set_fog(false, c_white, 0, 0);
surface_reset_target();

draw_set_alpha(0.5);
draw_surface(shadowSurface, viewX, viewY - 1);  // <-- moved up by 2
draw_set_alpha(1);