//Spit out some bullets

	instance_create_depth(x,y,0,obj_part1_Popper);

angle = 45;

repeat (4)
{
	bulletInstance = instance_create_layer(x,y,"Instances",objFloaterBullet);
	
	bulletInstance.vx = sin(degtorad(angle)) * bulletInstance.bulletSpeed;
	bulletInstance.vy = cos(degtorad(angle)) * bulletInstance.bulletSpeed;
	bulletInstance.angle = angle;
	angle += 90;
}
	