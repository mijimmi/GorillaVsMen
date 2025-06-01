if (!instance_exists(OBJ_Gorilla)){
	instance_destroy()
	exit
}


if (current_state == state.SPAWNING && image_index >= image_number - 1) {
    sprite_index = SPR_PooSplatLinger;
    image_speed = 1;
    current_state = state.LINGERING;
    lingering_timer = 420; // stays for 6 seconds

    var hb = instance_create_layer(x, y, "Hitboxes", OBJ_PooSplat_Hitbox);
    hb.follow_target = id;                  
    hb.damage = global.gorilla.attack * 0.5;              
    hb.cooldown = 30;
    hb.dot_interval = 1; // e.g., damage every n frames
    hb.image_xscale = 3;
    hb.image_yscale = 2.5;
}

if (current_state == state.LINGERING) {
    lingering_timer -= 1;
    if (lingering_timer <= 0){
        instance_destroy();
    }
}
