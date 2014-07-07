package behaviors.ability;

import flixel.FlxG;
import flixel.FlxObject;

class RangedAttack extends PlayerCharacterAbility
{
    public function new(player:PlayerCharacter, config:Dynamic)
    {
        super(player, config);
    }

    override public function destroy() : Void
    {
        super.destroy();
    }

    override public function use() : Void
    {
        if (!_ready) {
            return;
        }

        var player = castActor();

        var _missile = Globals.getGameState().createProjectile(_config.projectile);
        _missile.x = player.x;
        _missile.y = player.y + player.height / 4;

        if (player.facing == FlxObject.RIGHT) {
            _missile.x += player.width;
            _missile.facing = FlxObject.RIGHT;
            _missile.velocity.x = _config.velocity[0];
        } else if (player.facing == FlxObject.LEFT) {
            _missile.x -= player.width;
            _missile.facing = FlxObject.LEFT;
            _missile.velocity.x = -_config.velocity[0];
        }
            
        _missile.velocity.y = _config.velocity[1];

        SoundManager.play('shoot-laser.wav');
        super.use();
    }
}
