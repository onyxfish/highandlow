package behaviors.projectile;

/**
  * Destroy on collision with the enemy.
  */
class BreakAgainstEnemy extends ProjectileBehavior
{
    public function new(projectile:Projectile, config:Dynamic)
    {
        super(projectile, config);
    }

    override public function onOverlapEnemy(enemy:Enemy) : Projectile 
    {
        var projectile = super.onOverlapEnemy(enemy);
        
        projectile.kill();

        return projectile;
    }
}
