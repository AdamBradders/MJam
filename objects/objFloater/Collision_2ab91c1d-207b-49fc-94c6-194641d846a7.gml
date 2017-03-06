/// @description Insert description here
// You can write your code in this editor

--hp;
sprite_index = sprFloaterHitFrame;
drawing_scale = bulletHitSquish;
alarm[1] = hitFrameTime;

if (hp <= 0)
{
	instance_destroy(id);
	instance_create_depth(x,y,0,obj_part1_Floater);
}
