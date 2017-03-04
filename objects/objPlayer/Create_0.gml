energyBarXOffset = 0;
energyBarYOffset = -40;

energyBar = instance_create_layer(x+energyBarXOffset,y+energyBarYOffset,"Instances",objEnergyBar);

// Inherit objEntity variables
event_inherited();

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//EVERYTHING IN HERE YOU CAN EDIT, MIKEY MAN
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
//Character logic for Mike to fuck with

isWallJumpEnabled = false; //enable/disable wall jump functionality
jumpCooldown = 0.1 * room_speed; //minimum time between jumps/air jumps
jumpOverrunTime = 0.1 * room_speed; //time after leaving the ground that you can still jump
//flyingTime = 2 * room_speed;
maxEnergy = 100;
energy = maxEnergy;
flapEnergyUse = 10; //amount of energy used to perform a flap
minAirJumpEnergy = flapEnergyUse; //minimum energy required to perform a flap
flyingEnergyDrainRate = 0.8; //energy use per frame to sustain flying

//Squishes
onLandingXSquish = 2;
onLandingYSquish = 0.25;
onJumpXSquish = 0.25;
onJumpYSquish = 3;
onAirJumpXSquish = 0.5;
onAirJumpYSquish = 2.0;

//Movement stuff
// Multiplier
m = 1.0;

groundAccel = 1.0  * m;
groundFric  = 1.9  * m;
airAccel    = 0.75 * m;
airFric     = 0.1  * m;
vxMax       = 6.5  * m;
vyMax       = 10.0 * m;
jumpHeight  = 12.0  * m;
gravNorm    = 0.5  * m;
gravSlide   = 0.25 * m; 
rotationRate = 7 * m;
flyingAccel = 2.0 * m;
flyingFric = 0.1 * m;
vxFlyingMax = 9.0  * m;
vyFlyingMax = 9.0 * m;
clingTime   = 4.0 * room_speed * m;

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//EVERYTHING BELOW HERE YOU CAN'T EDIT. WELL YOU CAN, BUT AT YOUR OWN RISK, YO.

//These are 'getable' - don't change them here!
//YOU HEAR ME, CUNT? DON'T FUCKING CHANGE THESE.
isRunning = false;
isMoving = false;
isFacingLeft = false;
isFlying = false;

//Animations

spriteIdleLeft = sprPlayerIdleLeft;
spriteIdleRight = sprPlayerIdleRight;
spriteRunningLeft = sprPlayerRunLeft;
spriteRunningRight = sprPlayerRunRight;
spriteJump = sprPlayerJump;
spriteFallLeft = sprPlayerFallLeft;
spriteFallRight = sprPlayerFallRight;

//Timer Assignments

clingTimer = 0;
jumpTimer = 1;
flyingTimer = 2;
jumpOverrunTimer = 3;

// Misc ///////////////////////////////////////////////////////////////////////

// Relative collision checks
cLeft  = place_meeting(x - 1, y, objSolid);
cRight = place_meeting(x + 1, y, objSolid);

// Common calculation
sqrt2 = sqrt(2);

//air jumps

numberAirJumps = 0;

//flying shiz
angle = 0;

//Skewing

draw_xscale = 1;
draw_yscale = 1;

image_xskew = 0;
image_yskew = 0;

//Breathing animation
breathingAmplitudeYRunning = 0.03;
breathingAmplitudeYIdle = 0.01;
breathingAmplitudeY = breathingAmplitudeYIdle;
breathingSinAngle = 0;
breathingRateIdle = 8;
breathingRateRunning = 40;
breathingRate = breathingRateIdle;