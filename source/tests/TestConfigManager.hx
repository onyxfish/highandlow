package tests;

import haxe.unit.TestCase;

import flixel.FlxObject;

class TestConfigManager extends haxe.unit.TestCase
{
    public function testParseFacing()
    {
        assertEquals(ConfigManager.parseFacing("up"), FlxObject.UP);
        assertEquals(ConfigManager.parseFacing("down"), FlxObject.DOWN);
        assertEquals(ConfigManager.parseFacing("left"), FlxObject.LEFT);
        assertEquals(ConfigManager.parseFacing("right"), FlxObject.RIGHT);

        try {
            ConfigManager.parseFacing("foo");
            assertFalse(true); // Should never reach this
        }
        catch(msg:String) {
        }
    }          
}
