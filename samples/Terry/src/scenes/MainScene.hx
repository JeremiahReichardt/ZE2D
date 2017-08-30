package scenes;
import components.Grid;
import openfl.Assets;
import prefab.ColliderObject;
import prefab.ExitObject;
import prefab.HorizontalGateObject;
import prefab.PlayerObject;
import prefab.RespawnObject;
import prefab.SignObject;
import prefab.SpikeObject;
import prefab.SwitchObject;
import prefab.VerticalGateObject;
import ze.object.Scene;
import ze.util.Input;
import ze.util.Key;
import ze.util.OgmoLoader;

/**
 * ...
 * @author Goh Zi He
 */
class MainScene extends Scene
{
	public var grid:Grid;
	
	private static var _level:Int = 1;
	private var _start:Bool;
	
	override public function added():Void
	{
		super.added();
		
    screen.createTileSheet("game", "atlas/game");
    screen.createTileSheet("ui", "atlas/ui");
    screen.createTileSheet("font", "atlas/font");
		
		startLevel();
	}
	
	private function startLevel():Void
	{
		grid = new Grid(800, 800, 32);
		createGameObject("grid", grid);
		
		var _ogmoLoader:OgmoLoader = new OgmoLoader(this);
		
		if (!Assets.exists("level/Puzzle " + _level + ".oel")) _level = 1;
		
		_ogmoLoader.setOEL("level/Puzzle " + _level + ".oel");
		_ogmoLoader.loadTiledSprite("game", "Checker", 32, 32, 8, 8, setGrid);
		_ogmoLoader.setLayer("Collision");
		_ogmoLoader.setEntity("rect", ColliderObject);
		
		_ogmoLoader.setLayer("Spikes");
		_ogmoLoader.setEntity("rect", SpikeObject);
		
		_ogmoLoader.setLayer("Entities");
		_ogmoLoader.setEntity("Exit", ExitObject);
		_ogmoLoader.setEntity("Sign", SignObject);
		_ogmoLoader.setEntity("Respawn", RespawnObject);
		_ogmoLoader.setEntity("Switch", SwitchObject);
		_ogmoLoader.setEntity("VerticalGate", VerticalGateObject);
		_ogmoLoader.setEntity("HorizontalGate", HorizontalGateObject);
		_ogmoLoader.setEntity("Player", PlayerObject);
		
		_ogmoLoader.loadAll();
	}
	
	private function setGrid(x:Int, y:Int):Void
	{
		grid.setGrid(x, y);
	}
	
	override public function update():Void 
	{
		super.update();
		if (Input.keyPressed(Key.N)) 
		{
			nextLevel();
		}
	}
	
	override public function nextLevel():Void
	{
		++_level;
		engine.addScene(new MainScene());
	}
}