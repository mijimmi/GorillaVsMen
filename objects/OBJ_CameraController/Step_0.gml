if (instance_exists(OBJ_Gorilla)) { // Check if a Gorilla exists.
    var target_x = OBJ_Gorilla.x - view_w / 2; // Calculate target x to center on Gorilla.
    var target_y = OBJ_Gorilla.y - view_h / 2; // Calculate target y to center on Gorilla.

    var cam_x = lerp(camera_get_view_x(camera), target_x, 0.1); // Smoothly move camera x towards target.
    var cam_y = lerp(camera_get_view_y(camera), target_y, 0.1); // Smoothly move camera y towards target.

    cam_x = clamp(cam_x, 0, room_width - view_w); // Keep camera x within room bounds.
    cam_y = clamp(cam_y, 0, room_height - view_h); // Keep camera y within room bounds.

    camera_set_view_pos(camera, cam_x, cam_y); // Set the camera's new position.
}

randomize();