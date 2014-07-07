package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.text.FlxText;

import Globals.*;

/**
  * State when in the main menu.
  */
class MenuState extends FlxState
{
    var _title:FlxText;

    var _pressStart:PressStart;
    var _topMenu:TopMenu;

    var _nextSubState:FlxSubState;

	override public function create() : Void
	{
        _title = new FlxText(0, 20, GAME_WIDTH, "Whack Whack");
        _title.setFormat(null, 30, 0xFFFFFF, "center", FlxText.BORDER_OUTLINE);
        _title.borderSize = 3;
        add(_title);

        _pressStart = new PressStart();
        _topMenu = new TopMenu();
        _nextSubState = null;

		super.create();

        openSubState(_pressStart); 
        onPressStart();
	}

    override public function update() : Void
    {
        // Substates cannot be set in callback, so we wait until update
        if (_nextSubState != null) {
            openSubState(_nextSubState);
            _nextSubState = null;
        }
    }

    private function onPressStart() : Void
    {
        _nextSubState = _topMenu;
    }
}

class PressStart extends FlxSubState
{
    var _start:FlxText;

    override public function create() : Void
    {
        _start = new FlxText(0, 100, GAME_WIDTH, "Press Enter/Start");
        _start.setFormat(null, 14, 0xFFFFFF, "center");
        add(_start);

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

class TopMenu extends FlxSubState
{
    var _story:FlxText;
    var _arcade:FlxText;
    var _arrow:FlxSprite;

    var _selection:Int = 0;
    var LAST_SELECTION:Int = 1;

    override public function create() : Void
    {
        _selection = 0;

        _story = new FlxText(40, 100, GAME_WIDTH - 40, "Arcade");
        _story.setFormat(null, 14, 0xFFFFFF);
        add(_story);

        _arcade = new FlxText(40, 120, GAME_WIDTH - 40, "Story");
        _arcade.setFormat(null, 14, 0xFFFFFF);
        add(_arcade);

        _arrow = new FlxSprite(25, 105 + (_selection * 20));
        _arrow.loadGraphic(IMAGE_BASE_PATH + 'crate.png', false, 10, 10); 
        add(_arrow);

        super.create();
    }

    override public function update() : Void
    {
        for (i in 0...GameConfiguration.numPlayers) {
            var controller = GameConfiguration.controllers[i];

            if (controller.pause.justPressed() || controller.select.justPressed()) {
                close();
            }

            if (controller.down.justPressed()) {
                _selection += 1;

                if (_selection > LAST_SELECTION) {
                    _selection = 0;
                }

                SoundManager.play('navigate.wav');
                moveArrow();
            } else if (controller.up.justPressed()) {
                _selection -= 1;

                if (_selection < 0) {
                    _selection = LAST_SELECTION;
                }

                SoundManager.play('navigate.wav');
                moveArrow();
            } else if (controller.select.justPressed())
            {
                // Arcade
                if (_selection == 0) {
                    GameConfiguration.gameMode = ARCADE_MODE;

                    FlxG.switchState(new CharacterSelectState());
                // Story
                } else if (_selection == 1) {
                    GameConfiguration.gameMode = STORY_MODE;

                    FlxG.switchState(new CharacterSelectState());
                }
            }
        }
	
        super.update();
    }

    private function moveArrow() : Void
    {
        _arrow.y = 105 + (_selection * 20);
    }
}
