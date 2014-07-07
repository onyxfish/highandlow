package;

import flash.display.BitmapData;
import flash.geom.Rectangle;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxSpriteUtil;

import Globals.*;

/**
  * The text and graphics overlay during the game.
  */
class GameHUD extends FlxGroup
{
    var _gameState:GameState;
    var _player:PlayerCharacter;

    var _terror:FlxText;
    var _terrorBar:FlxSprite;
    var _terrorBarLength:Int;

    var _cooldowns:FlxTypedGroup<FlxText>;

    public function new(gameState:GameState) : Void
    {
        super();

        _gameState = gameState;

        var half_game_width = cast(GAME_WIDTH / 2, Int);

        _terror = new FlxText(0, 0, half_game_width);
        _terror.setFormat(null, 12, 0xFFFFFF, "left");
        add(_terror);

        _terrorBar = new FlxSprite(10, 20);
        _terrorBar.makeGraphic(GAME_WIDTH - 20, 5);
        add(_terrorBar);

        /*var i = 0;
        _cooldowns = new FlxTypedGroup<FlxText>();

        for (ability in _player.getAbilities()) {
            var text = new FlxText(half_game_width, i * 12, half_game_width, ability.getName() + ": 0");
            text.setFormat(null, 12, 0xFFFFFF, "right"); 

            _cooldowns.add(text);

            i += 1;
        }

        add(_cooldowns);*/
    }

    override public function destroy() : Void
    {
        /*_cooldowns.destroy();
        _cooldowns = null;*/

        _terror.destroy();
        _terror = null;

        super.destroy();
    }

    override public function update() : Void
    {
        /*var i = 0;

        for (ability in _player.getAbilities()) {
            var text = _cooldowns.members[i];
            text.text = ability.getName() + ": " + Math.round(ability.getTimeUntilReady() * 100) / 100;

            i += 1;
        }*/

        _terror.text = "Terror: " + _gameState.terror;

        FlxSpriteUtil.fill(_terrorBar, 0x9900FF00);
        FlxSpriteUtil.drawRect(_terrorBar, 0, 0, (_gameState.terror / MAX_TERROR) * _terrorBar.width, 5, 0x99990000); 

        super.update();
    }
}
