minNumCoins = 10;
maxNumCoins = 15;

if (global.playerInstance != noone)
{
	numCoins = minNumCoins + round(random(maxNumCoins-minNumCoins));

	repeat (numCoins)
	{
		coin_instance = instance_create_layer(x+32,y-32,"Instances",objCoin);
		if (coin_instance != noone)
		{
			vyscaler = -1;
			coin_instance.vx = random_range(-10,10);
			coin_instance.vy = random_range(5 * vyscaler,15 * vyscaler);
		}
	}
}