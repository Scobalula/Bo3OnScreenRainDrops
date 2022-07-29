# 💧 Bo3 On-Screen Rain Drops 💧

This repo holds a port of the on-screen rain drops from Call of Duty: Black Ops III's mission "In Darkness" for Custom Zombies. This script allows you to add on-screen rain drops that can be toggled by triggers within the map allowing you add more immersion to maps with rain.

***NOTE: This script only provides on-screen rain drops and doesn't provide mechanisms for playing audio or FX, but does expose function pointers you can assign to add callbacks for when triggers are entered or when the player's CF is activated.***

# Installing

1. Head over to the [Releases](https://github.com/Scobalula/Bo3OnScreenRainDrops/releases) section and download the latest release.
2. Open the zip file and copy the contents into your Call of Duty: Black Ops III directory.
3. Open your map/mod's zone file and add the following items:
```
scriptparsetree,scripts/zm/_zm_postfx_rain_drops.gsc
scriptparsetree,scripts/zm/_zm_postfx_rain_drops.csc
material,generic_filter_blkstn_sprite_rain
```
4. Open your map/mod's gsc/csc file (for mods, the files you're using for injection) and add the following to where the using statements are:
```gsc
#using scripts\zm\_zm_postfx_rain_drops;
```

Finally, compile your map/mod to see the changes, if all went well and you've added some items, there should be some dropping with the zombies!

# Adding In-Door Triggers

In order for the script to disable rain drops when in-doors, we'll need to add triggers that surround in-door/in-cover areas of your map, to do this, open your `Entity Browser` (by default, its shortcut is `B`), and search for `trigger_multiple`, you'll want to place this around the areas of your map that are in-doors or in-cover.

Finally, you'll want to assign the targetname: `postfx_rain_trigger` to the triggers so that the script can identify them.

# Debugging Common Issues

* **Duplicate Assets**: While unlikely, you've installed assets that have the same names as mine, you'll have to resolve this yourself.
* **Rain Drops appe in-doors**: You haven't correctly added the triggers or you haven't compiled your map after adding the triggers.
* **Clientfield Mismatch**: You didn't add the using statement described in Step 4 to either your gsc or csc file meaning a clientfield was not registered in one or the other.

# Reporting Problems

Ultimately the script was made for my own purposes and released for the wider community to use. While I have battletested this script on both my own and stock maps to high rounds in developer mode, we're all human and so things may have bugs! If you run into issues feel free to open an issue, I am also open to anyone to improve the script by making a pull request! When working on your map always have `developer 2` on, as it helps to identify where problems are and it can also assist me in identifying possible problems and where they are within the script. Please also feel free to open an issue if you think there is a part of the instructions that is confusing, identifying confusing parts of the instructions helps me identify key areas I should focus in on or improve when writing documentation!

❤️ You can also join my Discord to report issues or get general help ❤️

[![Join my Discord](https://discordapp.com/api/guilds/719503756810649640/widget.png?style=banner2)](https://discord.gg/RyqyThu)

# Credits

If you use the script there is no requirement to credit me, focus on making your projects extra spicy. 🌶️

# Preview

![Example](preview/example.gif)