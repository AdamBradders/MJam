/// Create miners

randomize();
//Alternativly use the line below to force the same level generation every time
//random_set_seed(10);

numberOfMiners = 15;

global.worldMarginSizeInTiles = 5;

i = numberOfMiners;
repeat(numberOfMiners)
{
	randomX = ((global.worldMarginSizeInTiles+3)*32) + floor(random(room_width-(32*(global.worldMarginSizeInTiles+3))));
	randomY = ((global.worldMarginSizeInTiles+3)*32) + floor(random(room_height-(32*(global.worldMarginSizeInTiles+3))));
	minerInstances[--i] = instance_create_layer(randomX,randomY,"Instances",objWorldMiner);
}

levelGenerationComplete = false;