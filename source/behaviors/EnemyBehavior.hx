package behaviors;

// All behaviors must be imported
import behaviors.enemy.HurtOnContact;
import behaviors.enemy.ShootMissile;
import behaviors.enemy.Walk;

/**
  * Abstract implementation of an enemy behavior pattern.
  */
class EnemyBehavior extends Behavior
{
    private function new(enemy:Enemy, config:Dynamic)
    {
        super(enemy, config);
    }

    private inline function castActor()
    {
        return cast(_actor, Enemy);
    }

    override public function update() : Enemy
    {
        return castActor();
    }

    override public function onOverlapLevel(level:Level) : Enemy
    {
        return castActor();
    }

    override public function onOverlapPlayer(player:PlayerCharacter) : Enemy
    {
        return castActor();
    }
}
