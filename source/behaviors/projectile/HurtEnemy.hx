package behaviors.projectile;

/**
  * Hurt the enemies.
  */
class HurtEnemy extends ProjectileBehavior
{
    public function new(projectile:Projectile, config:Dynamic)
    {
        super(projectile, config);
    }

    override public function onOverlapEnemy(enemy:Enemy) : Projectile 
    {
        var projectile = super.onOverlapEnemy(enemy);

        enemy.hurt(_config.damage);

        return projectile;
    }
}
