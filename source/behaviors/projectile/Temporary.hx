package behaviors.projectile;

import flixel.util.FlxTimer;

/**
  * Disappears after some time.
  */
class Temporary extends ProjectileBehavior
{
    public function new(projectile:Projectile, config:Dynamic)
    {
        super(projectile, config);

        new FlxTimer().start(config.duration, onExpired);
    }

    private function onExpired(timer:FlxTimer) : Void 
    {
        _actor.kill();
    }
}
