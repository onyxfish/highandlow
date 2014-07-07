package behaviors.enemy;

import flixel.FlxObject;

/**
  * Causes an enemy to walk around.
  */
class Walk extends EnemyBehavior
{
    public function new(enemy:Enemy, config:Dynamic)
    {
        super(enemy, config);
    }

    override public function update() : Enemy
    {
        var enemy = super.update();

        enemy.velocity.x = 0;

        if (enemy.velocity.y == 0) {
            if (enemy.facing == FlxObject.RIGHT) {
                enemy.velocity.x = _config.velocity;
            } else {
                enemy.velocity.x = -_config.velocity;
            }
        
            enemy.animation.play("run");
        }

        return enemy;
    }

    override public function onOverlapLevel(level:Level) : Enemy
    {
        var enemy = super.onOverlapLevel(level);

        if (enemy.velocity.y == 0) {
            if (enemy.isTouching(FlxObject.LEFT)) { 
                enemy.facing = FlxObject.RIGHT;
            } else if (enemy.isTouching(FlxObject.RIGHT)) {
                enemy.facing = FlxObject.LEFT;
            }
        }

        return enemy;
    }

    override public function onOverlapPlayer(player:PlayerCharacter) : Enemy
    {
        var enemy = super.onOverlapPlayer(player);

        return enemy;
    }
}
