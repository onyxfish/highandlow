package;

import flixel.FlxG;
import flixel.FlxSprite;

import Globals.*;

/**
  * A prop such as a health pickup or spikes.
  */
class Prop extends Actor<behaviors.PropBehavior> 
{
    var _config:Dynamic;

    public var name(get, never):String;
    
    public function new(configName:String=null)
    {
        super("behaviors.prop.");

        if (configName != null) {
            initFromConfig(configName);
        }
    }

    public function initFromConfig(configName:String) : Void
    {
        _config = ConfigManager.load(PROP_BASE_PATH + configName);

        // Image
        loadGraphic(IMAGE_BASE_PATH + _config.image.name, true, _config.image.size[0], _config.image.size[1]);

        // Animations
        var animationList:Array<Dynamic> = _config.animations;

        for (animationConfig in animationList) {
            animation.add(animationConfig.name, animationConfig.frames);
        }

        // Collision
        width = _config.collision.size[0];
        height = _config.collision.size[1];

        // Physics
        acceleration.x = 0;
        acceleration.y = _config.physics.gravity;

        // Behaviors
        var behaviorList:Array<Dynamic> = _config.behaviors;

        for (behaviorConfig in behaviorList) {
            addBehavior(behaviorConfig.name, behaviorConfig.config);
        }
    }

    private function get_name() : String
    {
        return _config == null ? null : _config.name;
    }

}
