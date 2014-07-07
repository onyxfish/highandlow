package behaviors.prop;

/**
  * Heal the player.
  */
class HealPlayer extends PropBehavior
{
    public function new(prop:Prop, config:Dynamic)
    {
        super(prop, config);
    }

    override public function onOverlapPlayer(player:PlayerCharacter) : Prop 
    {
        var prop = super.onOverlapPlayer(player);

        player.heal(_config.healing);

        return prop;
    }
}
