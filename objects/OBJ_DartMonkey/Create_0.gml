var hb = instance_create_layer(x, y, "Hitboxes", OBJ_Dart_Hitbox);
hb.follow_target = id;       // Make the hitbox follow this boomerang            
hb.damage = global.gorilla.attack * 2;              // Adjust as needed
hb.cooldown = 30;            // Adjust per balancing needs

should_destroy = false;
