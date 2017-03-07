breathingAmplitudeY = lerp(breathingAmplitudeY, breathingAmplitudeYIdle,0.05);
breathingRate = lerp(breathingRate, breathingRateIdle,0.03);

drawing_scale +=  breathingAmplitudeY * sin(degtorad(breathingSinAngle));

breathingSinAngle += breathingRate;
if (breathingSinAngle > 360)
{
	breathingSinAngle -= 360;
}

drawing_scale = lerp(drawing_scale,1,squishRate);