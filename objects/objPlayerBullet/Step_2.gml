// Vertical
repeat(abs(vy)) {
    if (!place_meeting(x, y + sign(vy), objSolid))
        y += sign(vy); 
    else {
      	
		instance = instance_place(x,y+sign(vy),objSolid);
		if (instance != noone)
		{
			instance.hp--;
		}
		 
		instance_destroy(id);
	
        break;
    }
}

// Horizontal
repeat(abs(vx)) {
    if (!place_meeting(x + sign(vx), y, objSolid))
        x += sign(vx); 
    else {
		
		instance = instance_place(x+sign(vx),y,objSolid);
		if (instance != noone)
		{
			instance.hp--;
		}
		
		instance_destroy(id);
		 
        break;
    }
}

wasOnGround = onGround;