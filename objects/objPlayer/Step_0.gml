// Input //////////////////////////////////////////////////////////////////////

if (energyBar)
{
	energyBar.x = x + energyBarXOffset;
	energyBar.y = y + energyBarYOffset;
}

var kLeft, kRight, kUp, kDown, kJump, kJumpRelease, tempAccel, tempFric;

kLeft        = keyboard_check(vk_left);
kRight       = keyboard_check(vk_right);
kUp          = keyboard_check(vk_up);
kDown        = keyboard_check(vk_down);

kJump        = keyboard_check_pressed(ord("Z"));
kJumpRelease = keyboard_check_released(ord("Z"));

// Movement ///////////////////////////////////////////////////////////////////

//Relative collision checks
cLeft  = place_meeting(x - 1, y, objSolid);
cRight = place_meeting(x + 1, y, objSolid);

// Apply the correct form of acceleration and friction
if (onGround) 
{
	alarm[jumpOverrunTimer] = jumpOverrunTime;
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
if (!onGround && !isFlying) 
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
	if (isFlying)
	{
		angle = (angle + rotationRate);
	}
	else
	{
	    // Apply acceleration left
	    if (vx > 0)
	        vx = Approach(vx, 0, tempFric);   
	    vx = Approach(vx, -vxMax, tempAccel);
	}
	
	isFacingLeft = true;
	isRunning = true;
}

// Right 
if (kRight && !kLeft && !sticking) 
{
	if (isFlying)
	{
		angle = (angle - rotationRate);
		
	}
	else
	{
	    // Apply acceleration right
	    if (vx < 0)
		{
	        vx = Approach(vx, 0, tempFric);   
		}
	    vx = Approach(vx, vxMax, tempAccel);
	}
	isFacingLeft = false;	
	isRunning = true;
}



//Clamp the angle to 0->360 range
if (angle < 0)
{
	angle += 360;
}
if (angle > 360)
{
	angle -= 360;
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
    if (onGround || alarm[jumpOverrunTimer] >= 0)
	{
		alarm[jumpTimer] = jumpCooldown;
		isFlying = false;
        vy = -jumpHeight;
		draw_yscale = onJumpYSquish;
		draw_xscale = onJumpXSquish;
	}
	else if (!onGround && alarm[jumpTimer] < 0 && energy >= minAirJumpEnergy)
	{
		alarm[jumpTimer] = jumpCooldown;
		//We can air jump, so do it!
		vy = -jumpHeight;
		draw_yscale = onAirJumpYSquish;
		draw_xscale = onAirJumpXSquish;
		
		numberAirJumps++;
		isFlying = true;
		energy -= flapEnergyUse;
	}
}
else if (kJumpRelease && numberAirJumps == 0)  // Variable jumping
{ 
    if (vy < 0)
	{
        vy *= 0.25;
	}
	isFlying = false;
}
else if (kJumpRelease)
{
	//Stop rotating
	isFlying = false;
}

draw_xscale = lerp(draw_xscale, 1, 0.2);
draw_yscale = lerp(draw_yscale, 1, 0.2);

//if (alarm[flyingTimer] < 0 && isFlying)
//{
//	isFlying = false;
//}

if (onGround)
{
	//reset air jumping
	numberAirJumps = 0;
	//reset flying
	isFlying = false;
	//reset our facing angle to straight up
	angle = 0;
}

if (onGround && !wasOnGround)
{
	//Do the skewing effect for landing
	draw_yscale = onLandingYSquish;
	draw_xscale = onLandingXSquish;
}


//flying thrust
if (isFlying)
{
	//vx = Approach(vx, vxFlyingMax * -sin(degtorad(angle)), flyingAccel);
	//vy = Approach(vy, vyFlyingMax * -cos(degtorad(angle)), flyingAccel);
	vx -= flyingAccel * sin(degtorad(angle));
	vy -= flyingAccel * cos(degtorad(angle));
	velocityMagnitude = sqrt(vx*vx + vy*vy);
	if (velocityMagnitude > vxFlyingMax)
	{
		vx = vx/velocityMagnitude;
		vy = vy/velocityMagnitude;
		
		vx *= vxFlyingMax;
		vy *= vxFlyingMax;
	}
	
	//energy bar drop
	energy -= flyingEnergyDrainRate;
	if (energy < 0) //lerping error?
	{
		energy = 0;
	}
}

if (energy <= 0)
{
	energy = 0;
	isFlying = false;
}


//image_xskew = lerp(image_xskew,0,0.1);
//image_yskew = lerp(image_yskew,0,0.1);

///////////////////////////////////////////////////////////////
//Animations///////////////////////////////////////////////////
///////////////////////////////////////////////////////////////

if (onGround)
{
	energy = maxEnergy;
	if (isRunning)
	{
		sprite_index = isFacingLeft ? spriteRunningLeft : spriteRunningRight;
	}
	else
	{
		sprite_index = isFacingLeft ? spriteIdleLeft : spriteIdleRight;
	}
}
else
{
	if (vy <= 0 || isFlying)
	{
		sprite_index = spriteJump;
	}
	else
	{
		sprite_index = isFacingLeft ? spriteFallLeft : spriteFallRight;
		angle = 0
	}
	
}

//breathing animation

if (isRunning)
{
	breathingRate = breathingRateRunning;
	breathingAmplitudeY = breathingAmplitudeYRunning;
}
else
{
	breathingAmplitudeY = lerp(breathingAmplitudeY, breathingAmplitudeYIdle,0.05);
	breathingRate = lerp(breathingRate, breathingRateIdle,0.03);
}
draw_yscale +=  breathingAmplitudeY * sin(degtorad(breathingSinAngle));
breathingSinAngle += breathingRate;
if (breathingSinAngle > 360)
{
	breathingSinAngle -= 360;
}