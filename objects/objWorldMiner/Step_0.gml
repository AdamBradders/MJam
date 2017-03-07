/// Run mining shiz to place ground

if (numberOfMoves > 0)
{
	//Place a world tile...
	if (!place_meeting(x,y,objSolid))
	{
		if (rareTile)
		{
			if (!place_meeting(x+32,y,objSolid) && !place_meeting(x,y+32,objSolid) && !place_meeting(x+32,y+32,objSolid))
			{
				groundTile = instance_create_layer(x,y,"Instances", objGroundRareBig);
				global.rareTileCount++;
			}
		}
		else if (bigTile)
		{
			if (!place_meeting(x+32,y,objSolid) && !place_meeting(x,y+32,objSolid) && !place_meeting(x+32,y+32,objSolid))
			{
				groundTile = instance_create_layer(x,y,"Instances",random(1) < likelyhoodIsGold ? objGroundGoldBig : objGroundNormalBig);
			}
		}
		else
		{
			groundTile = instance_create_layer(x,y,"Instances",random(1) < likelyhoodIsGold ? objGroundGold : objGroundNormal);
			numberOfMoves--;
		}
		
		previousWasBigTile = bigTile;
	}
	
	rareTile = random(1) <= likelyhoodRareTile && global.rareTileCount < global.maxRareTilesPerLevel;

	bigTile = random(1) <= likelyhoodBigTile || rareTile;
	
	//choose a direction at random
	//Favour horizontal or vertical?
	totalLikelyhood = likelyhoodVertical + likelyhoodHorizontal;
	randomValue = random(totalLikelyhood);
	
	success = false;
	
	if (randomValue < likelyhoodVertical)
	{
		//go vertical
		trys = 0;
		up = random(1) < 0.5 ? true : false;
		while (trys < 2)
		{
			
			yPos = up ? y - (previousWasBigTile ? 64 : 32) : y + (bigTile ? 64 : 32);
			if (place_meeting(x, yPos, objSolid) == false
				&& (yPos >= (32*global.worldMarginSizeInTiles) && yPos <= room_height-(32*global.worldMarginSizeInTiles)))
			{
				success = true;
				y = yPos;
				break;
			}
			else
			{
				up = !up;
			}
			++trys;
		}
	}
	
	if (randomValue >= likelyhoodVertical || success == false)
	{
		//go horizontal
		trys = 0;
		left = random(1) < 0.5 ? true : false;	
		while (trys < 2)
		{
			xPos = left ? x - (bigTile ? 64 : 32) : x + (previousWasBigTile ? 64 : 32);
			if (place_meeting(xPos, y, objSolid) == false
				&& (xPos >= (32*global.worldMarginSizeInTiles) && xPos <= (room_width-(32*global.worldMarginSizeInTiles))))
			{
				success = true;
				x = xPos;
				break;
			}
			else
			{
				left= !left;
			}
			++trys;
		}
	}
	
	if (success == false)
	{
		//We failed to place any block, so just move us somewhere random and try again next step
		count = 0;
		tileSize = 32;
		while (true)
		{
			if (count > 10)
			{
				tileSize = 64;
			}
			xPos = x;
			yPos = y;
			moveHorizontal = random(1) > 0.5;
			if (moveHorizontal)
			{
				xPos = x + (random(1) > 0.5 ? tileSize : -tileSize);
			}
			else
			{
				yPos = y + (random(1) > 0.5 ? tileSize : -tileSize);
			}
			if (xPos < (32*global.worldMarginSizeInTiles) || xPos >= (room_width-(32*global.worldMarginSizeInTiles)) || yPos < 32 *global.worldMarginSizeInTiles || yPos >= (room_height-(32*global.worldMarginSizeInTiles)))
			{
				//invalid!
			}
			else
			{
				x = xPos;
				y = yPos;
				break;
			}
			count++;
		}
	}
}
else
{
	//instance_destroy(id);
}