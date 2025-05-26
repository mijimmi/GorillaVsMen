function damage_entity(_tid, _sid, _damage){
    with (_tid) {
        hp -= _damage;
        path_end();

        var _dead = is_dead();

        if (!_dead) {
            is_hurt = true;
            hurt_timer = hurt_duration;  // reset timer on every hit
        }

        // Damage popup as before
        var _di = instance_create_layer(x, y - sprite_height * 0.5, "Effects", OBJ_DamageIndicator);
        _di.text = string(_damage);
    }
}



function is_dead(){
    if state != states.DEAD {
        if hp <= 0 {
            state = states.DEAD;
            hp = 0;
            image_index = 0;

            // Spawn EXP bananas on death
            var num_bananas = 1 + enemy_tier; // base 1, more if higher tier
            for (var i = 0; i < num_bananas; i++) {
                var angle = irandom_range(0, 359);
                var dist = random_range(4, 12);
                var bx = x + lengthdir_x(dist, angle);
                var by = y + lengthdir_y(dist, angle);

                var banana = instance_create_layer(bx, by, "Instances", OBJ_ExpBanana);

                // Add small knockback velocity
                banana.hsp = lengthdir_x(random_range(1, 2), angle);
                banana.vsp = lengthdir_y(random_range(1, 2), angle);
            }

            // 💚 15% chance to drop a Health Banana
            if (random(1) < 0.15) {
                var angle = irandom_range(0, 359);
                var dist = random_range(4, 12);
                var bx = x + lengthdir_x(dist, angle);
                var by = y + lengthdir_y(dist, angle);

                var health_banana = instance_create_layer(bx, by, "Instances", OBJ_HealthBanana);

                health_banana.hsp = lengthdir_x(random_range(1, 2), angle);
                health_banana.vsp = lengthdir_y(random_range(1, 2), angle);
            }

            // Optionally play death sound
            switch(object_index) {
                case OBJ_Gorilla:
                    // sound
                break;
                default:
                    // sound
                break;
            }

            return true;
        }
    }
    return false;
}

