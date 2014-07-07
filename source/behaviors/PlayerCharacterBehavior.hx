package behaviors;

// All behaviors must be imported
// TODO

/**
  * Abstract implementation of a player character behavior pattern (ability, etc).
  */
class PlayerCharacterBehavior extends Behavior
{
    private function new(player:PlayerCharacter, config:Dynamic)
    {
        super(player, config);
    }

    private inline function castActor()
    {
        return cast(_actor, PlayerCharacter);
    }

    override public function update() : PlayerCharacter
    {
        return castActor();
    }

    override public function onOverlapLevel(level:Level) : PlayerCharacter
    {
        return castActor();
    }
}
