package scenes;
import action.game.ItemManager;
import openfl.display.BitmapData;
import prefab.ColliderObject;
import prefab.PlayerObject;
import ze.component.sounds.Audio;
import ze.object.Scene;
import ze.util.Input;
import ze.util.Key;
import ze.util.OgmoLoader;
import ze.util.TileSheetLayer;
/**
 * ...
 * @author Goh Zi He
 */

class GameScene extends Scene
{
	private static var level:Int = 1;
	
	private var _tileset:BitmapData;
	private var _ogmoLoader:OgmoLoader;
	
	override public function added():Void
	{
		super.added();
		var tileSheetLayer:TileSheetLayer = new TileSheetLayer("atlas/sprites");
		screen.addLayer(tileSheetLayer);
		
		Audio.mute();
		
		createGameObject("item_manager", new ItemManager());
		
		_ogmoLoader = new OgmoLoader(this);
		_ogmoLoader.setOEL("level/Level " + level + ".oel");
		
		_ogmoLoader.loadTiles();
		
		_ogmoLoader.setLayer("Entities");
		_ogmoLoader.setEntity("Player", PlayerObject);
		
		_ogmoLoader.setLayer("Collision");
		_ogmoLoader.setEntity("rect", ColliderObject);
		
		_ogmoLoader.loadAll();
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (Input.keyPressed(Key.DIGIT_1)) { level = 1; engine.addScene(new GameScene()); }
		if (Input.keyPressed(Key.DIGIT_2)) { level = 2; engine.addScene(new GameScene()); }
		if (Input.keyPressed(Key.DIGIT_3)) { level = 3; engine.addScene(new GameScene()); }
		if (Input.keyPressed(Key.DIGIT_4)) { level = 4; engine.addScene(new GameScene()); }
		if (Input.keyPressed(Key.DIGIT_5)) { level = 5; engine.addScene(new GameScene()); }
		if (Input.keyPressed(Key.M)) Audio.toggleMute();
	}
}