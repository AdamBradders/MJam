/// Create miners

global.playerInstance = noone;

randomize();
//Alternativly use the line below to force the same level generation every time
//random_set_seed(10);

numberOfMiners = 20;

global.worldMarginSizeInTiles = 5;
portalPreSpawnTime = 3 * room_speed;
portalVerticalOffset = 4; //3 tiles up
portalHorizontalOffset = 6; //3 tiles up

i = numberOfMiners;
repeat(numberOfMiners)
{
	margin = ((global.worldMarginSizeInTiles+1)*32);
	randomX = margin + floor(random(room_width-margin*2));
	randomY = margin + floor(random(room_height-margin*2));
	minerInstances[--i] = instance_create_layer(randomX,randomY,"Instances",objWorldMiner);
}

levelGenerationComplete = false;