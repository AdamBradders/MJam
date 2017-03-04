event_inherited();

switch (hp)
{
	case 3:
		sprite_index = sprTestTile;
		break;
	case 2:
		sprite_index = sprTestTileDmg_01;
		break;
	case 1:
		sprite_index = sprTestTileDmg_02;
		break;
	case 0:
		instance_destroy(id);
}
