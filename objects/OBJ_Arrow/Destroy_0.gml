
part_type_destroy(arrow_pt);
part_system_destroy(arrow_ps);
if (instance_exists(hitbox)) {
    instance_destroy(hitbox);
}
