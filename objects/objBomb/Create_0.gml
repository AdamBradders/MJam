event_inherited();

attachedBlock = noone;

explodeRadius = 2 * 32;

onHitRecoil = 1;

hp = 3;

canMove = true;
moveCooldown = 0.9 * room_speed;

bulletHitSquish = 0.4;

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
squishRate = 0.1;

angle = 0;