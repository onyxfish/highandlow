package input;

/**
  * An interface defining a key-like input device.
  */
interface IKeyLike
{
    public function justPressed() : Bool;
    public function justReleased() : Bool;
    public function pressed() : Bool;
}
