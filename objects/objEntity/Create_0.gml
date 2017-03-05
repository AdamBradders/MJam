// Velocity
vx = 0;
vy = 0;

onGround = OnGround();
wasOnGround = onGround;
isFalling = vy > 0;

bounceOnContact = false;
bounceCoeff = 0.3;