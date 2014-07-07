package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

import Globals.*;

/**
  * A projectile such as an arrow or magic missile.
  */
class Projectile extends Actor<behaviors.ProjectileBehavior>
{
    var _config:Dynamic;

    public function new(configName:String=null)
    {
        super("behaviors.projectile.");

        if (configName != null) {
            initFromConfig(configName);
        }
    }

    public function initFromConfig(configName:String) : Void
    {
        _config = ConfigManager.load(PROJECTILE_BASE_PATH + configName);

        // Image
        loadGraphic(IMAGE_BASE_PATH + _config.image.name, true, _config.image.size[0], _config.image.size[1]);
        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);

        // Animations
        var animationList:Array<Dynamic> = _config.animations;

        for (animationConfig in animationList) {
            animation.add(animationConfig.name, animationConfig.frames, animationConfig.speed);
        }

        animation.play(animationList[0].name);

        // Collision
        width = _config.collision.size[0];
        height = _config.collision.size[1];

        // Physics
        acceleration.x = 0;
        acceleration.y = _config.physics.gravity;

        // Behaviors
        var behaviorList:Array<Dynamic> = _config.behaviors;
        clearBehaviors();

        for (behaviorConfig in behaviorList) {
            addBehavior(behaviorConfig.name, behaviorConfig.config);
        }
    }

    public function getName() : String
    {
        return _config == null ? null : _config.name;
    }
}
