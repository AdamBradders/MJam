if (global.levelGenEnabled == false)
{
	return;
}

if (global.roomNeedsRestart && alarm[1] < 0)
{
	alarm[1] = room_restart_time;
}

/// Update game debug
var kRestart, kExit, kPrev, kNext;

kRestart = keyboard_check_pressed(ord("R"));
kExit    = keyboard_check_pressed(vk_escape);
kPrev    = keyboard_check_pressed(vk_subtract);
kNext    = keyboard_check_pressed(vk_add);

if (kRestart)
    room_restart();
if (kExit)
    game_end();
    
// Iterate through rooms backward
if (kPrev) {
    if (room == room_first)
        room_goto(room_last);
    else
        room_goto_previous();
}

// Iterate through rooms forwards
if (kNext) {
    if (room == room_last)
        room_goto(room_first);
    else
        room_goto_next();
}

//if (levelGenerationComplete == true &&
//	portalStep > 0)
//{
	
//	sizeW = lerp(camera_get_view_width(view_camera[0]), camSizeW, 0.1);//camZoomSpeed);
//	sizeH = lerp(camera_get_view_height(view_camera[0]), camSizeH, 0.1);//camZoomSpeed);
	
//	camera_set_view_size(view_camera[0], sizeW, sizeH);
//}

