if (instance_exists(owner)) {
    x = owner.x;
    y = owner.y;
} else {
    instance_destroy();
    exit;
}

// Rotate laser
angle += rotation_speed;

// Reset damage flag each frame
damage_dealt_this_frame = false;

// Only do damage during active state
if (laser_state == "active") {
		if (laser_state == "active") {
	    // Play sound only once when laser becomes active
	    if (!laser_sound_played) {
	        audio_play_sound(SND_Lazer, 1, false);
	        laser_sound_played = true;
	    }
		with (OBJ_CameraController) {
			            shake_timer = 30;
			            shake_magnitude = 5;
			        }
	
	    // Calculate the visual center of the boss (matching draw event)
	    var boss_center_x = owner.x;
	    var boss_center_y = owner.y - (sprite_get_height(owner.sprite_index) / 2);
    
	    // Collision check with Gorilla using accurate laser dimensions
	    var directions = [0, 90, 180, 270];
	    var max_distance = 1000;  // Same as draw event
	    var laser_width = sprite_get_height(SPR_Lazerbeam) * 0.7;  // Matches scale_y in draw event
    
	    for (var i = 0; i < array_length(directions) && !damage_dealt_this_frame; i++) {
	        var dir = angle + directions[i];
        
	        // Calculate laser start and end points (matching draw event positioning)
	        var start_x = boss_center_x;
	        var start_y = boss_center_y;
	        var end_x = boss_center_x + lengthdir_x(max_distance, dir);
	        var end_y = boss_center_y + lengthdir_y(max_distance, dir);
        
	        // Check if gorilla exists and is within laser area
	        if (instance_exists(OBJ_Gorilla)) {
	            // Method 1: Enhanced line collision with width consideration
	            var gorilla_distance_to_line = point_distance_to_line(OBJ_Gorilla.x, OBJ_Gorilla.y, 
	                                                                 start_x, start_y, end_x, end_y);
            
	            // Check if gorilla is within laser width
	            if (gorilla_distance_to_line <= laser_width / 2) {
	                // Check if gorilla is within laser length
	                var gorilla_distance_from_start = point_distance(start_x, start_y, OBJ_Gorilla.x, OBJ_Gorilla.y);
	                var angle_to_gorilla = point_direction(start_x, start_y, OBJ_Gorilla.x, OBJ_Gorilla.y);
	                var angle_diff = abs(angle_difference(dir, angle_to_gorilla));
                
	                // If gorilla is roughly in the direction of the laser and within range
	                if (angle_diff <= 90 && gorilla_distance_from_start <= max_distance) {
	                    with (OBJ_Gorilla) {
	                        gorilla_take_damage(1, other.owner.x, other.owner.y);
	                    }
	                    damage_dealt_this_frame = true;
	                    break;  // Only damage once per frame
	                }
	            }
	        }
	    }
	}
}

// Helper function to calculate distance from point to line
function point_distance_to_line(px, py, x1, y1, x2, y2) {
    var A = px - x1;
    var B = py - y1;
    var C = x2 - x1;
    var D = y2 - y1;
    
    var dot = A * C + B * D;
    var len_sq = C * C + D * D;
    
    if (len_sq == 0) return point_distance(px, py, x1, y1);
    
    var param = dot / len_sq;
    
    var xx, yy;
    if (param < 0) {
        xx = x1;
        yy = y1;
    } else if (param > 1) {
        xx = x2;
        yy = y2;
    } else {
        xx = x1 + param * C;
        yy = y1 + param * D;
    }
    
    return point_distance(px, py, xx, yy);
}
