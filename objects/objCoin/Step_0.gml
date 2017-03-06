bounceOnContact = true;
bounceCoeff = 0.3;

// Handle gravity
if (!onGround) 
{
    // Fall normally
    vy = Approach(vy, vyMax, gravNorm);
}

if (distance_to_object(objPlayer) <100)
	{
	move_towards_point(objPlayer.x,objPlayer.y,3);
	}