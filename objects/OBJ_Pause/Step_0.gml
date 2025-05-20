// Pause toggle logic
if (keyboard_check_pressed(vk_escape)) {
    if (!pause) {
        pause = true;
        pausePendingCapture = true; // defer capture to Draw End
        instance_deactivate_all(true);
    } else {
        pause = false;
        instance_activate_all();

        if (surface_exists(pauseSurf)) surface_free(pauseSurf);
        if (buffer_exists(pauseSurfBuffer)) buffer_delete(pauseSurfBuffer);
    }
}