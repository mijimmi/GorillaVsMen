// Zoom in 2.2x more than the normal view
view_w = 400;
view_h = 225;

camera = camera_create_view(0, 0, view_w, view_h, 0, noone, -1, -1, -1, -1);
shake_timer = 0;
shake_magnitude = 0;
view_camera[0] = camera;

