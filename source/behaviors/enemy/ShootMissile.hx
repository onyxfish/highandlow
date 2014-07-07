package behaviors.enemy;

import flixel.FlxObject;
import flixel.util.FlxTimer;

/**
  * Shoot a missile in the direction of movement.
  */
class ShootMissile extends EnemyBehavior
{
    var _ready = true;

    public function new(enemy:Enemy, config:Dynamic)
    {
        super(enemy, config);
    }

    override public function update() : Enemy
    {
        var enemy = super.update();

        if (_ready) {
            var _missile:Projectile = Globals.getGameState().createProjectile(_config.projectile);
            _missile.x = enemy.x;
            _missile.y = enemy.y + enemy.height / 4;

            if (enemy.facing == FlxObject.RIGHT) {
                _missile.x += enemy.width / 2;
                _missile.facing = FlxObject.RIGHT;
                _missile.velocity.x = _config.velocity[0];
            } else if (enemy.facing == FlxObject.LEFT) {
                _missile.x -= enemy.width / 2;
                _missile.facing = FlxObject.LEFT;
                _missile.velocity.x = -_config.velocity[0];
            }

            _missile.velocity.y = _config.velocity[1];

            new FlxTimer().start(_config.cooldown, cooldownFinished, 1);

            _ready = false;
        }

        return enemy;
    }

    private function cooldownFinished(timer:FlxTimer) : Void
    {
        _ready = true;
    }
}
