package;

import haxe.Json;
import sys.io.File;
import sys.io.FileOutput;

import flixel.util.FlxSave;
//import json.JSON;

import Globals.*;

/**
  * Singleton for managing settings and game saves.
  */
class SaveManager
{
    static public var settings:Settings;
    static public var currentGame:SaveGame;

    static var _gameSaves:Array<SaveGame>;

    static public function init() : Void
    {
        settings = new Settings();

        _gameSaves = new Array<SaveGame>();

        var i = 0;

        while (i < NUM_SAVE_GAMES) {
            _gameSaves.push(new SaveGame('save' + i + '.json'));

            i += 1;
        }

        currentGame = _gameSaves[0];
    }
}

/**
  * Save and load settings to a file.
  */
class Settings extends Save
{
    public var isFullscreen:Bool;

    public function new()
    {
        isFullscreen = true;

        super("settings.json");
    }

    override private function toDynamic() : Dynamic
    {
        return {
            "isFullscreen": isFullscreen
        };
    }

    override private function fromDynamic(data:Dynamic) : Void
    {
        isFullscreen = data.isFullscreen;
    }
}

/**
  * Save and load game status to a file.
  */
class SaveGame extends Save
{
    public var level:Int;

    public function new(filename:String)
    {
        level = 1;

        super(filename);
    }

    override private function toDynamic() : Dynamic
    {
        return {
            "level": level
        };
    }

    override private function fromDynamic(data:Dynamic) : Void
    {
        level = data.level;
    }
}

class Save
{
    var _filename:String;

    public function new(filename:String)
    {
        _filename = filename;

        load();
    }

    /**
      * Stash values in a Dynamic for serialization.
      */
    private function toDynamic() : Dynamic
    {
        return {};
    }

    /**
      * Extract values from a deserialized Dynamic.
      */
    private function fromDynamic(data:Dynamic) : Void
    {
    }

    /**
      * Load data from disk.
      */
    private function load() : Void
    {
        var json:String = null;

        try {
            json = File.getContent(_filename); 
        } catch(e:Dynamic) {
            // No file, just use defaults
            return;
        }

        var data:Dynamic = Json.parse(json);

        fromDynamic(data);
    }

    /**
      * Save data to disk.
      */
    public function save() : Void
    {
        var data:Dynamic = toDynamic(); 
        var json:String = Json.stringify(data);

        var output:FileOutput = File.write(_filename);
        
        output.writeString(json);
        output.close();
    }
}
