// Destroy if owner no longer exists
if (!variable_instance_exists(id, "owner") || !instance_exists(owner)) {
    instance_destroy();
    exit;
}

// Exit if leveling up
if (global.is_leveling_up) {
    exit;
}

// Follow owner with offset
x = owner.x;
y = owner.y - 10;

// Check if owner moving
var owner_moving = false;
if (owner.x != last_owner_x || owner.y != last_owner_y) {
    owner_moving = true;
}
last_owner_x = owner.x;
last_owner_y = owner.y;

// Update aim every 5 frames
aim_update_timer++;
if (aim_update_timer >= 5) {
    aim_update_timer = 0;

    if (instance_exists(OBJ_Gorilla)) {
        var gor = instance_nearest(x, y, OBJ_Gorilla);
        var dir = point_direction(x, y, gor.x, gor.y);

        if (dir > 90 && dir < 270) {
            image_angle = 180 + dir;
            image_xscale = -1;
            sprite_index = SPR_Rifle; // assume alternative sprite facing left
        } else {
            image_angle = dir;
            image_xscale = 1;
            sprite_index = SPR_Rifle;
        }
    } else {
        image_angle = 0;
        image_xscale = 1;
        sprite_index = SPR_Rifle;
    }
}


// Reset fire flag if aiming
if (state == RifleState.AIMING) {
    has_fired = false;
    shot_count = 0;      // reset shot counter when entering aiming
    shot_delay = 0;      // reset delay timer between shots
}

// State machine
switch (state) {
    case RifleState.AIMING:
        image_index = 0; // aiming frame

        if (!owner_moving) frame_delay++;

        if (frame_delay == 340) { // pre-fire warning
            part_emitter_region(part_sys, part_emitter, x-2, x+2, y-2, y+2, ps_shape_ellipse, ps_distr_gaussian);
            part_emitter_burst(part_sys, part_emitter, part_fire_warn, 10);
        }

        if (frame_delay >= 360) {
            state = RifleState.FIRE_START;
            frame_delay = 0;
            shot_count = 0;
            shot_delay = 0;
        }
        break;

    case RifleState.FIRE_START:
        image_index = 1; // firing frame

        shot_delay++;
        if (shot_delay >= 6) { // delay between each bullet shot (6 steps = ~0.1 sec at 60fps)
            if (!has_fired && !owner_moving && instance_exists(OBJ_Gorilla)) {
                var gor = instance_nearest(x, y, OBJ_Gorilla);
                var dir = point_direction(x, y, gor.x, gor.y);

                var bullet = instance_create_layer(x, y, "Instances", OBJ_BulletRifle);
                bullet.direction = dir;
                bullet.speed = 1;
                bullet.image_angle = dir;
                bullet.image_xscale = 0.5;
                bullet.image_yscale = 0.5;

                var offset = 14;
                bullet.x += lengthdir_x(offset, dir);
                bullet.y += lengthdir_y(offset, dir);

                var snd_inst = audio_play_sound(SND_Rifle, 1, false);
                audio_sound_pitch(snd_inst, random_range(0.85, 1.05));
                audio_sound_gain(snd_inst, 0.2, 0);
				
                shot_count++;
                if (shot_count >= 4) {
                    has_fired = true; // done shooting 4 bullets
                    state = RifleState.FIRE_END;
                    frame_delay = 0;
                }
                shot_delay = 0;
            }
        }
        break;

    case RifleState.FIRE_END:
        image_index = 2; // firing end frame

        frame_delay++;
        if (frame_delay >= 10) {
            state = RifleState.AIMING;
            frame_delay = 0;
        }
        break;
}