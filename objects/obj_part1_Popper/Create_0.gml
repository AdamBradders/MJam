/// @description Insert description here
// You can write your code in this editor

// Particle System
part1_sys	= part_system_create();
part_system_depth(part1_sys,0);

// Particle
part1 = part_type_create();
part_type_shape(part1,pt_shape_disk);
part_type_scale(part1,1,1);
part_type_size(part1,0.2,0.8,-0.008,-0.003);
part_type_color2(part1,make_color_rgb(92,0,41),c_white);
part_type_alpha2(part1,1,0.65);
part_type_speed(part1,0.1,0.5,0,0.08);
part_type_direction(part1,0,359,0,0);
part_type_gravity(part1,0.005,270);
part_type_life(part1,room_speed*2,room_speed*4);
part_type_blend(part1,0);

//Particle Emitter
part1_emit	= part_emitter_create(part1_sys);
part_emitter_region(part1_sys,part1_emit,x-40,x+40,y-40,y+40,ps_shape_diamond,ps_distr_gaussian);
part_emitter_burst(part1_sys,part1_emit,part1,50);
