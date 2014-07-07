package;

import exceptions.NotImplemented;

/**
  * Abstract class representing a behavior of an Actor.
  */
class Behavior
{
    var _actor:Dynamic;
    var _config:Dynamic;

    private function new(actor:Dynamic, config:Dynamic)
    {
        _actor = actor;
        _config = config;
    }

    public function destroy() : Void
    {
        _actor = null;
        _config = null;
    }

    /**
      * Process action.
      *
      * Subclasses should override to return correct type.
      */
    public function update() : Dynamic 
    {
        return _actor;
    }

    /**
      * Response to actor colliding with level.
      *
      * Subclasses should override to return correct type.
      */
    public function onOverlapLevel(level:Level) : Dynamic
    {
        throw new NotImplemented(this, "onOverlapLevel");

        return null;
    }

    /**
      * Response to actor colliding with player.
      *
      * Subclasses should override to return correct type.
      */
    public function onOverlapPlayer(player:PlayerCharacter) : Dynamic
    {
        throw new NotImplemented(this, "onOverlapPlayer");

        return null;
    }

    /**
      * Response to actor colliding with enemy.
      *
      * Subclasses should override to return correct type.
      */
    public function onOverlapEnemy(enemy:Enemy) : Dynamic
    {
        throw new NotImplemented(this, "onOverlapEnemy");

        return null;
    }

    /**
      * Response to actor colliding with projectile.
      *
      * Subclasses should override to return correct type.
      */
    public function onOverlapProjectile(projectile:Projectile) : Dynamic
    {
        throw new NotImplemented(this, "onOverlapProjectile");

        return null;
    }

    /**
      * Response to actor colliding with prop.
      *
      * Subclasses should override to return correct type.
      */
    public function onOverlapProp(prop:Prop) : Dynamic
    {
        throw new NotImplemented(this, "onOverlapProp");

        return null;
    }
}
