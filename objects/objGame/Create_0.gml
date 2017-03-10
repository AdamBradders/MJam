/// Create miners
global.challengePortal = instance_find(objPortal_Challenge,0);
global.playerInstance = noone;
global.isChallengeRoom = global.challengePortal != noone;
global.portalPolice = ds_list_create();
global.roomNeedsRestart = false;
global.playerScore = 0;
global.maxRareTilesPerLevel = 1;
global.rareTileCount = 0;
global.levelGenEnabled = true;

camZoomSpeed = 60;

camSizeW = camera_get_view_width(view_camera[0]);
camSizeH = camera_get_view_height(view_camera[0]);
camera_set_view_size(view_camera[0], room_width, room_height);

randomize();
//Alternativly use the line below to force the same level generation every time
//random_set_seed(10);

numberOfMiners = 20;

room_restart_time = 3 * room_speed; //time to delay before restarting on player death

global.worldMarginSizeInTiles = 5;
portalPreSpawnTime = 3 * room_speed;
portalVerticalOffset = 4;
portalVerticalClear = 4*32;
portalHorizontalClear = 6*32;
portalStep = 0;

if (global.levelGenEnabled && !global.isChallengeRoom)
{
	i = numberOfMiners;
	repeat(numberOfMiners)
	{
		margin = ((global.worldMarginSizeInTiles+1)*32);
		randomX = margin + floor(random(room_width-margin*2));
		randomY = margin + floor(random(room_height-margin*2));
		minerInstances[--i] = instance_create_layer(randomX,randomY,"Instances",objWorldMiner);
	}
}
else if (global.isChallengeRoom)
{
	global.portalStartX = global.challengePortal.x;
	global.portalStartY = global.challengePortal.y+portalVerticalOffset*32;
	alarm[0] = portalPreSpawnTime;
	portalStep = 1;
}
levelGenerationComplete = false;

