package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

import behaviors.ability.Invulnerable;

import Globals.*;

/**
  * The game player's avatar.
  */
class PlayerCharacter extends Actor<behaviors.PlayerCharacterBehavior>
{
    var _config:Dynamic;

    public var name(get, never):String;

    var _invulnerable:Invulnerable;
    var _abilities:Array<behaviors.PlayerCharacterAbility>;

    var _movingLeft:Bool = false;
    var _movingRight:Bool = false;
    var _jumping:Bool = false;

    public function new(configName:String=null)
    {
        super("behaviors.player_character.");

        if (configName != null) {
            initFromConfig(configName);
        }

        _invulnerable = new Invulnerable(this, {
            "cooldown": 0.5,
            "duration": 0.5
        });
    }

    override public function destroy() : Void
    {
        _invulnerable.destroy();
        _invulnerable = null;

        for (ability in _abilities) {
            ability.destroy();
        }

        super.destroy();
    }

    public function initFromConfig(configName:String) : Void
    {
        _config = ConfigManager.load(PLAYER_CHARACTER_BASE_PATH + configName);

        // Image
        loadGraphic(IMAGE_BASE_PATH + _config.image.name, true, _config.image.size[0], _config.image.size[1]);
        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);

        // Animations
        var animationList:Array<Dynamic> = _config.animations;

        for (animationConfig in animationList) {
            animation.add(animationConfig.name, animationConfig.frames, animationConfig.speed);
        }

        // Collision
        width = _config.collision.size[0];
        height = _config.collision.size[1];
        offset.x = _config.collision.offset[0];
        offset.y = _config.collision.offset[1];

        // Physics
        acceleration.x = 0;
        acceleration.y = _config.physics.gravity;

        // Behaviors
        var behaviorList:Array<Dynamic> = _config.behaviors;

        for (behaviorConfig in behaviorList) {
            addBehavior(behaviorConfig.name, behaviorConfig.config);
        }

        // Abilities
        _abilities = new Array<behaviors.PlayerCharacterAbility>();
        var abilityList:Array<Dynamic> = _config.abilities;

        for (abilityConfig in abilityList) {
            var cls = Globals.getClass("behaviors.ability.", abilityConfig.name);
            var ability = Type.createInstance(cls, [this, abilityConfig.config]);
            _abilities.push(ability);
        }

        // TEMP
        x = 20;
        y = 30;
    }

    override public function update() : Void
    {
        // Movement
        velocity.x = 0;

        if (_movingLeft) {
            facing = FlxObject.LEFT;
            velocity.x = -_config.physics.moveVelocity;

            _movingLeft = false;
        }

        if (_movingRight) {
            facing = FlxObject.RIGHT;
            velocity.x = _config.physics.moveVelocity;

            _movingRight = false;
        }

        if (_jumping && isTouching(FlxObject.FLOOR)) {
                
            SoundManager.play('jump.wav');
            velocity.y = -_config.physics.jumpVelocity;
        }
            
        _jumping = false;

        // Animations
        if (velocity.y < 0) {
            animation.play("jump");
        }
        else if (velocity.y > 0) {
            animation.play("fall");
        }
        else if (velocity.x != 0) {
            animation.play("run");
        } else {
            animation.play("idle");
        }

        _invulnerable.update();

        for (ability in _abilities) {
            ability.update();
        }

        super.update();
    }

    public function moveLeft() : Void
    {
        _movingLeft = true;
    }

    public function moveRight() : Void
    {
        _movingRight = true;
    }

    public function jump() : Void
    {
        _jumping = true;
    }

    public function useAbility(id:Int) : Void
    {
        _abilities[id].use();
    }

    /**
      * Hurt this player. Public interface for attacks.
      *
      * NB: Player death is handled in GameState.
      */
    override public function hurt(damage:Float) : Void
    {
        if (_invulnerable.isActive()) {
            return;
        }
            
        SoundManager.play('hit-hurt.wav');

        Globals.getGameState().addTerror(damage);

        _invulnerable.use();
    }

    /**
      * Heal this player.
      */
    public function heal(healing:Float) : Void
    {
        Globals.getGameState().removeTerror(healing);
    }

    private function get_name() : String {
        return _config == null ? null : _config.name;
    }

    public function getAbilities() : Array<behaviors.PlayerCharacterAbility>
    {
        return _abilities;
    }
}
