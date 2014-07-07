package behaviors;

import flixel.util.FlxTimer;

// All behaviors must be imported
import behaviors.ability.Invulnerable;
import behaviors.ability.MeleeAttack;
import behaviors.ability.RangedAttack;

/**
  * Abstract implementation of a player character ability.
  *
  * Abilities differ from Behavior in that they have names, cooldowns and use() methods.
  */
class PlayerCharacterAbility extends PlayerCharacterBehavior 
{
    var _ready = true;
    var _timer:FlxTimer;

    public function use() : Void
    {
        _ready = false;
        _timer = new FlxTimer();
        _timer.start(_config.cooldown, onCooldownFinished, 1);
    }

    public function getName() : String 
    {
        return _config.name;
    }

    public function getTimeUntilReady() : Float
    {
        if (_timer == null) {
            return 0;
        }

        return _timer.timeLeft;
    }

    private function onCooldownFinished(timer:FlxTimer) : Void
    {
        _ready = true;
        _timer = null;
    }
}
