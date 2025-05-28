event_inherited(); // Retain core logic from parent

// If the miniboss is dead, flag it so round can proceed
if (state == states.DEAD && global.miniboss_alive) {
    global.miniboss_alive = false;
}
