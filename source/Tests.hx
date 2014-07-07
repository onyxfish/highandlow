package;

import tests.*;

class Tests
{    
    static function main()
    {
        var runner = new haxe.unit.TestRunner();
        
        runner.add(new TestConfigManager());

        runner.run();
    }
}
