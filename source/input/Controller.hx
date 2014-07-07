package input;

import input.IKeyLike;

/**
  * An interface defining a controller.
  */
class Controller
{
    public var attack(default, null):IKeyLike;
    public var altAttack(default, null):IKeyLike;
    public var pause(default, null):IKeyLike;

    public var up(default, null):IKeyLike;
    public var down(default, null):IKeyLike;
    public var left(default, null):IKeyLike;
    public var right(default, null):IKeyLike;

    public var select(default, null):IKeyLike;
}
