owner = noone;
rocket_state = "warning";  // Will be set by boss
warning_alpha = 0;  // For fade-in effect
explosion_scale = 1;  // Will be calculated based on aoe_radius
explosion_sprite = choose(SPR_ExplosionFX1, SPR_ExplosionFX2);  // Randomly choose explosion sprite
aoe_radius = 80;  // Set to match sprite width (32x64 sprite = 32 radius)
explosion_image_index = 0;  // Manual frame control
explosion_image_speed = 0.3;  // Slower animation (0.5 = half speed, 0.25 = quarter speed)
is_boss_aoe = false;  // Flag to identify boss position AOE
damage_dealt = false;  // NEW: Flag to ensure damage is only dealt once
damage_timer = 0;      // NEW: Timer to control damage duration