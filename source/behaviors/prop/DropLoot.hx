package behaviors.prop;

/**
  * DropLoot when broken.
  */
class DropLoot extends PropBehavior
{
    public function new(prop:Prop, config:Dynamic)
    {
        super(prop, config);
    }

    override public function onOverlapPlayer(player:PlayerCharacter) : Prop 
    {
        var prop = super.onOverlapPlayer(player);

        dropLoot(prop);

        return prop;

    }

    override public function onOverlapProjectile(projectile:Projectile) : Prop 
    {
        var prop = super.onOverlapProjectile(projectile);

        dropLoot(prop);

        return prop;
    }

    private function dropLoot(prop:Prop) : Void
    {
        var newProp  = Globals.getGameState().createProp("health.json");
        newProp.x = prop.x;
        newProp.y = prop.y - 20;
    }
}
