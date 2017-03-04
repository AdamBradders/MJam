sub_image = 0;
energy = global.playerInstance.energy;
maxEnergy = global.playerInstance.maxEnergy;

if (energy == maxEnergy)
{
	sub_image = 10;
}
else if (energy > 0)
{
	sub_image = ceil(energy*(10/maxEnergy));
}	

draw_sprite_ext(sprite_index,sub_image,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);