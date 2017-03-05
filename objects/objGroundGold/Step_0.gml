event_inherited();

switch (hp)
{
	case 3:
		sprite_index = sprTestTileGold;
		break;
	case 2:
		sprite_index = sprTestTileGoldDMG_01;
		break;
	case 1:
		sprite_index = sprTestTileGoldDMG_02;
		break;
	case 0:
		instance_destroy(id);
}
