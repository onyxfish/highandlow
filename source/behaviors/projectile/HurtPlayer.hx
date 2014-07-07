package behaviors.projectile;

/**
  * Hurt the player.
  */
class HurtPlayer extends ProjectileBehavior
{
    public function new(projectile:Projectile, config:Dynamic)
    {
        super(projectile, config);
    }

    override public function onOverlapPlayer(player:PlayerCharacter) : Projectile 
    {
        var projectile = super.onOverlapPlayer(player);

        player.hurt(_config.damage);

        return projectile;
    }
}
