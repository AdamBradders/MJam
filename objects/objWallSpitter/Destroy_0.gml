
//Find blocks and player in area
if (global.playerInstance != noone)
{
	distanceToPlayer = distance_to_object(global.playerInstance);

	if (distanceToPlayer <= explodeRadius)
	{
		//Blow up yo
		instance_destroy(global.playerInstance);
	}
}

ids = get_ids_region(objEntity,x-explodeRadius,y-explodeRadius,x+explodeRadius,y+explodeRadius);
for (i=0;i<array_length_1d(ids);i++)
{
	if (ids[i] != id)
	{
		instance_destroy(ids[i]);
	}
}


ids = get_ids_region(objSolid,x-explodeRadius,y-explodeRadius,x+explodeRadius,y+explodeRadius);
for (i=0;i<array_length_1d(ids);i++)
{
	instance_destroy(ids[i]);
}