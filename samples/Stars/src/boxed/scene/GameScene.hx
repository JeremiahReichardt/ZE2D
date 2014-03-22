package boxed.scene;

import boxed.action.game.ItemManager;
import boxed.prefab.ColliderObject;
import boxed.prefab.PlayerObject;
import boxed.prefab.TileObject;
import flash.display.BitmapData;
import ze.component.core.OgmoLoader;
import ze.component.sounds.Audio;
import ze.object.Scene;
import ze.util.Input;
import ze.util.Key;
/**
 * ...
 * @author Goh Zi He
 */

class GameScene extends Scene
{
	private static var level:Int = 1;
	
	private var _tileset:BitmapData;
	private var _ogmoLoader:OgmoLoader;
	
	override private function added():Void
	{
		super.added();
		
		Audio.mute();
		
		createGameObject("item_manager", new ItemManager());
		
		_ogmoLoader = new OgmoLoader();
		createGameObject("OgmoLoader", _ogmoLoader);
		
		_ogmoLoader.setOEL("level/Level " + level + ".oel");
		
		_ogmoLoader.setLayer("Tiles");
		_ogmoLoader.setEntity("tile", TileObject);
		
		_ogmoLoader.setLayer("Entities");
		_ogmoLoader.setEntity("Player", PlayerObject);
		
		_ogmoLoader.setLayer("Collision");
		_ogmoLoader.setEntity("rect", ColliderObject);
		
		_ogmoLoader.loadAll();
	}
	
	override private function update():Void 
	{
		super.update();
		
		if (Input.rightMousePressed())
		{
			trace(1);
		}
		if (Input.keyPressed(Key.DIGIT_1)) { level = 1; engine.addScene(new GameScene()); }
		if (Input.keyPressed(Key.DIGIT_2)) { level = 2; engine.addScene(new GameScene()); }
		if (Input.keyPressed(Key.DIGIT_3)) { level = 3; engine.addScene(new GameScene()); }
		if (Input.keyPressed(Key.DIGIT_4)) { level = 4; engine.addScene(new GameScene()); }
		if (Input.keyPressed(Key.DIGIT_5)) { level = 5; engine.addScene(new GameScene()); }
		if (Input.keyPressed(Key.M)) Audio.toggleMute();
	}
}