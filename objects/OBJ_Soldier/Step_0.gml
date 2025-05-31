// Knockback handling
if (knockback_timer > 0) {
    knockback_timer--;
    x += knockback_x;
    y += knockback_y;

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
    var safe_dist = 70;

    if (dist < safe_dist) {
        // Evade player
        var dir_away = point_direction(gor.x, gor.y, x, y);
        x += lengthdir_x(move_spd * 0.3, dir_away);
        y += lengthdir_y(move_spd * 0.3, dir_away);

        facing = (gor.x > x) ? 1 : -1;

        x = clamp(x, sprite_width * 0.5, room_width - sprite_width * 0.5);
        y = clamp(y, sprite_height * 0.5, room_height - sprite_height * 0.5);

        did_evade = true;
    }
}

if (is_hurt) {
    hurt_timer--;
    if (hurt_timer <= 0) {
        is_hurt = false;
        hurt_timer = 0;
    }
}

switch (state) {
    case states.IDLE:
        // logic to find player, start moving
        check_for_player();  // define this in your code or replace
        if (path_index != 1) state = states.MOVE;
        enemy_anim();
        break;

    case states.MOVE:
        check_for_player();
        check_facing();
        if (path_index == 1) state = states.IDLE;
        enemy_anim();
        break;

    case states.DEAD:
        death_timer++;
        path_end();
        move_spd = 0;
        enemy_anim();

        if (death_timer > death_duration) {
            instance_destroy();
        }
        break;
}

if (global.is_leveling_up) {
    path_end();
}