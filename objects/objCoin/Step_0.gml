bounceOnContact = true;
bounceCoeff = 0.3;

// Handle gravity
if (!onGround) 
{
    // Fall normally
    vy = Approach(vy, vyMax, gravNorm);
}