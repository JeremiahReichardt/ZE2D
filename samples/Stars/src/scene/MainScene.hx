package scene;
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
	
	override private function added():Void
	{
		super.added();
		var tileSheetLayer:TileSheetLayer = new TileSheetLayer("atlas/sprites");
		screen.addLayer(tileSheetLayer);
		
		var btn:Button = new Button("PlayBtn", 128, 32);
		createGameObject("playBtn", btn, 1100, 700);
		btn.addButtonState(ButtonState.EXIT, [0]);
		btn.addButtonState(ButtonState.ENTER, [1]);
		btn.registerCallback(null, null, null, click);
		
		var btn:Button = new Button("QuitBtn", 128, 32);
		createGameObject("quitBtn", btn, 1132, 732);
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