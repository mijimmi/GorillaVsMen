// --- Destroy if owner no longer exists ---
if (!variable_instance_exists(id, "owner") || !instance_exists(owner)) {
    instance_destroy();
    exit;
}

// --- Exit if leveling up ---
if (global.is_leveling_up) {
    exit;
}

// --- Follow the owner ---
x = owner.x;
y = owner.y - 10;

// --- Track owner movement ---
var owner_moving = false;
if (owner.x != last_owner_x || owner.y != last_owner_y) {
    owner_moving = true;
}
last_owner_x = owner.x;
last_owner_y = owner.y;

// --- Update aim every 5 frames ---
aim_update_timer++;
if (aim_update_timer >= 5) {
    aim_update_timer = 0;

    if (instance_exists(OBJ_Gorilla)) {
        var gor = instance_nearest(x, y, OBJ_Gorilla);
        var dir = point_direction(x, y, gor.x, gor.y);

        if (dir > 90 && dir < 270) {
            image_angle = 180 + dir;
            image_xscale = -1;
            sprite_index = SPR_Musket2;
        } else {
            image_angle = dir;
            image_xscale = 1;
            sprite_index = SPR_Musket;
        }
    } else {
        image_angle = 0;
        image_xscale = 1;
        sprite_index = SPR_Musket;
    }
}

// --- Reset fire flag if aiming ---
if (state == MusketState.AIMING) {
    has_fired = false;
}

// --- State Machine ---
switch (state) {
    case MusketState.AIMING:
        image_index = 0;

        if (!owner_moving) {
            frame_delay++;
        }

        // --- Emit pre-fire visual indicator ---
        if (frame_delay == 460) { // ~20 frames before firing
            part_emitter_region(part_sys, part_emitter, x-2, x+2, y-2, y+2, ps_shape_ellipse, ps_distr_gaussian);
            part_emitter_burst(part_sys, part_emitter, part_fire_warn, 10);
        }

        if (frame_delay >= 480) {
            if (instance_number(OBJ_BulletMusket) < 3) {
                state = MusketState.FIRE_START;
                frame_delay = 0;
            } else {
                frame_delay = 0;
            }
        }
        break;

    case MusketState.FIRE_START:
        image_index = 1 + frame_delay;

        frame_delay++;
        if (frame_delay >= 5) {
            state = MusketState.FIRE_END;
            frame_delay = 0;
        }
        break;

    case MusketState.FIRE_END:
        image_index = 5;
        global.musketstate = MusketState.FIRE_END;

        if (!has_fired && !owner_moving) {
            if (instance_exists(OBJ_Gorilla)) {
                var gor = instance_nearest(x, y, OBJ_Gorilla);
                var dir = point_direction(x, y, gor.x, gor.y);

                var bullet = instance_create_layer(x, y, "Instances", OBJ_BulletMusket);
                bullet.direction = dir;
                bullet.speed = 1.5;
                bullet.image_angle = dir;
                bullet.image_xscale = 0.5;
                bullet.image_yscale = 0.5;

                var offset = 12;
                bullet.x += lengthdir_x(offset, dir);
                bullet.y += lengthdir_y(offset, dir);

                var snd_inst = audio_play_sound(SND_Gunshot, 1, false);
                audio_sound_pitch(snd_inst, random_range(0.85, 1.05));
                audio_sound_gain(snd_inst, 0.5, 0);

                has_fired = true;
            }
        }

        frame_delay++;
        if (frame_delay >= 10) {
            state = MusketState.AIMING;
            frame_delay = 0;
        }
        break;
}