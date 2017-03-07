//Attract to player position
movingToPlayer = false;

if (global.playerInstance != noone)
{
	distanceToPlayer = distance_to_object(global.playerInstance);
	if (distanceToPlayer < attractDistance)
	{
		movingToPlayer = true;
		
		
		
		//vector
		dirToPlayerX = global.playerInstance.x - x;
		dirToPlayerY = global.playerInstance.y - y;
		//magnitude
		magnitude = sqrt(dirToPlayerX * dirToPlayerX + dirToPlayerY * dirToPlayerY);
		//normalise
		if (magnitude != 0)
		{
			dirToPlayerX /= magnitude;
			dirToPlayerY /= magnitude;
		}
		vx = Approach(vx,attactSpeed * dirToPlayerX,attactGravity);
		vy = Approach(vy,attactSpeed * dirToPlayerY,attactGravity);
	}
}


bounceOnContact = true;
bounceCoeff = 0.3;

if (movingToPlayer == false)
{
	// Handle gravity
	if (!onGround) 
	{
	    // Fall normally
	    vy = Approach(vy, vyMax, gravNorm);
	}
}

	
