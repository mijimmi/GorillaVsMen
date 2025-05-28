event_inherited(); // Retain core logic from parent

// If the miniboss is dead, flag it so round can proceed
if (state == states.DEAD && global.finalboss_alive) {
    global.finalboss_alive = false;
}
