package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;

import Globals.*;

/**
  * Game state when in the main menu.
  */
class CharacterSelectState extends FlxState
{
    var _title:FlxText;

    var _characters:FlxTypedGroup<FlxText>;
    var _selected:Int;

	override public function create() : Void
	{
        _title = new FlxText(0, 0, GAME_WIDTH, "Character select!");
        _title.setFormat(null, 12, 0xFFFFFF, "center"); 
        add(_title);

        _selected = Lambda.indexOf(PLAYER_CHARACTERS, GameConfiguration.playerCharacters[0]);

        var i = 0;

        _characters = new FlxTypedGroup<FlxText>();

        for (character in PLAYER_CHARACTERS) {
            var _config = ConfigManager.load(PLAYER_CHARACTER_BASE_PATH + character);
            
            var text = new FlxText(0, 60 + i *  12, GAME_WIDTH, _config.name);
            _characters.add(text);

            i += 1;
        }

        moveCursor();

        add(_characters);

		super.create();
	}

    override public function update() : Void
    {
        super.update();

        // Player controls
        for (i in 0...GameConfiguration.numPlayers) {
            var controller = GameConfiguration.controllers[i];

            if (controller.down.justPressed()) {
                _selected += 1;

                if (_selected >= PLAYER_CHARACTERS.length) {
                    _selected = 0;
                }

                moveCursor();
            } else if (controller.up.justPressed()) {
                _selected -= 1;

                if (_selected < 0) {
                    _selected = PLAYER_CHARACTERS.length - 1;
                }

                moveCursor();
            } else if (controller.select.justPressed()) {
                select();
            }
        }
    }

    private function moveCursor() : Void
    {
        var i = 0;

        for (text in _characters.members) {
            text.setFormat(null, 12, i == _selected ? 0xFF0000 : 0xFFFFFF, "center");
            i += 1;
        }
    }

    private function select() : Void
    {
        GameConfiguration.playerCharacters[0] = PLAYER_CHARACTERS[_selected];

		FlxG.switchState(new GameState());
    }
}
