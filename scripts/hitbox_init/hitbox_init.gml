function hitbox_init(){
	/// hitbox_init(lifetime_default, radius_default, knockback_default)

	/// @arg lifetime_default
	/// @arg radius_default
	/// @arg knockback_default

	lifetime        = argument0;
	hitbox_radius   = argument1;
	knockback_force = argument2;

	alarm[0] = lifetime;
}