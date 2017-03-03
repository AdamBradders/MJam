// Vertical
repeat(abs(vy)) {
    if (!place_meeting(x, y + sign(vy), objSolid))
        y += sign(vy); 
    else {
        vy = 0;
        break;
    }
}

// Horizontal
repeat(abs(vx)) {
    if (!place_meeting(x + sign(vx), y, objSolid))
        x += sign(vx); 
    else {
        vx = 0;
        break;
    }
}