////////////////////////////////////////////////////////////////
//Check level gen complete and spawn player/////////////////////
////////////////////////////////////////////////////////////////
if (levelGenerationComplete == false)
{
	i = 0;
	success = true;
	repeat(array_length_1d(minerInstances))
	{
		if (minerInstances[i++].numberOfMoves > 0)
		{
			success = false;
			break;
		}
	}
	levelGenerationComplete = success;
	if (success)
	{
		//Level just finished, so spawn the player!
		xPos = 0;
		yPos = 0;
		
		//Find a start position for the player
		numberOfSolidBlocks = instance_number(objSolid);
		i = 0;
		repeat (numberOfSolidBlocks)
		{
			block = instance_find(objSolid,i++);
			if (!place_meeting(block.x,block.y-32,objSolid))
			{
				//this is a free space right above a solid block, place our player here!
				xPos = block.x + 16;
				yPos = block.y - 30;
				break;
			}
		}
		
		//Clear all blocks upwards from this point
		//xClear = block.x;
		//yClear = block.y-32;
		//while (yClear >= 0)
		//{
		//	if (!place_meeting(xClear,yClear,objSolid))
		//	{
		//		blockToKill = instance_position(xClear,yClear,objSolid);
		//		if (blockToKill != noone)
		//		{
		//			instance_destroy(blockToKill);
		//		}
		//	}
		//	yClear-= 32;
		//}
		
		//Spawn the portal
		global.portalStartX = xPos;
		global.portalStartY = yPos;
		
		//Set the camera to this position
		//camera_set_view_pos(view_camera[0],global.portalStartX - (view_wport[0] * 0.5),global.portalStartY - (portalVerticalOffset*32) - (view_hport[0] * 0.5));
		camera_set_view_target(view_camera[0],instance_create_layer(xPos,yPos-portalVerticalOffset*32,"Instances",objPortalDummy));
		
		//Find exit position
		xPos = 0;
		yPos = 0;
		
		//Find a start position for the player
		numberOfSolidBlocks = instance_number(objSolid);
		i = 0;
		repeat (numberOfSolidBlocks)
		{
			block = instance_find(objSolid,i++);
			if (!place_meeting(block.x,block.y-32,objSolid))
			{
				
				//this is a free space right above a solid block, place our player here!
				xPos = block.x + 16;
				yPos = block.y - 30;
				if (point_distance(xPos,yPos,global.portalStartX, global.portalStartY) > 100*32)
				{
					break;
				}
			}
				
		}
		
				
		//Spawn the exit portal
		{
			explodeRadius = 5 * 32;
			//Spawn the portal and clear area around it...
			global.portals[1] = instance_create_layer(xPos,yPos,"instance_portals",objPortal);
			global.portals[1].isExit = true;
		}
		
		//////////////////////////////////////////////////
		//Create all the bad dudes////////////////////////
		//////////////////////////////////////////////////
		//Floaters
		numFloaters = 50;
		repeat (numFloaters)
		{
			floaterX = 0;
			floaterY = 0;
			while (true)
			{
				floaterX = random_range(64,room_width-64);
				floaterY = random_range(64,room_height-64);
				
				if (!collision_rectangle( floaterX - 32, floaterY - 32, floaterX + 32, floaterY + 32, objSolid, false, true )&&
					!collision_rectangle( floaterX - 32, floaterY - 32, floaterX + 32, floaterY + 32, objEntity, false, true ))
					{
						break;
					}
			}
			instance_create_layer(floaterX,floaterY,"Instances",objFloater);
		}
		
		//Poppers
		numPopperFloaters = 10;
		repeat (numPopperFloaters)
		{
			floaterX = 0;
			floaterY = 0;
			while (true)
			{
				floaterX = random_range(64,room_width-64);
				floaterY = random_range(64,room_height-64);
				
				if (!collision_rectangle( floaterX - 32, floaterY - 32, floaterX + 32, floaterY + 32, objSolid, false, true )&&
					!collision_rectangle( floaterX - 32, floaterY - 32, floaterX + 32, floaterY + 32, objEntity, false, true ))
					{
						break;
					}
			}
			instance_create_layer(floaterX,floaterY,"Instances",objFloaterPopper);
		}
		//Bombs
		numBombs = 10;
		wallN = 0;
		repeat (numBombs)
		{
			bombX = 0;
			bombY = 0;
			wallCount = instance_number(objSolid);
			bombPlaced[wallCount-1] = false;
			//Find a vertical wall
			repeat(wallCount)
			{
				attempts = 10;
				i = 0;
				while (i < attempts)
				{
					wallN = floor(random(wallCount));
					if (!bombPlaced[wallN])
					{
						break;
					}
					++i;
				}
				
				wallBlock = instance_find(objSolid,wallN);
				
				bombX = wallBlock.x-1;
				bombY =	wallBlock.y-16;
				
				//tile above not free but tile above left/above right free?
				above =!collision_rectangle(wallBlock.x, wallBlock.y-32,wallBlock.x+32,wallBlock.y-32-32,objSolid,false,false);
				if (above)
				{
					continue;
				}
				
				//tile to the left or right free?
				left = !collision_rectangle(wallBlock.x - 32, wallBlock.y,wallBlock.x-1,wallBlock.y-32,objSolid,false,false) &&
						!collision_rectangle(wallBlock.x - 32, wallBlock.y-32,wallBlock.x-1,wallBlock.y-32-32,objSolid,false,false) &&
						!collision_rectangle(wallBlock.x - 32, wallBlock.y+1,wallBlock.x-1,wallBlock.y+32,objSolid,false,false);
						
				right = !collision_rectangle(wallBlock.x + 32, wallBlock.y,wallBlock.x+32+31,wallBlock.y-32,objSolid,false,false) &&
						!collision_rectangle(wallBlock.x + 32, wallBlock.y-32,wallBlock.x+32+31,wallBlock.y-32-32,objSolid,false,false) &&
						!collision_rectangle(wallBlock.x + 32, wallBlock.y+1,wallBlock.x+32+31,wallBlock.y+32,objSolid,false,false);
				
				availableSpacesCount = 0;
				if (left)
				{
					availableSpacesCount++;
				}
				if (right)
				{
					availableSpacesCount++;
				}
				
				if (availableSpacesCount == 0)
				{
					continue;
				}
				
				if (random(1) < 0.5)
				{
					if (left)
					{
						bombPlaced[wallN] = true;
						show_debug_message("PLACED BOMB AT " + string(bombX) + "," + string(bombY));
						bomb = instance_create_layer(bombX,bombY,"Instances",objBomb);
						bomb.angle = 90;
						bomb.attachedBlock = wallBlock;
						wallBlock.attachedBomb = bomb;
					}
					else if (right)
					{
						bombPlaced[wallN] = true;
						show_debug_message("PLACED BOMB AT " + string(bombX) + "," + string(bombY));
						bomb = instance_create_layer(bombX+32,bombY,"Instances",objBomb);
						bomb.angle = -90;
						bomb.attachedBlock = wallBlock;
						wallBlock.attachedBomb = bomb;
					}
					break;
				}
				else
				{
					if (right)
					{
						bombPlaced[wallN] = true;
						show_debug_message("PLACED BOMB AT " + string(bombX) + "," + string(bombY));
						bomb = instance_create_layer(bombX+32,bombY,"Instances",objBomb);
						bomb.angle = -90;
						bomb.attachedBlock = wallBlock;
						wallBlock.attachedBomb = bomb;
					}
					else if (left)
					{
						bombPlaced[wallN] = true;
						show_debug_message("PLACED BOMB AT " + string(bombX) + "," + string(bombY));
						bomb = instance_create_layer(bombX,bombY,"Instances",objBomb);
						bomb.angle = 90;
						bomb.attachedBlock = wallBlock;
						wallBlock.attachedBomb = bomb;
					}
					break;
				}
			}
		}
		
		//Spitters left/right
		numSpitters = 10;
		wallN = 0;
		repeat (numSpitters)
		{
			spitterX = 0;
			spitterY = 0;
			wallCount = instance_number(objSolid);
			bombPlaced[wallCount-1] = false;
			//Find a vertical wall
			repeat(wallCount)
			{
				attempts = 10;
				i = 0;
				while (i < attempts)
				{
					wallN = floor(random(wallCount));
					if (!bombPlaced[wallN])
					{
						break;
					}
					++i;
				}
				
				wallBlock = instance_find(objSolid,wallN);
				
				spitterX = wallBlock.x-1;
				spitterY =	wallBlock.y-16;
				
				//tile above not free but tile above left/above right free?
				above =!collision_rectangle(wallBlock.x, wallBlock.y-32,wallBlock.x+32,wallBlock.y-32-32,objSolid,false,false);
				if (above)
				{
					continue;
				}
				
				//tile to the left or right free?
				left = !collision_rectangle(wallBlock.x - 32, wallBlock.y,wallBlock.x-1,wallBlock.y-32,objSolid,false,false) &&
						!collision_rectangle(wallBlock.x - 32, wallBlock.y-32,wallBlock.x-1,wallBlock.y-32-32,objSolid,false,false) &&
						!collision_rectangle(wallBlock.x - 32, wallBlock.y+1,wallBlock.x-1,wallBlock.y+32,objSolid,false,false);
						
				right = !collision_rectangle(wallBlock.x + 32, wallBlock.y,wallBlock.x+32+31,wallBlock.y-32,objSolid,false,false) &&
						!collision_rectangle(wallBlock.x + 32, wallBlock.y-32,wallBlock.x+32+31,wallBlock.y-32-32,objSolid,false,false) &&
						!collision_rectangle(wallBlock.x + 32, wallBlock.y+1,wallBlock.x+32+31,wallBlock.y+32,objSolid,false,false);
				
				availableSpacesCount = 0;
				if (left)
				{
					availableSpacesCount++;
				}
				if (right)
				{
					availableSpacesCount++;
				}
				
				if (availableSpacesCount == 0)
				{
					continue;
				}
				
				if (random(1) < 0.5)
				{
					if (left)
					{
						bombPlaced[wallN] = true;
						show_debug_message("PLACED SPITTER AT " + string(spitterX) + "," + string(spitterY));
						bomb = instance_create_layer(spitterX,spitterY,"Instances",objWallSpitter);
						bomb.angle = 90;
						bomb.attachedBlock = wallBlock;
						wallBlock.attachedBomb = bomb;
					}
					else if (right)
					{
						bombPlaced[wallN] = true;
						show_debug_message("PLACED SPITTER AT " + string(spitterX) + "," + string(spitterY));
						bomb = instance_create_layer(spitterX+32,spitterY,"Instances",objWallSpitter);
						bomb.angle = 270;
						bomb.attachedBlock = wallBlock;
						wallBlock.attachedBomb = bomb;
					}
					break;
				}
				else
				{
					if (right)
					{
						bombPlaced[wallN] = true;
						show_debug_message("PLACED SPITTER AT " + string(spitterX) + "," + string(spitterY));
						bomb = instance_create_layer(spitterX+32,spitterY,"Instances",objWallSpitter);
						bomb.angle = 270;
						bomb.attachedBlock = wallBlock;
						wallBlock.attachedBomb = bomb;
					}
					else if (left)
					{
						bombPlaced[wallN] = true;
						show_debug_message("PLACED SPITTER AT " + string(spitterX) + "," + string(spitterY));
						bomb = instance_create_layer(spitterX,spitterY,"Instances",objWallSpitter);
						bomb.angle = 90;
						bomb.attachedBlock = wallBlock;
						wallBlock.attachedBomb = bomb;
					}
					break;
				}
			}
		}
		
		//Spitters up/down
		numSpitters = 10;
		wallN = 0;
		repeat (numSpitters)
		{
			spitterX = 0;
			spitterY = 0;
			wallCount = instance_number(objSolid);
			bombPlaced[wallCount-1] = false;
			//Find a vertical wall
			repeat(wallCount)
			{
				attempts = 10;
				i = 0;
				while (i < attempts)
				{
					wallN = floor(random(wallCount));
					if (!bombPlaced[wallN])
					{
						break;
					}
					++i;
				}
				
				wallBlock = instance_find(objSolid,wallN);
				
				spitterX = wallBlock.x+16;
				spitterY =	wallBlock.y;
				
				//tile to the left or right free?
				up = !collision_rectangle(wallBlock.x, wallBlock.y-32,wallBlock.x+32,wallBlock.y-32-64,objSolid,false,false) &&
					!collision_rectangle(wallBlock.x - 32, wallBlock.y-32,wallBlock.x,wallBlock.y-32-64,objSolid,false,false) &&
					 !collision_rectangle(wallBlock.x + 32, wallBlock.y-32,wallBlock.x+32+32,wallBlock.y-32-64,objSolid,false,false);	
						
						
				down = !collision_rectangle(wallBlock.x, wallBlock.y+1,wallBlock.x+32,wallBlock.y+64,objSolid,false,false) &&
					!collision_rectangle(wallBlock.x - 32, wallBlock.y+1,wallBlock.x,wallBlock.y+32+64,objSolid,false,false) &&
					 !collision_rectangle(wallBlock.x + 32, wallBlock.y+1,wallBlock.x+32+32,wallBlock.y+32+64,objSolid,false,false);	
				
				
				availableSpacesCount = 0;
				if (up)
				{
					availableSpacesCount++;
				}
				if (down)
				{
					availableSpacesCount++;
				}
				
				if (availableSpacesCount == 0)
				{
					continue;
				}
				
				if (random(1) < 0.5)
				{
					if (up)
					{
						bombPlaced[wallN] = true;
						show_debug_message("PLACED HORIZONTAL SPITTER AT " + string(spitterX) + "," + string(spitterY));
						bomb = instance_create_layer(spitterX,spitterY-32,"Instances",objWallSpitter);
						bomb.angle = 0;
						bomb.attachedBlock = wallBlock;
						wallBlock.attachedBomb = bomb;
					}
					else if (down)
					{
						bombPlaced[wallN] = true;
						show_debug_message("PLACED HORIZONTAL SPITTER AT " + string(spitterX) + "," + string(spitterY));
						bomb = instance_create_layer(spitterX,spitterY+1,"Instances",objWallSpitter);
						bomb.angle = 180;
						bomb.attachedBlock = wallBlock;
						wallBlock.attachedBomb = bomb;
					}
					break;
				}
				else
				{
					if (down)
					{
						bombPlaced[wallN] = true;
						show_debug_message("PLACED HORIZONTAL SPITTER AT " + string(spitterX) + "," + string(spitterY));
						bomb = instance_create_layer(spitterX,spitterY+1,"Instances",objWallSpitter);
						bomb.angle = 180;
						bomb.attachedBlock = wallBlock;
						wallBlock.attachedBomb = bomb;
					}
					else if (up)
					{
						bombPlaced[wallN] = true;
						show_debug_message("PLACED HORIZONTAL SPITTER AT " + string(spitterX) + "," + string(spitterY));
						bomb = instance_create_layer(spitterX,spitterY-32,"Instances",objWallSpitter);
						bomb.angle = 0;
						bomb.attachedBlock = wallBlock;
						wallBlock.attachedBomb = bomb;
					}
					
					
					break;
				}
			}
		}
		alarm[0] = portalPreSpawnTime;
		camera_set_view_size(view_camera[0], camSizeW, camSizeH);
	}
}