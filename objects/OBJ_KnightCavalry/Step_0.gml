// Inherit the parent event
event_inherited();
if (global.is_leveling_up) {
    is_winding_up = false;
    dashing = false;
    dash_timer = 0;
    dash_cooldown_timer = long_dash_cooldown;

    path_end();
    speed = 0;
    exit;
}

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

// Hurt logic
if (is_hurt) {
    hurt_timer--;
    if (hurt_timer <= 0) {
        is_hurt = false;
        hurt_timer = 0;
    }
}

// --- WINDUP handling ---
if (is_winding_up) {
    dash_windup_timer--;

    path_end();  // STOP path movement while winding up
    speed = 0;   // ensure speed zero (if used elsewhere)

    // Draw particle line from current position to locked dash target
    var steps = 10;
    var color = c_white;
    if (dash_windup_timer <= 5) color = c_red;
    part_type_color1(part_line, color);

	// New code to draw full dash length line:
	var dash_end_x = x + lengthdir_x(dash_spd * dash_duration, image_angle);
	var dash_end_y = y + lengthdir_y(dash_spd * dash_duration, image_angle);

	for (var i = 0; i <= steps; i++) {
	    var px = lerp(x, dash_end_x, i / steps);
	    var py = lerp(y, dash_end_y, i / steps);
	    part_particles_create(particle_sys, px, py, part_line, 1);
	}

    if (dash_windup_timer <= 0) {
        is_winding_up = false;
        dashing = true;
        dash_timer = dash_duration;
    }

    exit; // Skip rest of step during windup
}

// --- DASH movement ---
if (dashing) {
    dash_timer--;
    x += lengthdir_x(dash_spd, image_angle);
    y += lengthdir_y(dash_spd, image_angle);

    var half_w = sprite_width * 0.5;
    var half_h = sprite_height * 0.5;
    x = clamp(x, half_w, room_width - half_w);
    y = clamp(y, half_h, room_height - half_h);

    if (dash_timer <= 0) {
        dashing = false;
        dash_cooldown_timer = long_dash_cooldown;  // Use LONG cooldown here
    }

    path_end();
    exit;
}

// --- STATE logic ---
switch(state){
    case states.IDLE:
        // Only chase player if NOT winding up
        if (!is_winding_up) {
            check_for_player();
            if (path_index != 1) state = states.MOVE;
        }

        // Trigger dash windup if close and ready
		if (!dashing && !is_winding_up && dash_cooldown_timer <= dash_windup_offset && instance_exists(OBJ_Gorilla)) {
            var player_inst = instance_nearest(x, y, OBJ_Gorilla);
            if (player_inst != noone && point_distance(x, y, player_inst.x, player_inst.y) < 120) {
                is_winding_up = true;
                dash_windup_duration = 60;      // slower windup here
                dash_windup_timer = dash_windup_duration;

                // Lock dash target position once here
                dash_target_x = player_inst.x;
                dash_target_y = player_inst.y;

                image_angle = point_direction(x, y, dash_target_x, dash_target_y); // lock direction once
                exit;
            }
        }

        enemy_anim();
    break;

    case states.MOVE:
        // Only chase/facing if NOT winding up
        if (!is_winding_up) {
            check_for_player();
            check_facing();
            if (path_index == 1) state = states.IDLE;
        }

        if (!dashing && !is_winding_up && dash_cooldown_timer <= 0 && instance_exists(OBJ_Gorilla)) {
            var player_inst = instance_nearest(x, y, OBJ_Gorilla);
            if (player_inst != noone && point_distance(x, y, player_inst.x, player_inst.y) < 120) {
                is_winding_up = true;
                dash_windup_duration = 60;      // slower windup here too
                dash_windup_timer = dash_windup_duration;

                // Lock dash target position once here
                dash_target_x = player_inst.x;
                dash_target_y = player_inst.y;

                image_angle = point_direction(x, y, dash_target_x, dash_target_y);
                exit;
            }
        }

        enemy_anim();
    break;

    case states.DEAD:
        death_timer++;
        path_end();
        speed = 0;

        enemy_anim();

        if (death_timer > death_duration) {
            instance_destroy();
        }
    break;
}

// Dash cooldown timer
if (dash_cooldown_timer > 0) {
    dash_cooldown_timer--;
}
