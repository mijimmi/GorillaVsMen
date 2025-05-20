// Capture screen on pause
if (pause && pausePendingCapture) {
    pausePendingCapture = false;

    if (surface_exists(pauseSurf)) surface_free(pauseSurf);
    pauseSurf = surface_create(resw, resh);

    surface_set_target(pauseSurf);
    draw_surface(application_surface, 0, 0);
    surface_reset_target();

    if (buffer_exists(pauseSurfBuffer)) buffer_delete(pauseSurfBuffer);
    pauseSurfBuffer = buffer_create(resw * resh * 4, buffer_fixed, 1);
    buffer_get_surface(pauseSurfBuffer, pauseSurf, 0);
}