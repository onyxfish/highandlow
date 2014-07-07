package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

import Globals.*;

/**
  * A Prop that spawns enemies.
  */
class Spawner extends Prop 
{
    var _ready = true;
    var _spawnCount = 0;

    public var enemyConfigName:String;
    public var count:Int;
    public var cooldown:Float;
    public var enemyFacing:Int;

    public function new(configName:String=null)
    {
        super(configName);
    }

    override public function initFromConfig(configName:String) : Void
    {
        super.initFromConfig(configName);
    }

    override public function update() : Void
    {
        if (alive && _spawnCount >= count) {
            kill();
        } else if (_ready) {
            var enemy = Globals.getGameState().createEnemy(enemyConfigName);
            enemy.x = x;
            enemy.y = y;
            enemy.facing = enemyFacing;

            enemy = null;

            new FlxTimer().start(cooldown, onCooldownFinished, 1);

            _spawnCount += 1;
            _ready = false;
        }

        super.update();
    }

    private function onCooldownFinished(timer:FlxTimer) : Void
    {
        _ready = true;
    }

    public function isExhausted() : Bool
    {
        return (_spawnCount >= count);
    }
}
