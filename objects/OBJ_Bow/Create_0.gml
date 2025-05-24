image_xscale = 0.7;
image_yscale = 0.7;

enum BowState {
    AIMING,
    FIRE_START,
    FIRE_END
}

state = BowState.AIMING;
frame_delay = irandom_range(0, 239); // randomize offset
aim_update_timer = 0;
has_fired = false;