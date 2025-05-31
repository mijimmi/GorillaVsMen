var hb = instance_create_layer(x, y, "Hitboxes", OBJ_Boulder_Hitbox);
hb.follow_target = id;       // Make the hitbox follow            
hb.damage = global.gorilla.attack * 3;              // Adjust as needed
hb.cooldown = 30;            // Adjust per balancing needs
