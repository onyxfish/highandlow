package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import openfl.Assets;

import Globals.*;

/**
  * Game state when in play.
  */
class GameState extends FlxState
{
    var _hud:GameHUD;

    var _level:Level;
    var _players:FlxTypedGroup<PlayerCharacter>;
    var _enemies:FlxTypedGroup<Enemy>;
    var _props:FlxTypedGroup<Prop>;
    var _projectiles:FlxTypedGroup<Projectile>;
    var _spawners:FlxTypedGroup<Spawner>;
    var _numSpawnersCreated:Int = 0;

    public var terror(default, null):Float;

    var _paused:Paused;
    var _levelWon:LevelWon;
    var _levelLost:LevelLost;

    private function new() : Void
    {
        super();
    }

	override public function create() : Void
	{
        FlxG.cameras.bgColor = 0xff222222;

        _level = new Level();
        add(_level);

        _props = new FlxTypedGroup<Prop>();
        add(_props);

        _spawners = new FlxTypedGroup<Spawner>();
        add(_spawners);

        _enemies = new FlxTypedGroup<Enemy>();
        add(_enemies);

        _players = new FlxTypedGroup<PlayerCharacter>();
        add(_players);

        _projectiles = new FlxTypedGroup<Projectile>();
        add(_projectiles);

        _paused = new Paused();
        _levelWon = new LevelWon();
        _levelWon.closeCallback = onLevelWon;
        _levelLost = new LevelLost();
        _levelLost.closeCallback = onLevelLost;

        loadLevel("one.json");

        super.create();
	}

	override public function destroy() : Void
	{
        // Automatically destroyed in super()
        _level = null;
        _hud = null;

        // Destroy groups 
        _players.destroy();
        _players = null;

        _enemies.destroy();
        _enemies = null;

        _props.destroy();
        _props = null;

        _projectiles.destroy();
        _projectiles = null;

        _spawners.destroy();
        _spawners = null;

        // Destroy sub-states
        _paused.destroy();
        _paused = null;

        _levelWon.destroy();
        _levelWon = null;

        _levelLost.destroy();
        _levelLost = null;

		super.destroy();
	}

	override public function update() : Void
    {
        // Player controls
        for (i in 0...GameConfiguration.numPlayers) {
            var player = _players.members[i];

            // Is player dead?           
            if (!player.alive) {
                continue;
            }

            var controller = GameConfiguration.controllers[i];

            if (controller.pause.justPressed()) {
                _paused.pausingPlayer = i;
                openSubState(_paused);
            }

            if (controller.attack.justPressed()) {
                player.useAbility(0);
            }

            if (controller.altAttack.justPressed()) {
                player.useAbility(1);
            }

            if (controller.up.justPressed()) {
                player.jump();
            }

            if (controller.left.pressed()) {
                player.moveLeft();
            } else if (controller.right.pressed()) {
                player.moveRight();
            }
        }

        // Process collision
        FlxG.overlap(_players, _level, onPlayerOverlapsLevel, FlxObject.separate);
        FlxG.overlap(_players, _enemies, onPlayerOverlapsEnemy);
        FlxG.overlap(_players, _projectiles, onPlayerOverlapsProjectile);
        FlxG.overlap(_players, _props, onPlayerOverlapsProp);
        FlxG.overlap(_enemies, _level, onEnemyOverlapsLevel, FlxObject.separate);
        FlxG.overlap(_enemies, _projectiles, onEnemyOverlapsProjectile);
        FlxG.overlap(_projectiles, _level, onProjectileOverlapsLevel, FlxObject.separate);
        FlxG.overlap(_projectiles, _props, onProjectileOverlapsProp);

        // Game over?
        if (_enemies.countLiving() == 0 && _numSpawnersCreated >= GameConfiguration.numSpawners) {
            var done = true;

            for (spawner in _spawners.members) {
                done = done && spawner.isExhausted(); 
            }

            if (done) {
                openSubState(_levelWon);
            }
        }

        // Update UI with latest
        _hud.update();

        super.update();
	}

    private function loadLevel(configName:String) : Void
    {
        for (player in _players.members) {
            player.destroy();
        }

        _players.clear();

        for (i in 0...GameConfiguration.numPlayers) {
            _players.add(new PlayerCharacter(GameConfiguration.playerCharacters[i]));
        }

        terror = 0;

        if (_hud != null) {
            remove(_hud);
            _hud.destroy();
            _hud = null;
        }

        _hud = new GameHUD(this);
        add(_hud);

        for (enemy in _enemies.members) {
            enemy.destroy();
        }

        _enemies.clear();

        for (prop in _props.members) {
            prop.destroy();
        }

        _props.clear();

        for (spawner in _spawners.members) {
            spawner.destroy();
        }

        _spawners.clear();
        _numSpawnersCreated = 0;
        
        _level.initFromConfig(configName);
        
        _level.createProps(this);

        new FlxTimer().start(GameConfiguration.createSpawnerCooldown, createSpawner, GameConfiguration.numSpawners);
    }

    private function createSpawner(timer:FlxTimer) : Void
    {
        var spawner = _spawners.recycle(Spawner);
        var spawnPoint = _level.spawnPoints[_numSpawnersCreated];

        spawner.enemyConfigName = GameConfiguration.enemyType;
        spawner.count = GameConfiguration.numEnemiesPerSpawner;
        spawner.cooldown = GameConfiguration.spawnEnemyCooldown;

        spawner.x = spawnPoint[0];
        spawner.y = spawnPoint[1];
        
        if (spawner.x >= GAME_WIDTH / 2) {
            spawner.enemyFacing = FlxObject.LEFT;
        } else {
            spawner.enemyFacing = FlxObject.RIGHT;
        }

        spawner.revive();

        _numSpawnersCreated += 1;
    }
    
