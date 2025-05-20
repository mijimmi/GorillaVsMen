if (instance_exists(OBJ_Gorilla)) {
    var target_x = OBJ_Gorilla.x - view_w / 2;
    var target_y = OBJ_Gorilla.y - view_h / 2;

    var cam_x = lerp(camera_get_view_x(camera), target_x, 0.1);
    var cam_y = lerp(camera_get_view_y(camera), target_y, 0.1);

    // === Apply Camera Shake ===
    if (shake_timer > 0) {
        var shake_x = random_range(-shake_magnitude, shake_magnitude);
        var shake_y = random_range(-shake_magnitude, shake_magnitude);
        cam_x += shake_x;
        cam_y += shake_y;
        shake_timer--;
    }

    cam_x = clamp(cam_x, 0, room_width - view_w);
    cam_y = clamp(cam_y, 0, room_height - view_h);

    camera_set_view_pos(camera, cam_x, cam_y);
}