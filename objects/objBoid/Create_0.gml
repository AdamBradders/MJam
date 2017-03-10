event_inherited();

ds_list_add(global.portalPolice,id);

bounceOnContact = true;
bounceCoeff = 0.8;

//In test these are good values but a bit fast
//accel = 0.325; // acceleration
//accelCanSee = accel;//1.25; // acceleration
//spread = 0.225;//1.3175; // force applied to seperate boids
//wallSpread = 15; // force applied to seperate from walls
//maxSpd = 5; // max speed
//maxSpdCanSee = maxSpd; // max speed
//imageTurnSpd = 0.4; // image turning speed (between 0-1)


// Settings
accel = 0.15075; // acceleration
accelCanSee = accel;//1.25; // acceleration
spread = 1.45;//1.3175; // force applied to seperate boids
wallSpread = 7.5; // force applied to seperate from walls
maxSpd = 2.5; // max speed
maxSpdCanSee = maxSpd; // max speed
imageTurnSpd = 0.2; // image turning speed (between 0-1)

sightRange = 10 * 32;

