radius = 50;
angle = 0;
orbit_speed = 4;
owner = OBJ_Gorilla;
angle = 120

var hb = instance_create_layer(x, y, "Hitboxes", OBJ_FloatingRock_Hitbox);
hb.follow_target = id;       // Make the hitbox follow 
hb.owner = owner;            
hb.damage = global.gorilla.attack * 2;              // Adjust as needed
hb.cooldown = 30;            // Adjust per balancing needs
