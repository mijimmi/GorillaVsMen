// Zoom in 2.2x more than the normal view
view_w = 320;
view_h = 180;

camera = camera_create_view(0, 0, view_w, view_h, 0, noone, -1, -1, -1, -1);
view_camera[0] = camera;