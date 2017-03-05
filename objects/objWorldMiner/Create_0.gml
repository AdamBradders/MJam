/// Initialise mining behaviour
move_snap(32,32);


///THESE ARE THE SHIZ YOU CAN EDIT MIKEY BOY
maximumNumberOfMoves = 80;
minimumNumberOfMoves = 20;
likelyhoodHorizontal = 1.4;
likelyhoodVertical = 1;
likelyhoodBigTile = 0.1; //1 in 10

//DON'T FUCK WITH THIS SHIZ UNLESS YOU REALLY REALLY WANNA
numberOfMoves = round(minimumNumberOfMoves+random(maximumNumberOfMoves-minimumNumberOfMoves));

previousWasBigTile = false;
bigTile = false;