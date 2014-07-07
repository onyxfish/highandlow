package behaviors;

// All behaviors must be imported
import behaviors.prop.Breakable;
import behaviors.prop.DropLoot;
import behaviors.prop.HealPlayer;
import behaviors.prop.PlayerPickup;

/**
  * Abstract implementation of a prop behavior pattern.
  */
class PropBehavior extends Behavior
{
    private function new(prop:Prop, config:Dynamic)
    {
        super(prop, config);
    }

    private inline function castActor()
    {
        return cast(_actor, Prop);
    }

    override public function update() : Prop 
    {
        return castActor();
    }

    override public function onOverlapLevel(level:Level) : Prop
    {
        return castActor();
    }

    override public function onOverlapPlayer(player:PlayerCharacter) : Prop
    {
        return castActor();
    }

    override public function onOverlapProjectile(projectile:Projectile) : Prop
    {
        return castActor();
    }
}
