targetVX = 0;
targetVY = 0;
if (global.playerInstance != noone)
{
	angle = point_direction(x,y,global.playerInstance.x, global.playerInstance.y);
		
	angle +=90;
}

//Do the swarming

neighbourRadius = 10 * 32;

alignmentX = 0;
alignmentY = 0;
cohesionX = 0;
cohesionY = 0;
seperationX = 0;
seperationY = 0;

//Get center of boids
i = 0;
cumPositionX = 0;
cumPositionY = 0;
repeat (ds_list_size(global.portalPolice))
{
	instance = ds_list_find_value(global.portalPolice,i++);
	if (instance != noone)
	{
		cumPositionX += instance.x;
		cumPositionY += instance.y;
	}
}

if (ds_list_size(global.portalPolice) > 0)
{
	centerX = cumPositionX / ds_list_size(global.portalPolice);
	centerY = cumPositionY / ds_list_size(global.portalPolice);
}

i = 0;
neighbourCount = 0;
repeat (ds_list_size(global.portalPolice))
{
	instance = ds_list_find_value(global.portalPolice,i++);
	
	if (instance == id)
	{
		//dont consider self
		continue;
	}
	
	if (point_distance(x,y,instance.x,instance.y) < neighbourRadius)
	{
		++neighbourCount;
		alignmentX += instance.vx;
		alignmentY += instance.vy;
		
		cohesionX += instance.x;
		cohesionY += instance.y;
		
		seperationX += x - instance.x;
		seperationY += y - instance.y;
	}
}

wallCount = 0;
//ids = get_ids_region(objSolid,x-neighbourRadius*0.5,y-neighbourRadius*0.5,x+neighbourRadius*0.5,y+neighbourRadius*0.5);
//for (j=0;j<array_length_1d(ids);j++)
//{
//	if (ids[j] == noone)
//	{
//		continue;
//	}
//	seperationX += x - ids[j].x;
//	seperationY += y - ids[j].y;
//	++wallCount;
//}

if (neighbourCount > 0)
{	
	alignmentX /= neighbourCount;
	alignmentY /= neighbourCount;
	
	magnitude = sqrt(alignmentX * alignmentX + alignmentY * alignmentY);
	if (magnitude != 0)
	{
		alignmentX /= magnitude;
		alignmentY /= magnitude;
	}
	
	cohesionX /= neighbourCount;
	cohesionY /= neighbourCount;
	
	magnitude = sqrt(cohesionX * cohesionX + cohesionY * cohesionY);
	if (magnitude != 0)
	{
		cohesionX /= magnitude;
		cohesionY /= magnitude;
	}
	
	seperationX /= neighbourCount + wallCount;
	seperationY /= neighbourCount + wallCount;
	
	magnitude = sqrt(seperationX * seperationX + seperationY * seperationY);
	if (magnitude != 0)
	{
		seperationX /= magnitude;
		seperationY /= magnitude;
	}
}


seperationWeight = 0.35;
alignmentWeight = 0.1;
cohesionWeight = 0.1;
goalWeight = 1 - seperationWeight - alignmentWeight - cohesionWeight;

targetVX += sin(degtorad(angle)) * goalWeight;
targetVY += cos(degtorad(angle)) * goalWeight;
//targetVX += alignmentX * alignmentWeight;
//targetVY += alignmentY * alignmentWeight;
//targetVX += cohesionX;
//targetVY += cohesionY;
targetVX += seperationX * seperationWeight;
targetVY += seperationY * seperationWeight;

magnitude = sqrt(targetVX*targetVX + targetVY*targetVY);
if (magnitude != 0)
{
	targetVX /= magnitude;
	targetVY /= magnitude;
}
maxSpeed = 3;
vx = lerp(vx,targetVX * maxSpeed,0.1);
vy = lerp(vy,targetVY * maxSpeed,0.1);