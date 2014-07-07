package behaviors.ability;

import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;

class Invulnerable extends PlayerCharacterAbility 
{
    var _active = false;

    public function new(player:PlayerCharacter, config:Dynamic)
    {
        super(player, config);
    }

    override public function use() : Void
    {
        FlxSpriteUtil.flicker(_actor, _config.duration, 0.1);

        new FlxTimer().start(_config.duration, onActiveFinished, 1); 

        _active = true;

        super.use();
    }

    private function onActiveFinished(timer:FlxTimer) : Void
    {
        _active = false;
    }

    public function isActive() : Bool
    {
        return _active;
    }
}
