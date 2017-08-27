package scenes;
import openfl.system.System;
import ze.component.ui.Button;
import ze.object.Scene;
import ze.util.TileSheetLayer;

/**
 * ...
 * @author Goh Zi He
 */
class MainScene extends Scene
{
	private var _clicked:Bool;
	
	override public function added():Void
	{
		super.added();
    
    screen.createTileSheet("sprites", "atlas/sprites");
		
		var btn:Button = new Button("sprites", "PlayBtn", 128, 32);
		createGameObject("playBtn", btn, 265, 300);
		btn.addButtonState(ButtonState.EXIT, [0]);
		btn.addButtonState(ButtonState.ENTER, [1]);
		btn.registerCallback(null, null, null, click);
		
		var btn:Button = new Button("sprites", "QuitBtn", 128, 32);
		createGameObject("quitBtn", btn, 265, 340);
		btn.addButtonState(ButtonState.EXIT, [0]);
		btn.addButtonState(ButtonState.ENTER, [1]);
		btn.registerCallback(null, null, null, quit);
	}
	
	private function click():Void
	{
		engine.addScene(new GameScene());
	}
	
	private function quit():Void
	{
		System.exit(0);
	}
}