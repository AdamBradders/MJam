event_inherited();

switch (hp)
{
	case 5:
		sprite_index = sprTestTileBigRare;
		break;
	case 4:
		sprite_index = sprTestTileBigRareDMG_01;
		break;
	case 3:
		sprite_index = sprTestTileBigRareDMG_02;
		break;
	case 2:
		sprite_index = sprTestTileBigRareDMG_03;
		break;
	case 1:
		sprite_index = sprTestTileBigRareDMG_04;
		break;
	case 0:
		instance_destroy(id);
}
