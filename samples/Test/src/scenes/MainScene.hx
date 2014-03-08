package scenes;

import ze.component.rendering.Text;
import ze.component.ui.Button;
import ze.object.GameObject;
import ze.object.Scene;
import ze.util.Color;
import ze.util.Input;
import ze.util.Key;
/**
 * ...
 * @author Goh Zi He
 */
class MainScene extends Scene
{
	private var text:Text;
	
	override private function added():Void 
	{
		super.added();
		
		Input.addKey("up", [Key.W, Key.UP]);
		Input.addKey("down", [Key.S, Key.DOWN]);
		Input.addKey("left", [Key.A, Key.LEFT]);
		Input.addKey("right", [Key.D, Key.RIGHT]);
		
		var gameObject:GameObject = new GameObject("GO", screen.midX - 70, screen.midY);
		addGameObject(gameObject);
		
		text = new Text("Press something!", Color.WHITE);
		
		gameObject.addComponent(text);
		
		var button:Button = new Button("PlayButton", "gfx/Button.png", 64, 32, [0], [1], [0]);
		createGameObject("", button, screen.midX - 64, screen.midY - 32);
	}
	
	override private function update():Void 
	{
		super.update();
		
		if (Input.anyKeyPressed() || Input.leftMousePressed())
		{
			engine.addScene(new GameScene());
		}
	}
}