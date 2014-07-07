package;

import haxe.Json;

import flixel.FlxObject;
import openfl.Assets;

/**
  * Handles loading and caching JSON configuration.
  */
class ConfigManager
{
    static var _cache:Map<String, Dynamic>;

    static public function init()
    {
        _cache = new Map<String, Dynamic>();
    }

    static public function load(path):Dynamic
    {
        var fromCache:Dynamic = _cache.get(path);

        if (fromCache != null) {
            Globals.debug('Loading config from cache: ' + path);
            return fromCache;
        }

        Globals.debug('Loading config from disk: ' + path);

        var text:String = Assets.getText(path);
        var config:Dynamic = Json.parse(text);

        _cache.set(path, config);

        return config;
    }

    static public function parseFacing(facing:String) : Int
    {
        switch (facing) {
            case "up":
                return FlxObject.UP;
            case "down":
                return FlxObject.DOWN;
            case "left":
                return FlxObject.LEFT;
            case "right":
                return FlxObject.RIGHT;
            default:
                throw new exceptions.InvalidConfiguration("Unknown facing direction: " + facing);
        }

    }
}
