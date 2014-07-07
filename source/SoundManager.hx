package;

import flash.media.Sound;
import flixel.FlxG;
import flixel.system.FlxSound;
import openfl.Assets;

import Globals.*;

/**
  * Singleton to load and play sounds.
  */
class SoundManager
{
    static var _cache:Map<String, FlxSound>;

    static public function init()
    {
        _cache = new Map<String, FlxSound>();
    }

    static public function load(path) : FlxSound
    {
        var fromCache:FlxSound = _cache.get(path);

        if (fromCache != null) {
            return fromCache;
        }

        var sound = FlxG.sound.load(SOUND_BASE_PATH + path);

        _cache.set(path, sound);

        return sound;
    }

    static public function play(path) : Void
    {
        var sound:FlxSound = load(path);

        sound.play();
    }
}
