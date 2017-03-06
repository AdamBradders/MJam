bounceOnContact = true;
bounceCoeff = 0.3;

// Handle gravity
if (!onGround) 
{
    // Fall normally
    vy = Approach(vy, vyMax, gravNorm);
}

// Suck towards player? Maybe? I dunno - Mik

if (distance_to_object(objPlayer) <100)
	{
	move_towards_point(objPlayer.x,objPlayer.y,3);
	}
	
	
// Friction? Maybe? I dunno - Mik

if abs(speed) > 0
   {
   friction=600;
   }
else
   {
   friction=0;
   }