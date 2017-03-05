event_inherited();

switch (hp)
{
	case 3:
		sprite_index = sprTestTileBig;
		break;
	case 2:
		sprite_index = sprTestTileBigDMG_01;
		break;
	case 1:
		sprite_index = sprTestTileBigDMG_02;
		break;
	case 0:
		instance_destroy(id);
}
