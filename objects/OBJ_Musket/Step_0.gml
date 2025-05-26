// Destroy if owner no longer exists
if (!variable_instance_exists(id, "owner") || !instance_exists(owner)) {
    instance_destroy();
    exit;
}

// Exit if leveling up
if (global.is_leveling_up) {
    exit;
}

// Follow the owner
x = owner.x;
y = owner.y - 10;

// --- Track owner movement ---
var owner_moving = false;
if (owner.x != last_owner_x || owner.y != last_owner_y) {
    owner_moving = true;
}
last_owner_x = owner.x;
last_owner_y = owner.y;

// --- Update aim every 40 frames ---
aim_update_timer++;
if (aim_update_timer >= 5) {
    aim_update_timer = 0;
    
    if (instance_exists(OBJ_Gorilla)) {
        var gor = instance_nearest(x, y, OBJ_Gorilla);
        var dir = point_direction(x, y, gor.x, gor.y);
        
        if (dir > 90 && dir < 270) {
            // Aiming left side: flip sprite horizontally and adjust angle
            image_angle = 180+dir;
            image_xscale = -1;
            sprite_index = SPR_Musket2;
        } else {
            // Aiming right side: normal rotation and sprite
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

// Reset fire flag if aiming
if (state == MusketState.AIMING) {
    has_fired = false;
}

// --- State Machine ---
switch (state) {
    case MusketState.AIMING:
        image_index = 0; // only frame 1 while aiming

        if (!owner_moving) {
            frame_delay++;
        }

        if (frame_delay >= 480) { // long reload before firing
            if (instance_number(OBJ_BulletMusket) < 4) {
                state = MusketState.FIRE_START;
                frame_delay = 0;
            } else {
                frame_delay = 0; // retry later if too many bullets
            }
        }
        break;

    case MusketState.FIRE_START:
        // Step through firing frames: 2 → 3 → 4 → 5 → 6
        image_index = 1 + frame_delay;

        frame_delay++;
        if (frame_delay >= 5) { // total of 5 frames: 2–6
            state = MusketState.FIRE_END;
            frame_delay = 0;
        }
        break;

    case MusketState.FIRE_END:
        image_index = 5; // hold on last firing frame
        global.musketstate = MusketState.FIRE_END;

        if (!has_fired && !owner_moving) {
            if (instance_exists(OBJ_Gorilla)) {
                var gor = instance_nearest(x, y, OBJ_Gorilla);
                var dir = point_direction(x, y, gor.x, gor.y);

                var bullet = instance_create_layer(x, y, "Instances", OBJ_BulletMusket);
                bullet.direction = dir;
                bullet.speed = 1.5;
                bullet.image_angle = dir;
                bullet.image_xscale = 0.8;
                bullet.image_yscale = 0.8;

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