//if (alarm[0] < 0)
{
	show_debug_message("WALL HIT MOFO");
	other.hp--;
	alarm[0] = wallDamageTime;
}