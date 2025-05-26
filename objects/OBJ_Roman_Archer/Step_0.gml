event_inherited();
// Knockback handling
if (knockback_timer > 0) {
    knockback_timer--;
    x += knockback_x;
    y += knockback_y;

    // Clamp to room bounds (center origin version)
    var half_w = sprite_width * 0.5;
    var half_h = sprite_height * 0.5;
    x = clamp(x, half_w, room_width - half_w);
    y = clamp(y, half_h, room_height - half_h);

    path_end();
    exit;
}

var did_evade = false;

if (instance_exists(OBJ_Gorilla)) {
    var gor = instance_nearest(x, y, OBJ_Gorilla);
    var dist = point_distance(x, y, gor.x, gor.y);
    var safe_dist = 64;

    if (dist < safe_dist) {
        check_for_player();
        check_facing();

        var dir_away = point_direction(gor.x, gor.y, x, y);
        x += lengthdir_x(0.5, dir_away);
        y += lengthdir_y(0.5, dir_away);

        facing = (gor.x > x) ? 1 : -1;

        x = clamp(x, sprite_width * 0.5, room_width - sprite_width * 0.5);
        y = clamp(y, sprite_height * 0.5, room_height - sprite_height * 0.5);

        did_evade = true;
    }
}

