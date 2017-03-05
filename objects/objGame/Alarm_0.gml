
//Spawn the player
global.playerInstance = instance_create_layer(xPos,yPos-portalVerticalOffset*32,"instance_player",objPlayer);
camera_set_view_target(view_camera[0],global.playerInstance);