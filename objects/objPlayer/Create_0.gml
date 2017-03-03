// Inherit oParEntity variables
event_inherited();




//Character logic for Mike to fuck with

isWallJumpEnabled = false; //enable/disable wall jump functionality
maxNumberAirJumps = 3; //maximum number of times you can jump/flap whatevs
jumpCooldown = 1; //minimum time between jumps/air jumps









//These are 'getable' - don't change them here!
//YOU HEAR ME, CUNT? DON'T FUCKING CHANGE THESE.
isRunning = false;
isMoving = false;
isFacingLeft = false;

// Movement ///////////////////////////////////////////////////////////////////

// Multiplier
m = 1.0;

groundAccel = 1.0  * m;
groundFric  = 1.9  * m;
airAccel    = 0.75 * m;
airFric     = 0.1  * m;
vxMax       = 6.5  * m;
vyMax       = 10.0 * m;
jumpHeight  = 8.0  * m;
gravNorm    = 0.5  * m;
gravSlide   = 0.25 * m; 

clingTime   = 4.0 * m;

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