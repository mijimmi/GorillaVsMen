effect_create_above(ef_ring, x,y, 300, c_green); //debug effect, disregard

with (OBJ_LevelManager)
{
	apply_powerup(other.power_type) //applies power up
	cleanup() //destroys all other buttons
}

instance_destroy()
