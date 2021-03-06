/// @description Insert description here
// You can write your code in this editor

// Particle System
part2_sys	= part_system_create();
part_system_depth(part2_sys,0);

// Particle
part2 = part_type_create();
part_type_sprite(part2,sprParticle,0,0,0);
//part_type_scale(part2,1,1);
part_type_size(part2,0.2,0.4,-0.008,-0.003);
//part_type_color2(part2,make_color_rgb(255,255,255),make_color_rgb(200,200,200));
part_type_alpha2(part2,0.3,0.1);
//part_type_speed(part2,0.2,0.8,0,0.08);
//part_type_gravity(part2,0.005,90);
part_type_life(part2,room_speed*0.1,room_speed*0.2);
part_type_blend(part2,0);

if (global.playerInstance != noone)
{
	if (global.playerInstance.isFacingLeft)
	{
		part_type_direction(part2,180,180,0,0);
	}
	else
	{
	part_type_direction(part2,0,0,0,0);
	}
}

//Particle Emitter
part2_emit	= part_emitter_create(part2_sys);
part_emitter_region(part2_sys,part2_emit,x-40,x+20,y-20,y+20,ps_shape_rectangle,ps_distr_gaussian);
part_emitter_burst(part2_sys,part2_emit,part2,5);
