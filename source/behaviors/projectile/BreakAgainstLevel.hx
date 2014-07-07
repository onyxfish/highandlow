package behaviors.projectile;

/**
  * Destroy on collision with the level.
  */
class BreakAgainstLevel extends ProjectileBehavior
{
    public function new(projectile:Projectile, config:Dynamic)
    {
        super(projectile, config);
    }

    override public function onOverlapLevel(level:Level) : Projectile 
    {
        var projectile = super.onOverlapLevel(level);

        projectile.kill();

        return projectile;
    }
}
