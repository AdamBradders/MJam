/// Bullet creation shizzles
// Inherit objEntity variables
event_inherited();

bulletSpeed = 18;

angle = 0;

initialXScale = 1;
initialYScale = 1;
scaleIncreaseRateX = 0.4;
scaleIncreaseRateY = 0.4;

currentXScale = initialXScale;
currentYScale = initialYScale;


instance_create_layer(x,y,"instances",obj_part2_GunSmoke);

fading = 1;
image_alpha = 1;

