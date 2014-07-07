package;

import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.Lib;
import flash.events.Event;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.plugin.TimerManager;

import Globals.*;

/**
  * The game itself. Our main() class.
  */
class Game extends FlxGame
{
	public function new()
	{
        // Setup screen
        var screenWidth:Int = Lib.current.stage.stageWidth;
        var screenHeight:Int = Lib.current.stage.stageHeight;

        var scale:Float = Math.min(screenWidth / GAME_WIDTH, screenHeight / GAME_HEIGHT);

        // Initialize
		super(GAME_WIDTH, GAME_HEIGHT, INITIAL_STATE, scale, FRAMERATE, FRAMERATE);
        
        // Singletons!
        ConfigManager.init();
        SaveManager.init();
        SoundManager.init();
        GameConfiguration.init();

        // Load fullscreen preference
        if (!SaveManager.settings.isFullscreen) {
            FlxG.stage.displayState = StageDisplayState.NORMAL;
        }

        // Center screen
        x = (screenWidth - (GAME_WIDTH * scale)) / 2;
        y = (screenHeight - (GAME_HEIGHT * scale)) / 2;

        // Plugins
        FlxG.plugins.add(new TimerManager());

        // No mouse
        FlxG.mouse.visible = false;
	}

    override public function update() : Void
    {
        if (FlxG.keys.justPressed.ESCAPE) {
            SaveManager.settings.save();
            Lib.exit();
        }

        if (FlxG.keys.pressed.ALT && FlxG.keys.justPressed.BACKSLASH) {
            if (FlxG.stage.displayState == StageDisplayState.NORMAL) {
                FlxG.stage.displayState = StageDisplayState.FULL_SCREEN;
                SaveManager.settings.isFullscreen = true;
            } else {
                FlxG.stage.displayState = StageDisplayState.NORMAL;
                SaveManager.settings.isFullscreen = false;
            }
            
        }

        super.update();
    }
}
