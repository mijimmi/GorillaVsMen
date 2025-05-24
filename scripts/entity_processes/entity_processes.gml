function damage_entity(_tid, _sid, _damage){
	//damage the target, and return the dead states
	//tid - real target id
	//sid - real source id
	//_damage - how much damage deal
	
	with(_tid){
	hp -= _damage;
	var _dead = is_dead();
	path_end();
	}
}

function is_dead(){
// check if entity dead
	if state != states.DEAD{
		if hp <= 0 {
			state = states.DEAD;
			hp = 0;
			image_index = 0;
			//set death sound
			switch(object_index) {
				default:
					//play sound
				break;
				case OBJ_Gorilla:
					//play sound
				break;
			}
			return true;
		}
	} return true;
}