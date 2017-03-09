/// @description Insert description here
// You can write your code in this editor

// Particle System
part2_sys	= part_system_create();
part_system_depth(part2_sys,0);

// Particle
part2 = part_type_create();
part_type_sprite(part2,sprParticle,0,0,0);
part_type_scale(part2,1,1);
part_type_size(part2,0.1,0.9,-0.008,-0.003);
part_type_color2(part2,make_color_rgb(86,203,249),make_color_rgb(238,66,102));
part_type_alpha2(part2,0.3,0.1);
//part_type_speed(part2,0.2,0.8,2,0.08);
//part_type_gravity(part2,0.005,90);
part_type_life(part2,room_speed*5,room_speed*10);
part_type_blend(part2,0);
//part_type_direction(part2,0,0,359,0);

//Particle Emitter
part2_emit	= part_emitter_create(part2_sys);
part_emitter_region(part2_sys,part2_emit,x-80,x+80,y-80,y+80,ps_shape_ellipse,ps_distr_gaussian);
part_emitter_burst(part2_sys,part2_emit,part2,100);
