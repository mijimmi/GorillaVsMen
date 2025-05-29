// Destroy if target no longer exists
if (!instance_exists(follow_target)) {
    ds_map_destroy(cooldown_map);
    instance_destroy();
    exit;
}

// Follow the projectile
x = follow_target.x;
y = follow_target.y;
image_angle = follow_target.image_angle;

// Advance local timer
hitbox_timer += 1;

// Damage nearby enemies
with (OBJ_ParentEnemy) {
    var _hb = other;
    var enemy_id = id;
    var enemy_key = string(enemy_id);

    if (point_distance(_hb.x, _hb.y, x, y) < 16) {
        var last_hit = -_hb.cooldown;
        if (ds_map_exists(_hb.cooldown_map, enemy_key)) {
            last_hit = _hb.cooldown_map[? enemy_key];
        }

        if (_hb.hitbox_timer - last_hit >= _hb.cooldown) {
            damage_entity(enemy_id, _hb.owner, _hb.damage);
            _hb.cooldown_map[? enemy_key] = _hb.hitbox_timer;
        }
    }
}
