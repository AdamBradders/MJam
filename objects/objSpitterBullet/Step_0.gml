//currentXScale = lerp(currentXScale,1.5,scaleIncreaseRateX);
//currentYScale = lerp(currentYScale,0.3,scaleIncreaseRateY);

if (fading = 1)
{
image_alpha -= 0.005;
}
if (image_alpha <= 0)
{
instance_destroy();
}