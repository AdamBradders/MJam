
if (portalStep == 0)
{
	explodeRadius = 5 * 32;
	//Spawn the portal and clear area around it...
	global.portals[0] = instance_create_layer(global.portalStartX,global.portalStartY-portalVerticalOffset*32,"instance_portals",objPortal);
	camera_set_view_target(view_camera[0],global.portals[0]);
	
	ids = get_ids_region(objEntity,global.portals[0].x-(portalHorizontalClear*0.5),global.portals[0].y-(portalVerticalClear*0.5),global.portals[0].x+(portalHorizontalClear*0.5),global.portals[0].y+(portalVerticalClear*0.5));
	for (i=0;i<array_length_1d(ids);i++)
	{
		if (ids[i] != id)
		{
			instance_destroy(ids[i]);
		}
	}

	ids = get_ids_region(objSolid,global.portals[0].x-(portalHorizontalClear*0.5),global.portals[0].y-(portalVerticalClear*0.5),global.portals[0].x+(portalHorizontalClear*0.5),global.portals[0].y+(portalVerticalClear*0.5));
	for (i=0;i<array_length_1d(ids);i++)
	{
		instance_destroy(ids[i]);
	}
	instance_create_depth(global.portals[0].x,global.portals[0].y,0,obj_Bomb_SplashDamage);
	
	alarm[0] = portalPreSpawnTime;
	portalStep++;
}
else if (portalStep == 1)
{
	//Spawn the player
	global.playerInstance = instance_create_layer(global.portalStartX,global.portalStartY-portalVerticalOffset*32,"instance_player",objPlayer);
	camera_set_view_target(view_camera[0],global.playerInstance);
	portalStep++;
}