event_inherited();

onHitRecoil = 10;

hp = 3;

moveSquish = 0.5;
squishRate = 0.1;

moveThrust = 10;
moveFric = 0.3;

moveTriggerDistance = 10 * 32; //10 tiles

canMove = true;
moveCooldown = 0.4 * room_speed;

drawing_scale = 1;

alarm[0] = moveCooldown;

//Breathing animation
breathingAmplitudeYIdle = 0.01;
breathingAmplitudeYRunning = 0.06;
breathingAmplitudeY = breathingAmplitudeYIdle;
breathingSinAngle = random(359);
breathingRateIdle = 8;
breathingRateRunning = 40;
breathingRate = breathingRateIdle;

hitFrameTime = 0.3 * room_speed;