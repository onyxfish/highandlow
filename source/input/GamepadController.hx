package input;

import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;

import exceptions.NotImplemented;
import input.Controller;
import input.IKeyLike;

/**
  * A single player's gamepad controls.
  */
class GamepadController extends Controller
{
    var _gamepad:FlxGamepad;

    public function new (gamepad:Int, attackButton:Int, altAttackButton:Int, pauseButton:Int, upButton:Int, downButton:Int, leftButton:Int, rightButton:Int)
    {
        _gamepad = FlxG.gamepads.getByID(gamepad);

        attack = new Button(_gamepad, attackButton);
        altAttack = new Button(_gamepad, altAttackButton);
        pause = new Button(_gamepad, pauseButton);
        
        up = new Button(_gamepad, upButton);
        down = new Button(_gamepad, downButton);
        left = new Button(_gamepad, leftButton);
        right = new Button(_gamepad, rightButton);

        select = new MultiButton(_gamepad, [pauseButton, attackButton]);

        /*up = new Axis(_gamepad, yAxis, false);
        down = new Axis(_gamepad, yAxis, true);
        left = new Axis(_gamepad, xAxis, true);
        right = new Axis(_gamepad, xAxis, false);*/
    }
}

/**
  * Wrapper class for elegant button access.
  */
class Button implements IKeyLike 
{
    var _gamepad:FlxGamepad;
    var _button:Int;

    public function new(gamepad:FlxGamepad, button:Int)
    {
        _gamepad = gamepad;
        _button = button;
    }

    public function justPressed() : Bool
    {
        return _gamepad.justPressed(_button);
    }

    public function justReleased() : Bool
    {
        return _gamepad.justReleased(_button);
    }

    public function pressed() : Bool
    {
        return _gamepad.pressed(_button);
    }
}

/**
  * Class that allows an action to be performed by any one of multiple buttons.
  */
class MultiButton implements IKeyLike
{
    var _gamepad:FlxGamepad;
    var _buttons:Array<Int>;

    public function new(gamepad:FlxGamepad, buttons:Array<Int>)
    {
        _gamepad = gamepad;
        _buttons = buttons;
    }

    public function justPressed() : Bool
    {
        for (button in _buttons) {
            if (_gamepad.justPressed(button)) {
                return true;
            }
        }

        return false;
    }

    public function justReleased() : Bool
    {
        for (button in _buttons) {
            if (_gamepad.justReleased(button)) {
                return true;
            }
        }

        return false;
    }

    public function pressed() : Bool
    {
        for (button in _buttons) {
            if (_gamepad.pressed(button)) {
                return true;
            }
        }

        return false;
    }

}

/**
  * Wrapper class for elegant joystick axis access.
  */
class Axis implements IKeyLike
{
    var _gamepad:FlxGamepad;
    var _axis:Int;
    var _negative:Bool;

    public function new(gamepad:FlxGamepad, axis:Int, negative:Bool)
    {
        _gamepad = gamepad;
        _axis = axis;
        _negative = negative;
    }

    public function justPressed() : Bool
    {
        throw new NotImplemented(this, "justPressed");

        return false;
    }

    public function justReleased() : Bool
    {
        throw new NotImplemented(this, "justReleased");

        return false;
    }

    public function pressed() : Bool
    {
        if (_negative) {
            if (_gamepad.getAxis(_axis) < -_gamepad.deadZone) {
                return true;
            }
        } else {
            if (_gamepad.getAxis(_axis) > _gamepad.deadZone) {
                return true;
            }
        }

        return false;
    }
}
