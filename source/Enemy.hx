package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

import Globals.*;

/**
  * An in-game enemy.
  */
class Enemy extends Actor<behaviors.EnemyBehavior> 
{
    var _config:Dynamic;

    public var name(get, never):String;
    public var spawnTerror(get, never):Int;
    
    public function new(configName:String=null)
    {
        super("behaviors.enemy.");

        if (configName != null) {
            initFromConfig(configName);
        }
    }

    public function initFromConfig(configName:String) : Void
    {
        _config = ConfigManager.load(ENEMY_BASE_PATH + configName);

        // Image
        loadGraphic(IMAGE_BASE_PATH + _config.image.name, true, _config.image.size[0], _config.image.size[1]);
        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);

        // Animations
        var animationList:Array<Dynamic> = _config.animations;

        for (animationConfig in animationList) {
            animation.add(animationConfig.name, animationConfig.frames);
        }

        // Collision
        width = _config.collision.size[0];
        height = _config.collision.size[1];
        offset.x = _config.collision.offset[0];
        offset.y = _config.collision.offset[1];

        // Physics
        acceleration.x = 0;
        acceleration.y = _config.physics.gravity;

        // Behaviors
        var behaviorList:Array<Dynamic> = _config.behaviors;

        for (behaviorConfig in behaviorList) {
            addBehavior(behaviorConfig.name, behaviorConfig.config);
        }

        // Gameplay
        health = _config.fullHealth;
    }

    /**
      * Hurt this enemy. Public interface for attacks.
      */
    override public function hurt(hp:Float) : Void
    {
        health = Math.max(health - hp, 0);

        if (health == 0) {
            kill();
        }
    }

    /**
      * Heal this enemy.
      */
    public function heal(hp:Float) : Void
    {
        health = Math.min(health + hp, _config.fullHealth);
    }

    /**
      * When enemy dies, remove some terror.
      */
    override public function kill() : Void
    {
        super.kill();

        Globals.getGameState().removeTerror(spawnTerror);
    }

    private function get_name() : String
    {
        return _config == null ? null : _config.name;
    }

    private function get_spawnTerror() : Int
    {
        return _config == null ? null : _config.spawnTerror;
    }
}