    private function onLevelWon() : Void
    {
        var nextLevel:String = _level.nextLevel;

        if (nextLevel != null) {
            loadLevel(nextLevel);
        } else {
            gameWon();
        }
    }

    private function onLevelLost() : Void
    {
        FlxG.switchState(new MenuState());
    }

    private function gameWon() : Void
    {
        FlxG.switchState(new MenuState());
    }

    private function onPlayerOverlapsLevel(player:PlayerCharacter, level:Level) : Void
    {
        //player.onOverlapLevel(level);
        //level.onOverlapPlayer(player);
        FlxObject.separate(player, level);
    }

    private function onPlayerOverlapsEnemy(player:PlayerCharacter, enemy:Enemy) : Void
    {
        //player.onOverlapEnemy(enemy);
        enemy.onOverlapPlayer(player);
    }

    private function onPlayerOverlapsProjectile(player:PlayerCharacter, projectile:Projectile) : Void
    {
        //player.onOverlapProjectile(projectile);
        projectile.onOverlapPlayer(player);
    }

    private function onPlayerOverlapsProp(player:PlayerCharacter, prop:Prop) : Void
    {
        //player.onOverlapProp(prop);
        prop.onOverlapPlayer(player);
    }

    private function onEnemyOverlapsLevel(enemy:Enemy, level:Level) : Void
    {
        enemy.onOverlapLevel(level);
        //level.onOverlapEnemy(enemy);
    }

    private function onEnemyOverlapsProjectile(enemy:Enemy, projectile:Projectile) : Void
    {
        //enemy.onOverlapProjectile(projectile);
        projectile.onOverlapEnemy(enemy);
    }

    private function onProjectileOverlapsLevel(projectile:Projectile, level:Level) : Void
    {
        projectile.onOverlapLevel(level);
        //level.onOverlapProjectile(projectile);
    }

    private function onProjectileOverlapsProp(projectile:Projectile, prop:Prop) : Void
    {
        projectile.onOverlapProp(prop);
        prop.onOverlapProjectile(projectile);
    }

    /**
      * Create a new enemy and return it.
      */
    public function createEnemy(configName:String=null) : Enemy 
    {
        var enemy = _enemies.recycle(Enemy);

        if (configName != null) {
            enemy.initFromConfig(configName);
            enemy.revive();
        }

        addTerror(enemy.spawnTerror);

        return enemy;
    }

    /**
      * Create a new projectile and return it.
      */
    public function createProjectile(configName:String=null) : Projectile
    {
        var projectile = _projectiles.recycle(Projectile);
        projectile.detach();

        if (configName != null) {
            projectile.initFromConfig(configName);
            projectile.revive();
        }

        return projectile;
    }

    /**
      * Create a new prop and return it.
      */
    public function createProp(configName:String=null) : Prop 
    {
        var prop = _props.recycle(Prop);

        if (configName != null) {
            prop.initFromConfig(configName);
            prop.revive();
        }

        return prop;
    }

    /**
      * Increase terror affecting players.
      */
    public function addTerror(t:Float) {
        terror += t;

        if (terror > MAX_TERROR) { 
            openSubState(_levelLost);
        }
    }

    /**
      * Decrease terror affecting players.
      */
    public function removeTerror(t:Float) {
        terror = Math.max(terror - t, 0);
    }
}

class Paused extends FlxSubState
{
    var _pauseText:FlxText;
    
    public var pausingPlayer:Int = 0;
     
    override public function create() : Void
    {
        _pauseText = new FlxText(0, GAME_HEIGHT / 2 - 12, GAME_WIDTH, "Paused", 24);
        _pauseText.setFormat(null, 24, 0xFFFFFF, "center", FlxText.BORDER_OUTLINE);
        _pauseText.borderSize = 5;
        add(_pauseText);

        super.create();
    }
     
    override public function update() : Void
    {
        var controller = GameConfiguration.controllers[pausingPlayer];

        if (controller.pause.justPressed()) {
            close();
        }

        super.update();
    }
}

class LevelWon extends FlxSubState
{
    var _wonText:FlxText;
     
    override public function create() : Void
    {
        _wonText = new FlxText(0, GAME_HEIGHT / 2 - 12, GAME_WIDTH, "Level won!");
        _wonText.setFormat(null, 24, 0xFFFFFF, "center", FlxText.BORDER_OUTLINE);
        _wonText.borderSize = 5;
        add(_wonText);
        
        super.create();
    }
     
    override public function update() : Void
    {
        for (i in 0...GameConfiguration.numPlayers) {
            var controller = GameConfiguration.controllers[i];

            if (controller.select.justPressed()) {
                close();
            }
        }

        super.update();
    }
}

class LevelLost extends FlxSubState
{
    var _lostText:FlxText;
     
    override public function create()
    {
        _lostText = new FlxText(0, GAME_HEIGHT / 2 - 12, GAME_WIDTH, "Level lost!");
        _lostText.setFormat(null, 24, 0xFFFFFF, "center", FlxText.BORDER_OUTLINE);
        _lostText.borderSize = 5;
        add(_lostText);
        
        super.create();
    }

    override public function update() : Void
    {
        for (i in 0...GameConfiguration.numPlayers) {
            var controller = GameConfiguration.controllers[i];

            if (controller.select.justPressed()) {
                close();
            }
        }

        super.update();
    }
}
