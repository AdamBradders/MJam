// Vertical
repeat(abs(vy)) {
    if (!place_meeting(x, y + sign(vy), objSolid))
	{
	        y += sign(vy); 
	}
    else 
	{
		if (bounceOnContact)
		{
			vy = vy * -1.0 * bounceCoeff;
		}
		else
		{
	        vy = 0;
	    }
		break;
	}
}

// Horizontal
repeat(abs(vx)) {
    if (!place_meeting(x + sign(vx), y, objSolid))
	{
        x += sign(vx); 
	}
    else 
	{
		if (bounceOnContact)
		{
			vx = vx * -1.0 * bounceCoeff;
		}
		else
		{
	        vx = 0;
	    }
		break;
    }
}

wasOnGround = onGround;