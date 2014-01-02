package boxed.scene;

import flash.system.System;
import ze.component.ui.Button;
import ze.object.Scene;

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
		var btn:Button = new Button("playButton", "gfx/PlayBtn.png", 128, 32, [0, 0], [0, 1]);
		btn.registerCallback(null, null, null, click);
		createGameObject("", btn, 1100, 700);
		
		var btn:Button = new Button("quitButton", "gfx/QuitBtn.png", 128, 32, [0, 0], [0, 1]);
		btn.registerCallback(null, null, null, quit);
		createGameObject("", btn, 1132, 732);
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