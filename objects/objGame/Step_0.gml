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
		xClear = block.x;
		yClear = block.y-32;
		while (yClear >= 0)
		{
			if (!place_meeting(xClear,yClear,objSolid))
			{
				blockToKill = instance_position(xClear,yClear,objSolid);
				if (blockToKill != noone)
				{
					instance_destroy(blockToKill);
				}
			}
			yClear-= 32;
		}
		
		//Spawn the portal
		global.portalStartX = xPos;
		global.portalStartY = yPos;
		
		//Set the camera to this position
		camera_set_view_pos(view_camera[0],xPos - (view_wport[0] * 0.5),yPos - (view_hport[0] * 0.5));
		global.portals[0] = instance_create_layer(xPos,yPos-portalVerticalOffset*32,"instance_portals",objPortal);
				
		//Kill blocks around portal
		for (iX=0;iX<portalHorizontalOffset;iX++)
		{
			for (iY=0;iY<portalVerticalOffset;iY++)
			{
				startX = xPos-(portalHorizontalOffset*32*0.5);
				startY = yPos-(portalVerticalOffset*32) - (portalVerticalOffset*32*0.5);
				
				block = instance_position(startX+(iX*32),startY+(iY*32),objSolid);
				if (block != noone)
				{
					show_debug_message("PORTAL CLEARED A BLOCK!!");
					instance_destroy(block);
				}
			}
		}
		
		camera_set_view_target(view_camera[0],global.portals[0]);
		alarm[0] = portalPreSpawnTime;
	}
}