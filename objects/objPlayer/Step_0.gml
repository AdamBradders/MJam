// Input //////////////////////////////////////////////////////////////////////

var kLeft, kRight, kUp, kDown, kJump, kJumpRelease, tempAccel, tempFric;

kLeft        = keyboard_check(vk_left);
kRight       = keyboard_check(vk_right);
kUp          = keyboard_check(vk_up);
kDown        = keyboard_check(vk_down);

kJump        = keyboard_check_pressed(vk_space);
kJumpRelease = keyboard_check_released(vk_space);

// Movement ///////////////////////////////////////////////////////////////////

//Relative collision checks
cLeft  = place_meeting(x - 1, y, objSolid);
cRight = place_meeting(x + 1, y, objSolid);

// Apply the correct form of acceleration and friction
if (onGround) 
{
    tempAccel = groundAccel;
    tempFric  = groundFric;
} 
else 
{
    tempAccel = airAccel;
    tempFric  = airFric;
}

// Reset wall cling
if ((!cRight && !cLeft) || onGround) 
{
    canStick = true;
    sticking = false;
}   

if (isWallJumpEnabled)
{
	// Cling to wall
	if (((kRight && cLeft) || (kLeft && cRight)) && canStick && !onGround) 
	{
	    alarm[clingTimer] = clingTime;
	    sticking = true; 
	    canStick = false;       
	}
}

// Handle gravity
if (!onGround) 
{
    if ((cLeft || cRight) && vy >= 0) 
	{
        // Wall slide
        vy = Approach(vy, vyMax, gravSlide);
    } else {
        // Fall normally
        vy = Approach(vy, vyMax, gravNorm);
    }
}

isRunning = false;

// Left 
if (kLeft && !kRight && !sticking) 
{
    // Apply acceleration left
    if (vx > 0)
        vx = Approach(vx, 0, tempFric);   
    vx = Approach(vx, -vxMax, tempAccel);
	
	isFacingLeft = true;
	isRunning = true;
}

// Right 
if (kRight && !kLeft && !sticking) 
{
    // Apply acceleration right
    if (vx < 0)
	{
        vx = Approach(vx, 0, tempFric);   
	}
    vx = Approach(vx, vxMax, tempAccel);

	isFacingLeft = false;	
	isRunning = true;
}

isMoving = abs(vx) > 0;

// Friction
if (!kRight && !kLeft)
{
    vx = Approach(vx, 0, tempFric); 
}
        
// Wall jump
if (isWallJumpEnabled)
{
	if (kJump && cLeft && !onGround) 
	{
	    if (kLeft) 
		{
	        vy = -jumpHeight * 1.1;
	        vx =  jumpHeight * .75;
	    } 
		else 
		{
	        vy = -jumpHeight * 1.1;
	        vx =  vxMax;
	    }  
	}

	if (kJump && cRight && !onGround) 
	{
	    if (kRight) 
		{
	        vy = -jumpHeight * 1.1;
	        vx = -jumpHeight * .75;
	    } 
		else 
		{
	        vy = -jumpHeight * 1.1;
	        vx = -vxMax;
	    }  
	}
}

if (kJump) // Jump 
{ 
    if (onGround)
	{
        vy = -jumpHeight;
		draw_yscale = 1.5;
		draw_xscale = 0.75;
		alarm[jumpTimer] = jumpCooldown;
	}
	else if (!onGround && numberAirJumps < maxNumberAirJumps && alarm[jumpTimer] <= 0)
	{
		//We can air jump, so do it!
		vy = -jumpHeight;
		draw_yscale = 1.5;
		draw_xscale = 0.75;
		alarm[jumpTimer] = jumpCooldown;
		numberAirJumps++;
	}
}
else if (kJumpRelease)  // Variable jumping
{ 
    if (vy < 0)
	{
        vy *= 0.25;
	}
}



draw_xscale = lerp(draw_xscale, 1, 0.2);
draw_yscale = lerp(draw_yscale, 1, 0.2);

if (onGround && !wasOnGround)
{
	//reset air jumping
	numberAirJumps = 0;
	
	//Do the skewing effect for landing
	draw_yscale = 0.75;
	draw_xscale = 1.25;
}

//image_xskew = lerp(image_xskew,0,0.1);
//image_yskew = lerp(image_yskew,0,0.1);


