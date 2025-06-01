if (current_state == state.SPAWNING && image_index >= image_number-1) {
	sprite_index = SPR_PooSplatLinger
	image_speed = 1
	current_state = state.LINGERING
	lingering_timer = 420 //stays for 6 seconds
	}
	
if (current_state == state.LINGERING)
{
	lingering_timer -= 1
	if (lingering_timer <= 0){
		instance_destroy()
	}
}