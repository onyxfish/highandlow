package behaviors.projectile;

/**
  * Destroy on collision with the Prop.
  */
class BreakAgainstProp extends ProjectileBehavior
{
    public function new(projectile:Projectile, config:Dynamic)
    {
        super(projectile, config);
    }

    override public function onOverlapProp(prop:Prop) : Projectile 
    {
        var projectile = super.onOverlapProp(prop);

        projectile.kill();

        return projectile;
    }
}
