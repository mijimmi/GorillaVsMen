// Destroy if owner no longer exists
if (!variable_instance_exists(id, "owner") || !instance_exists(owner)) {
    instance_destroy();
    exit;
}

// Follow the owner
x = owner.x;
y = owner.y - 10;

// Update aim every 20 frames
aim_update_timer++;
if (aim_update_timer >= 20) {
    aim_update_timer = 0;
    if (instance_exists(OBJ_Gorilla)) {
        var gor = instance_nearest(x, y, OBJ_Gorilla);
        image_angle = point_direction(x, y, gor.x, gor.y);
    } else {
        image_angle = 0;
    }
}

// Reset fire flag if aiming
if (state == BowState.AIMING) {
    has_fired = false;
}

// --- State Machine ---
switch (state) {
    case BowState.AIMING:
        image_index = 2;
        frame_delay++;
        if (frame_delay >= 240) {
            state = BowState.FIRE_START;
            frame_delay = 0;
        }
        break;

    case BowState.FIRE_START:
        image_index = 4;
        frame_delay++;
        if (frame_delay >= 10) {
            state = BowState.FIRE_END;
            frame_delay = 0;
        }
        break;

    case BowState.FIRE_END:
        image_index = 5;
        global.bowstate = BowState.FIRE_END;

        if (!has_fired) {
			if (instance_exists(OBJ_Gorilla)) {
			    var gor = instance_nearest(x, y, OBJ_Gorilla);
			    var dir = point_direction(x, y, gor.x, gor.y);

			    var arrow = instance_create_layer(x, y, "Instances", OBJ_Arrow);
			    arrow.direction = dir;
			    arrow.speed = 1;
			    arrow.image_angle = dir; // rotate sprite
				arrow.image_xscale = 0.9;
				arrow.image_yscale = 0.9;

                // offset spawn point from bow
                var offset = 12;
                arrow.x += lengthdir_x(offset, image_angle);
                arrow.y += lengthdir_y(offset, image_angle);
            }
            has_fired = true;
        }

        frame_delay++;
        if (frame_delay >= 10) {
            state = BowState.AIMING;
            frame_delay = 0;
        }
        break;
}