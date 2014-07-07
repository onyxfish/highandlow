package behaviors.enemy;

/**
  * Damage the player whenever enemy overlaps them.
  */
class HurtOnContact extends EnemyBehavior
{
    public function new(enemy:Enemy, config:Dynamic)
    {
        super(enemy, config);
    }

    override public function onOverlapPlayer(player:PlayerCharacter) : Enemy
    {
        var enemy = super.onOverlapPlayer(player);

        player.hurt(_config.damage);

        return enemy;
    }
}
