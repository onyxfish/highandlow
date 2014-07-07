package behaviors.projectile;

/**
  * Destroy on collision with the player.
  */
class BreakAgainstPlayer extends ProjectileBehavior
{
    public function new(projectile:Projectile, config:Dynamic)
    {
        super(projectile, config);
    }

    override public function onOverlapPlayer(player:PlayerCharacter) : Projectile 
    {
        var projectile = super.onOverlapPlayer(player);

        projectile.kill();

        return projectile;
    }
}
