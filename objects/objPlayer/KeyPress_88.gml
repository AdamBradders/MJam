/// @description Insert description here
// You can write your code in this editor

bullet				= instance_create_layer(x,y -15,"Instances",objPlayerBullet);
bullet.speed		= 10;

if (isFacingLeft)
	{
		bullet.direction = 180;
	}
	
	else
		{
			bullet.direction = 0;
		}
		
if (!onGround && isFlying)
	{
	bullet.angle = objPlayer.angle;
	}
