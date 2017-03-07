// Accelerate
pDir = global.playerInstance != noone ? point_direction(x,y,global.playerInstance.x,global.playerInstance.y) : point_direction(x,y,mouse_x,mouse_y);
distanceToPlayer = global.playerInstance != noone ? point_distance(x,y,global.playerInstance.x,global.playerInstance.y) : point_distance(x,y,mouse_x,mouse_y);

canSee = false;
if (global.playerInstance != noone)
{
	canSee = collision_line(x, y, global.playerInstance.x, global.playerInstance.y, objSolid, false, false) == noone;
}

vx += lengthdir_x(canSee ? accelCanSee : accel,pDir);
vy += lengthdir_y(canSee ? accelCanSee : accel,pDir);

// Avoid other boids
with(objBoid) {
	if id != other.id {
	    pDist = point_distance(other.x,other.y,x,y);
	    pDir = point_direction(other.x,other.y,x,y);
	    force = spread/pDist;
	    vx += lengthdir_x(force,pDir);
	    vy += lengthdir_y(force,pDir);
	}
}


//Avoid walls
neighbourRadius = 8*32;
ids = get_ids_region(objSolid,x-neighbourRadius*0.5,y-neighbourRadius*0.5,x+neighbourRadius*0.5,y+neighbourRadius*0.5);
for (j=0;j<array_length_1d(ids);j++)
{
	if (ids[j] == noone)
	{
		continue;
	}
		pDist = point_distance(ids[j].x,ids[j].y,x,y);
		pDir = point_direction(ids[j].x,ids[j].y,x,y);
		force = (canSee ? 0.1 : wallSpread)/pDist;
		vx += lengthdir_x(force,pDir);
		vy += lengthdir_y(force,pDir);
}

mSpeed = canSee ? maxSpdCanSee : maxSpd;
// Limit speed
vx = min(max(vx,-mSpeed),mSpeed);
vy = min(max(vy,-mSpeed),mSpeed);

// Update image angle
image_angle -= angle_difference(image_angle,point_direction(0,0,vx,vy))*imageTurnSpd;