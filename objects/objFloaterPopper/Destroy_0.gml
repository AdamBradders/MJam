//Spit out some bullets

angle = 45;

repeat (4)
{
	bulletInstance = instance_create_layer(x,y,"Instances",objFloaterBullet);
	
	bulletInstance.vx = sin(degtorad(angle)) * bulletInstance.bulletSpeed;
	bulletInstance.vy = cos(degtorad(angle)) * bulletInstance.bulletSpeed;
	bulletInstance.angle = angle;
	angle += 90;
}
	