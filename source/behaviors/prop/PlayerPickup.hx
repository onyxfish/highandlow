package behaviors.prop;

/**
  * A prop that the player can collect.
  */
class PlayerPickup extends PropBehavior
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
}
