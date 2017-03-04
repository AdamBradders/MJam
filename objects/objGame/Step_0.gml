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
		global.playerInstance = instance_create_layer(xPos,yPos,"Instances",objPlayer);
	}
}