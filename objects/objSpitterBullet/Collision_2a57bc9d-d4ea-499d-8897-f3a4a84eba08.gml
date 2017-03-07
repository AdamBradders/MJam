/// @description Insert description here
// You can write your code in this editor

//get normalise velocity
magnitude = sqrt(vx*vx + vy*vy);
normVX = vx/magnitude;
normVY = vy/magnitude;

other.vx = normVX * other.onHitRecoil;
other.vy = normVY * other.onHitRecoil;;
instance_destroy(id);
