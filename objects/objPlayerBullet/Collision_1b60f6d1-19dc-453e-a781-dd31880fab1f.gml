/// @description Insert description here
// You can write your code in this editor

//get normalise velocity
magnitude = sqrt(vx*vx + vy*vy);
normVX = vx/magnitude;
normVY = vy/magnitude;

other.vx = normVX * onHitRecoil;
other.vy = normVY * onHitRecoil;;
instance_destroy(id);
