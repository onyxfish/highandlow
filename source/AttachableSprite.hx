package;

import flixel.FlxObject;
import flixel.FlxSprite;

/**
  * A sprite that can be attached to another sprite.
  */
class AttachableSprite extends FlxSprite
{
    var _parent:FlxSprite = null;
    var _offsets:Dynamic = null;

    public function attach(parent:FlxSprite, offsets:Dynamic) {
        _parent = parent;
        _offsets = offsets;
    }

    public function detach() {
        _parent = null;
        _offsets = null;
    }

    override public function update() : Void
    {
        if (_parent != null) {
            x = _parent.x + _offsets.base[0];
            y = _parent.y + _offsets.base[1];

            if (_parent.facing == FlxObject.RIGHT) {
                x += _offsets.right[0];
                y += _offsets.right[1];
                facing = FlxObject.RIGHT;
            } else if (_parent.facing == FlxObject.LEFT) {
                x += _offsets.left[0];
                y += _offsets.left[1];
                facing = FlxObject.LEFT;
            } else if (_parent.facing == FlxObject.UP) {
                x += _offsets.up[0];
                y += _offsets.up[1];
                facing = FlxObject.UP;
            } else if (_parent.facing == FlxObject.DOWN) {
                x += _offsets.down[0];
                y += _offsets.down[1];
                facing = FlxObject.DOWN;
            }
        }

        super.update();
    }
}
