package;

import Globals.*;
import input.Controller;
import input.GamepadController;
import input.KeyboardController;

/**
  * Singleton holding game configuration that crosses states (game mode, etc.)
  */
class GameConfiguration
{
    static public var gameMode:Int = ARCADE_MODE;
    static public var numPlayers:Int = 1;
    static public var playerCharacters:Array<String>;
    static public var controllers:Array<Controller>;

    static public var numSpawners:Int = 3;
    static public var createSpawnerCooldown:Float = 3;
    static public var numEnemiesPerSpawner:Int = 5;
    static public var spawnEnemyCooldown:Float = 3;
    static public var enemyType:String = "troll.json";

    static public function init() : Void
    {
        playerCharacters = new Array<String>();
        playerCharacters.push("hacker.json");
        playerCharacters.push("occultist.json");

        controllers = new Array<Controller>();
        //controllers.push(new GamepadController(0, 13, 12, 4, 11, 0, 1, 2, 3));
        controllers.push(new KeyboardController("A", "S", "ENTER", "UP", "DOWN", "LEFT", "RIGHT"));
        //controllers.push(new KeyboardController("Q", "W", "E", "R", "T", "Y", "U", "I"));
    }
}
