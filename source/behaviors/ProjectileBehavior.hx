package behaviors;

// All behaviors must be imported
import behaviors.projectile.BreakAgainstEnemy;
import behaviors.projectile.BreakAgainstLevel;
import behaviors.projectile.BreakAgainstPlayer;
import behaviors.projectile.BreakAgainstProp;
import behaviors.projectile.HurtEnemy;
import behaviors.projectile.HurtPlayer;
import behaviors.projectile.Temporary;

/**
  * Abstract implementation of an projectile behavior pattern.
  */
class ProjectileBehavior extends Behavior
{
    private function new(projectile:Projectile, config:Dynamic)
    {
        super(projectile, config);
    }

    private inline function castActor()
    {
        return cast(_actor, Projectile);
    }

    override public function update() : Projectile
    {
        return castActor();
    }

    override public function onOverlapLevel(level:Level) : Projectile
    {
        return castActor();
    }

    override public function onOverlapPlayer(player:PlayerCharacter) : Projectile
    {
        return castActor();
    }

    override public function onOverlapEnemy(enemy:Enemy) : Projectile
    {
        return castActor();
    }

    override public function onOverlapProp(prop:Prop) : Projectile
    {
        return castActor();
    }
}
