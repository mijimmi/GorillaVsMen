check_for_player();

// Knockback handling
if (knockback_timer > 0) {
    knockback_timer--;
    x += knockback_x;
    y += knockback_y;

    // Stop pathing while knocked back
    path_end();
    exit; // Skip chasing logic
}
