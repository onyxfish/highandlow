package;

import flixel.FlxSprite;

/**
  * A game entity that has {@link Behavior}s.
  *
  * NB: Is the app crashing mysteriously after creating a new Behavior?
  * You need to import it in the relevant Behavior super-class file!
  * (EnemyBehavior, etc.)
  */
class Actor<T:Behavior> extends AttachableSprite
{
    var _classPath:String;

    var _behaviors:Array<T>;

    public function new(classPath:String)
    {
        super();
        
        _classPath = classPath;
        _behaviors = [];
    }

    public function createBehavior(cls:Class<Dynamic>, config:Dynamic) : T
    {
        var behavior:T = Type.createInstance(cls, [this, config]);

        return behavior;
    }

    public function addBehavior(name:String, config:Dynamic) : Void
    {
        var cls = Globals.getClass(_classPath, name);
        var behavior:T = createBehavior(cls, config);
        _behaviors.push(behavior);
    }

    public function clearBehaviors() : Void
    {
        for (behavior in _behaviors) {
            behavior.destroy();
        }

        _behaviors = [];
    }

    override public function destroy() : Void
    {
        for (behavior in _behaviors) {
            behavior.destroy();
        }
        
        _behaviors = null;
        
        super.destroy();
    }
    
    /**
      * Execute all related behaviors.
      */
    override public function update() : Void
    {
        for (behavior in _behaviors) {
            behavior.update();
        }
        
        super.update();
    }

    /**
      * Execute all behavior callbacks for level collision.
      */
    public function onOverlapLevel(level:Level) : Void
    {
        for (behavior in _behaviors) {
            behavior.onOverlapLevel(level);
        }
    }

    /**
      * Execute all behavior callbacks for player collision.
      */
    public function onOverlapPlayer(player:PlayerCharacter) : Void
    {
        for (behavior in _behaviors) {
            behavior.onOverlapPlayer(player);
        }
    }

    /**
      * Execute all behavior callbacks for enemy collision.
      */
    public function onOverlapEnemy(enemy:Enemy) : Void
    {
        for (behavior in _behaviors) {
            behavior.onOverlapEnemy(enemy);
        }
    }

    /**
      * Execute all behavior callbacks for projectile collision.
      */
    public function onOverlapProjectile(projectile:Projectile) : Void
    {
        for (behavior in _behaviors) {
            behavior.onOverlapProjectile(projectile);
        }
    }
    
    /**
      * Execute all behavior callbacks for prop collision.
      */
    public function onOverlapProp(prop:Prop) : Void
    {
        for (behavior in _behaviors) {
            behavior.onOverlapProp(prop);
        }
    }
}
