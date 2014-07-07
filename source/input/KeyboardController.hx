package input;

import flixel.FlxG;

import input.Controller;
import input.IKeyLike;

/**
  * A single player's keyboard controls.
  */
class KeyboardController extends Controller
{
    public function new (attackKey:String, altAttackKey:String, pauseKey:String, upKey:String, downKey:String, leftKey:String, rightKey:String)
    {
        attack = new Key(attackKey);
        altAttack = new Key(altAttackKey);
        pause = new Key(pauseKey);

        up = new Key(upKey);
        down = new Key(downKey);
        left = new Key(leftKey);
        right = new Key(rightKey);

        select = new MultiKey([pauseKey, attackKey]);
    }
}

/**
  * Wrapper class for elegant key access.
  */
class Key implements IKeyLike
{
    var _key:String;

    public function new(key:String)
    {
        _key = key;
    }

    public function justPressed(): Bool
    {
        // TODO: cache key code references
        var code:Int = FlxG.keys.getKeyCode(_key);
        return FlxG.keys.justPressed.check(code);
    }

    public function justReleased() : Bool
    {
        var code:Int = FlxG.keys.getKeyCode(_key);
        return FlxG.keys.justReleased.check(code);
    }

    public function pressed() : Bool
    {
        var code:Int = FlxG.keys.getKeyCode(_key);
        return FlxG.keys.pressed.check(code); 
    }
}

/**
  * Wrapper class for elegant key access.
  */
class MultiKey implements IKeyLike
{
    var _keys:Array<String>;

    public function new(keys:Array<String>)
    {
        _keys = keys;
    }

    public function justPressed(): Bool
    {
        return FlxG.keys.anyJustPressed(_keys);
    }

    public function justReleased() : Bool
    {
        return FlxG.keys.anyJustReleased(_keys);
    }

    public function pressed() : Bool
    {
        return FlxG.keys.anyPressed(_keys);
    }
}
