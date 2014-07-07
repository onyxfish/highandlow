package;

import flixel.FlxG;

/**
  * Global immutable settings.
  */
class Globals
{
    // Paths
    static public inline var ASSETS_BASE_PATH:String = "assets/";
    static public inline var ENEMY_BASE_PATH:String = ASSETS_BASE_PATH + "enemies/";
    static public inline var IMAGE_BASE_PATH:String = ASSETS_BASE_PATH + "images/";
    static public inline var LEVEL_BASE_PATH:String = ASSETS_BASE_PATH + "levels/";
    static public inline var MAP_BASE_PATH:String = ASSETS_BASE_PATH + "maps/";
    static public inline var PLAYER_CHARACTER_BASE_PATH:String = ASSETS_BASE_PATH + "player_characters/";
    static public inline var PROJECTILE_BASE_PATH:String = ASSETS_BASE_PATH + "projectiles/";
    static public inline var PROP_BASE_PATH:String = ASSETS_BASE_PATH + "props/";
    static public inline var SOUND_BASE_PATH:String = ASSETS_BASE_PATH + "sounds/";
    static public inline var TILES_BASE_PATH:String = ASSETS_BASE_PATH + "images/";

    // Graphics
    static public inline var GAME_WIDTH:Int = 320;
    static public inline var GAME_HEIGHT:Int = 200;

    static public inline var TILE_WIDTH:Int = 5;
    static public inline var TILE_HEIGHT:Int = 5;

    static public inline var MAP_WIDTH:Int = 64;
    static public inline var MAP_HEIGHT:Int = 40;

    static public inline var FRAMERATE:Int = 60;

    // Game
    static public inline var INITIAL_STATE = MenuState;
    static public var PLAYER_CHARACTERS:Array<String> = ["hacker.json", "occultist.json", "wizard.json"];
    static public inline var NUM_SAVE_GAMES = 3;

    static public inline var ARCADE_MODE:Int = 0;
    static public inline var STORY_MODE:Int = 1;
    static public inline var MAX_TERROR:Int = 100;

    // Helpers
    static public inline function getGameState() : GameState
    {
        return cast(FlxG.state, GameState);
    }

    static public inline function getClass(classPath:String, name:String) : Class<Dynamic>
    {
        var className:String = classPath + name;
        var type:Class<Dynamic> = Type.resolveClass(className);

        return type;
    }

    static public inline function debug(message:String) : Void
    {
        trace(message);
    }
}
