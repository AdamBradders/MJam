event_inherited();

switch (hp)
{
	case 3:
		sprite_index = sprTestTile;
		break;
	case 2:
		sprite_index = sprTestTileDMG_01;
		break;
	case 1:
		sprite_index = sprTestTileDMG_02;
		break;
	case 0:
		instance_destroy(id);
}
