package behaviors.prop;

/**
  * Break on attack.
  */
class Breakable extends PropBehavior
{
    public function new(prop:Prop, config:Dynamic)
    {
        super(prop, config);
    }

    override public function onOverlapPlayer(player:PlayerCharacter) : Prop
    {
        var prop = super.onOverlapPlayer(player);

        prop.kill();

        return prop;
    }
        
    override public function onOverlapProjectile(projectile:Projectile) : Prop
    {
        var prop = super.onOverlapProjectile(projectile);

        prop.kill();

        return prop;
    }
}
