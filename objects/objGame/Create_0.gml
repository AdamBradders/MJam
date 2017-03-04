/// Create miners

randomize();
//Alternativly use the line below to force the same level generation every time
//random_set_seed(10);

numberOfMiners = 10;

i = numberOfMiners;
repeat(numberOfMiners)
{
	randomX = 32 + floor(random(room_width-32));
	randomY = 32 + floor(random(room_height-32));
	minerInstances[--i] = instance_create_layer(randomX,randomY,"Instances",objWorldMiner);
}

levelGenerationComplete = false;