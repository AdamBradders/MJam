event_inherited();

onHitRecoil = 10;


bounceOnContact = true;
bounceCoeff = 0.8;

hp = 3;

moveSquish = 0.5;
bulletHitSquish = 0.1;
squishRate = 0.1;

moveThrust = 4;
moveFric = 0.1;

moveTriggerDistance = 10 * 32; //10 tiles

canMove = true;
moveCooldown = 0.9 * room_speed;

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