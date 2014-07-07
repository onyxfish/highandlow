High and Low
============

Chris' game concept.

Installing tools
----------------

You'll need a Python tool called fabric:

```
pip install fabric
```

You can install this in a virtualenv, or globally with `sudo`.

Installing dependencies
-----------------------

To install haxe dependencies (flixel, openfl, etc):

```
fab setup 
```

Running the game
----------------

To test the game using neko:

```
fab test
```

To run the C++/Mac build:

```
fab mac
```

Generate code documentation
---------------------------

To generate class docs, run:

```
fab docs
```

Notes on physics
----------------

Flixel uses a simple physics model. The parameters provided work like this:

* `velocity`: Pixels per second change in position. If `TILE_WIDTH == 10` and `velocity.x == 50` then the sprite will cover a five tile distance in one second.
* `acceleration`: Pixels per second change in velocity. (Probably only useful in Whack Whack for simulating gravity or effects.)
* `drag`: Pixels per second reduction in velocity that only applies while `acceleration == 0`.

Notes on difficulty
-------------------

The following variables can be adjusted to control difficulty:

* Number of spawner locations in level
* Cooldown between creating spawners
* Number of enemies created by each spawner
* Cooldown between creating enemies by each spawner
* Type/attributes of enemy that is spawned.

Notes on level structure
------------------------

Levels are edited in Tiled and consistent of the following layers:

* A 320x240 image background layer.
* A 5x5 floors & walls collision layer.
* An object layer, which can be composed of tilesets of any size so long as "snap to grid" is enabled. These tiles are only placeholders. Tile properties define associations between the these tiles and the Props that will replace them.

