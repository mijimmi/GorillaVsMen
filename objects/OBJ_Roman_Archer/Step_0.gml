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

if (!did_evade) {
    switch (state) {
        case states.IDLE:
            check_for_player();
            if (path_index != 1) state = states.MOVE;
            check_facing();
            enemy_anim();
            break;
        case states.MOVE:
            check_for_player();
            check_facing();
            if (path_index == 1) state = states.IDLE;
            enemy_anim();
            break;
        case states.DEAD:
            break;
    }

    if (global.is_leveling_up) {
        path_end();
    }
}