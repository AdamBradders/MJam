// Vertical
repeat(abs(vy)) {
    if (!place_meeting(x, y + sign(vy), objSolid))
        y += sign(vy); 
    else {
        instance_destroy(id);
        break;
    }
}

// Horizontal
repeat(abs(vx)) {
    if (!place_meeting(x + sign(vx), y, objSolid))
        x += sign(vx); 
    else {
        instance_destroy(id);
        break;
    }
}

wasOnGround = onGround;