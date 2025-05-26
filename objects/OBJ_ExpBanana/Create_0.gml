rotation = irandom(359); 
if !variable_instance_exists(id, "hsp") hsp = 0;
if !variable_instance_exists(id, "vsp") vsp = 0;
image_xscale = 0.5;
image_yscale = 0.5;

// Despawn timer (20 seconds at 60 FPS = 1200 steps)
lifetime = 1200;