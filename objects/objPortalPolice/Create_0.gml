event_inherited();

angle = 0;
moveThrust = 4;

maxSpeed = 3;

hitFrameTime = 0.1 * room_speed;

wallDamageTime = 1 * room_speed;
alarm[0] = 0;
ds_list_add(global.portalPolice, id);

vx = 0;
vy = -maxSpeed;