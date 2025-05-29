returning = false;
start_x = x;
start_y = y;
//max radius of the banana, edit it here 
max_distance = 140;
owner_ID = OBJ_Gorilla.id
owner = other; 


var hb = instance_create_layer(x, y, "Hitboxes", OBJ_Bananarang_Hitbox);
hb.follow_target = id;       // Make the hitbox follow this boomerang
hb.owner = owner;            // Pass through owner (e.g. the player)
hb.damage = global.gorilla.attack * 2;              // Adjust as needed
hb.cooldown = 30;            // Adjust per balancing needs
