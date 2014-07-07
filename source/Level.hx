package;

import haxe.CallStack;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import openfl.Assets;

import Globals.*;

/**
  * A game level.
  */
class Level extends FlxTilemap
{
    var _config:Dynamic;
    var _tiled:TiledMap;

    public var spawnPoints(get, never):Array<Dynamic>;
    public var title(get, never):String;
    public var nextLevel(get, never):String;

    public function new(configName:String=null)
    {
        super();

        if (configName != null) {
            initFromConfig(configName);
        }
    }

    public function initFromConfig(configName:String)
    {
        _config = ConfigManager.load(LEVEL_BASE_PATH + configName);
        _tiled = new TiledMap(_config.map);

        // Map
        widthInTiles = MAP_WIDTH;
        heightInTiles = MAP_HEIGHT;
        loadMap(_tiled.collisionData, TILES_BASE_PATH + _config.tiles, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
    }

    /**
      * Create initial props from level config.
      */
    public function createProps(gameState:GameState) : Void
    {
        var propList:Array<Dynamic> = _config.props;

        for (propConfig in propList) {
            var prop:Prop = gameState.createProp(propConfig.name);

            prop.x = propConfig.position[0];
            prop.y = propConfig.position[1];
        }
    }

    private function get_title() : String
    {
        return _config == null ? null : _config.title;
    }

    private function get_nextLevel() : String
    {
        return _config == null ? null : _config.nextLevel;
    }

    private function get_spawnPoints() : Array<Dynamic>
    {
        return _tiled.spawnPoints;
    }
}

/**
  * Encasulates map loading details specific to the Tiled
  * JSON format.
  */
class TiledMap
{
    var _config:Dynamic;

    var _collisionLayer:Dynamic;
    var _objectsLayer:Dynamic;

    var _collisionTileset:Dynamic;
    var _objectsTileset:Dynamic;

    var _spawnPointTileGid:String;
    var _playerPointTileGid:String;

    public var collisionData:Array<Int>;
    public var spawnPoints:Array<Dynamic>;
    public var playerPoints:Array<Dynamic>;

    public function new(configName:String) {
        _config = ConfigManager.load(MAP_BASE_PATH + configName);

        // Extract layers
        for (layer in cast(_config.layers, Array<Dynamic>)) {
            if (layer.name == 'collision') {
                _collisionLayer = layer;
            } else if (layer.name == 'objects') {
                _objectsLayer = layer;
            }
        }

        collisionData = _collisionLayer.data;

        // Extract tilesets
        for (tileset in cast(_config.tilesets, Array<Dynamic>)) {
            if (tileset.name == 'collision') {
                _collisionTileset = tileset;
            } else if (tileset.name == 'objects') {
                _objectsTileset = tileset;
            }
        }

        var tileProperties = _objectsTileset.tileproperties;

        // Extract object/tile identifiers
        for (f in Reflect.fields(tileProperties)) {
            var data:Dynamic = Reflect.field(tileProperties, f);

            if (data.type == 'spawnPoint') {
                _spawnPointTileGid = _objectsTileset.firstgid + Std.parseInt(f);
            } else if (data.type == 'playerPoint') {
                _playerPointTileGid = _objectsTileset.firstgid + Std.parseInt(f);
            }
        }

        // Process objects
        spawnPoints = new Array<Dynamic>();
        playerPoints = new Array<Dynamic>();

        for (object in cast(_objectsLayer.objects, Array<Dynamic>)) {
            if (object.gid == _spawnPointTileGid) {
                spawnPoints.push([object.x, object.y]);
            } else if (object.gid == _playerPointTileGid) {
                playerPoints.push([object.x, object.y]);
            }
        }
    }
}
