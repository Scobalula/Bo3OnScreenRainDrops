// -------------------------------------------------------------------------------
// On-Screen Raindrops for Black Ops III - Harry's Downfall Edition
// Copyright (c) 2022 Philip/Scobalula
// -------------------------------------------------------------------------------
// Licensed under the "Do whatever you want thx hun bun" license.
// -------------------------------------------------------------------------------
#using scripts\shared\callbacks_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;
#insert scripts\zm\_zm_postfx_rain_drops.gsh;

#namespace zm_postfx_rain_drops;

REGISTER_SYSTEM("zm_postfx_rain_drops", &__init__, undefined)

// Init
function __init__()
{
	// Variables
	level.zm_postfx_rain_drops_rain_triggers = GetEntArray(ZM_POSTFX_RAIN_DROPS_TRIGGER_NAME, "targetname");
	// Clientfields
	clientfield::register("toplayer", ZM_POSTFX_RAIN_DROPS_CF_NAME, VERSION_SHIP, 1, "int");
	// Callbacks
	callback::on_spawned(&on_player_spawned);
	// Threads
	array::thread_all(level.zm_postfx_rain_drops_rain_triggers, &rain_trigger_think);
}

// Toggles the rain drops.
function toggle_raindrops(b_enable)
{
	if(IsFunctionPtr(level.zm_postfx_rain_drops_on_toggle_callback))
		self [[level.zm_postfx_rain_drops_on_toggle_callback]](b_enable);

	self.rain_on_screen = b_enable;
	self clientfield::set_to_player(ZM_POSTFX_RAIN_DROPS_CF_NAME, b_enable);
}

// Init on Player Spawned
function on_player_spawned()
{
	// self == player
	self toggle_raindrops(ZM_POSTFX_RAIN_DROPS_DEFAULT_STATE);
}

// Runs rain trigger logic.
function rain_trigger_think()
{
	// self == trigger_multiple
	self endon("death");

	for(;;)
	{
		self waittill("trigger", e_who);

		if(IsPlayer(e_who))
			e_who thread rain_trigger_toggle(self);
	}
}

// Runs rain trigger on enter and exit.
function rain_trigger_toggle(e_trigger)
{
	// self == player
	self notify("enter_rain_trigger");
	self endon("disconnect");
	self endon("enter_rain_trigger");

	if(IsFunctionPtr(level.zm_postfx_rain_drops_on_enter_trigger_callback))
		self [[level.zm_postfx_rain_drops_on_enter_trigger_callback]](e_trigger);

	self toggle_raindrops(!ZM_POSTFX_RAIN_DROPS_DEFAULT_STATE);
	util::wait_till_not_touching(e_trigger, self);
	self toggle_raindrops(ZM_POSTFX_RAIN_DROPS_DEFAULT_STATE);

	if(IsFunctionPtr(level.zm_postfx_rain_drops_on_exit_trigger_callback))
		self [[level.zm_postfx_rain_drops_on_exit_trigger_callback]](e_trigger);

	self notify("exit_rain_trigger");
}