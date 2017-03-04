/// Initialise mining behaviour

move_snap(32,32);

show_debug_message("Miner created at x: " + string(x) + " y: " + string(y));

///THESE ARE THE SHIZ YOU CAN EDIT MIKEY BOY
maximumNumberOfMoves = 100;
minimumNumberOfMoves = 30;
likelyhoodHorizontal = 2;
likelyhoodVertical = 1;

//DON'T FUCK WITH THIS SHIZ UNLESS YOU REALLY REALLY WANNA
numberOfMoves = round(minimumNumberOfMoves+random(maximumNumberOfMoves-minimumNumberOfMoves));
show_debug_message("Miner number of moves is " + string(numberOfMoves));