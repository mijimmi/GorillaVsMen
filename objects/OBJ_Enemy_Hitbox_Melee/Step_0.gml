event_inherited();

var gorilla_inst = instance_place(x, y, OBJ_Gorilla);
if (gorilla_inst != noone) {
    with (gorilla_inst) {
        if (!invincible) {
            gorilla_take_damage(other.damage, other.x, other.y);
        }
    }
}
