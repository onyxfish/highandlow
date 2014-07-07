package behaviors.ability;

import flixel.FlxG;
import flixel.FlxObject;

class MeleeAttack extends PlayerCharacterAbility
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

        var projectile = Globals.getGameState().createProjectile(_config.projectile);
        projectile.attach(player, _config.offsets);
        projectile.update();
            
        SoundManager.play('shoot-laser.wav');
        super.use();
    }
}
