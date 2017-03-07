//get distance to player

if (global.playerInstance != noone)
{
	distanceToPlayer = distance_to_object(global.playerInstance);

	isShooting = distanceToPlayer <= shootTriggerDistance;
}

if (alarm[0] < 0 && isShooting)
{
	alarm[0] = shootingCooldown;
	
	//center
	startX = x - (32 * sin(degtorad(angle)));// sin(degtorad(angle)) * 64;
	startY = y - (32 * cos(degtorad(angle)));// - cos(degtorad(angle)) * 64;
	spitterBullet = instance_create_layer(startX,startY,"Instances",objSpitterBullet);
	spitterBullet.vx = -sin(degtorad(angle)) * bulletSpeed;
	spitterBullet.vy = -cos(degtorad(angle)) * bulletSpeed;
	
	//left
	startX = x - (32 * sin(degtorad(angle-45)));// sin(degtorad(angle)) * 64;
	startY = y - (32 * cos(degtorad(angle-45)));// - cos(degtorad(angle)) * 64;
	spitterBullet = instance_create_layer(startX,startY,"Instances",objSpitterBullet);
	spitterBullet.vx = -sin(degtorad(angle-45)) * bulletSpeed;
	spitterBullet.vy = -cos(degtorad(angle-45)) * bulletSpeed;
	
	//right
	startX = x - (32 * sin(degtorad(angle+45)));// sin(degtorad(angle)) * 64;
	startY = y - (32 * cos(degtorad(angle+45)));// - cos(degtorad(angle)) * 64;
	spitterBullet = instance_create_layer(startX,startY,"Instances",objSpitterBullet);
	spitterBullet.vx = -sin(degtorad(angle+45)) * bulletSpeed;
	spitterBullet.vy = -cos(degtorad(angle+45)) * bulletSpeed;
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