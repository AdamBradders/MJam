if (ds_list_size(global.portalPolice) < maxPortalPolice)
{
	alarm[0] = policeSpawnTime;
	instance_create_layer(x,y,"Instances",objPortalPolice);
}