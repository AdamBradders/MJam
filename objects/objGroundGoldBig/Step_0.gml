event_inherited();

switch (hp)
{
	case 3:
		sprite_index = sprTestTileBigGold;
		break;
	case 2:
		sprite_index = sprTestTileBigGoldDMG_01;
		break;
	case 1:
		sprite_index = sprTestTileBigGoldDMG_02;
		break;
	case 0:
		instance_destroy(id);
}
