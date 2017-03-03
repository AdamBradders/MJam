// Inherit oParEntity variables
event_inherited();


//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//EVERYTHING IN HERE YOU CAN EDIT, MIKEY MAN
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
//Character logic for Mike to fuck with

isWallJumpEnabled = false; //enable/disable wall jump functionality
maxNumberAirJumps = 3; //maximum number of times you can jump/flap whatevs
jumpCooldown = 0.2; //minimum time between jumps/air jumps

//Squishes
onLandingXSquish = 1.25;
onLandingYSquish = 0.75;
onJumpXSquish = 0.75;
onJumpYSquish = 1.5;
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

clingTime   = 4.0 * m;

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

// Misc ///////////////////////////////////////////////////////////////////////

// Relative collision checks
cLeft  = place_meeting(x - 1, y, objSolid);
cRight = place_meeting(x + 1, y, objSolid);

// Common calculation
sqrt2 = sqrt(2);

//air jumps

numberAirJumps = 0;

//Skewing

draw_xscale = 1;
draw_yscale = 1;

image_xskew = 0;
image_yskew = 0;