/// Create miners

randomize();
//Alternativly use the line below to force the same level generation every time
//random_set_seed(10);

numberOfMiners = 10;

i = numberOfMiners;
repeat(numberOfMiners)
{
	randomX = floor(random(room_width));
	randomY = floor(random(room_height));
	minerInstances[--i] = instance_create_layer(randomX,randomY,"Instances",objWorldMiner);
}

levelGenerationComplete = false;