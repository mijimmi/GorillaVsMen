// Destroy if target no longer exists
if (!instance_exists(follow_target)) {
    ds_map_destroy(cooldown_map);
    instance_destroy();
    exit;
}

// Damage nearby enemies
with (OBJ_ParentEnemy) {
    var _hb = other;
    var enemy_id = id;
    var enemy_key = string(enemy_id);

    var scaled_range = 16 * max(_hb.image_xscale, _hb.image_yscale);
	if (point_distance(x, y, _hb.x, _hb.y) < scaled_range) {
        var last_hit = -_hb.cooldown;
        if (ds_map_exists(_hb.cooldown_map, enemy_key)) {
            last_hit = _hb.cooldown_map[? enemy_key];
        }

        if (_hb.dot_interval > 0 && _hb.hitbox_timer - last_hit >= _hb.dot_interval) {
            damage_entity(enemy_id, _hb.owner, _hb.damage);
            _hb.cooldown_map[? enemy_key] = _hb.hitbox_timer;
        }

        else if (_hb.dot_interval <= 0 && last_hit <= -_hb.cooldown) {
            damage_entity(enemy_id, _hb.owner, _hb.damage);
            _hb.cooldown_map[? enemy_key] = _hb.hitbox_timer;
        }
    }
}


