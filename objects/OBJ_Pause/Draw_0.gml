// Draw pause screen
if (pause) {
    if (surface_exists(pauseSurf)) {
        draw_surface(pauseSurf, 0, 0);
    } else if (buffer_exists(pauseSurfBuffer)) {
        pauseSurf = surface_create(resw, resh);
        buffer_set_surface(pauseSurfBuffer, pauseSurf, 0);
        draw_surface(pauseSurf, 0, 0);
    }
}