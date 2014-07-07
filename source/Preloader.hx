package;

import flixel.system.FlxPreloader;

/**
  * Subclass of the default Flixel preloader.
  */
class Preloader extends FlxPreloader
{
    public function new()
    {
        super()

        minDisplayTime = 0;
    }
}
