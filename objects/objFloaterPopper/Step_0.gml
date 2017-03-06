//get distance to player

if (global.playerInstance != noone)
{
	distanceToPlayer = distance_to_object(global.playerInstance);


	vx = Approach(vx, 0, moveFric);
	vy = Approach(vy, 0, moveFric);

	if (distanceToPlayer <= moveTriggerDistance && alarm[0] < 0)
	{
		alarm[0] = moveCooldown;

		//Blob towards player
		
		angle = point_direction(x,y,global.playerInstance.x, global.playerInstance.y);
		
		angle +=90;
		
		vx = sin(degtorad(angle)) * moveThrust;
		vy = cos(degtorad(angle)) * moveThrust;
		
		drawing_scale = moveSquish;
		
		breathingRate = breathingRateRunning;
		breathingAmplitudeY = breathingAmplitudeYRunning;
	}

	
}


breathingAmplitudeY = lerp(breathingAmplitudeY, breathingAmplitudeYIdle,0.05);
breathingRate = lerp(breathingRate, breathingRateIdle,0.03);

drawing_scale +=  breathingAmplitudeY * sin(degtorad(breathingSinAngle));

breathingSinAngle += breathingRate;
if (breathingSinAngle > 360)
{
	breathingSinAngle -= 360;
}

drawing_scale = lerp(drawing_scale,1,squishRate);