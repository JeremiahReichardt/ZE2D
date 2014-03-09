package puzzle.scene;

import openfl.Assets;
import puzzle.actions.Grid;
import puzzle.prefab.ColliderObject;
import puzzle.prefab.ExitObject;
import puzzle.prefab.HorizontalGateObject;
import puzzle.prefab.PlayerObject;
import puzzle.prefab.RespawnObject;
import puzzle.prefab.SignObject;
import puzzle.prefab.SpikeObject;
import puzzle.prefab.SwitchObject;
import puzzle.prefab.TileObject;
import puzzle.prefab.VerticalGateObject;
import ze.component.core.OgmoLoader;
import ze.object.Scene;
import ze.util.Input;
import ze.util.Key;

/**
 * ...
 * @author Goh Zi He
 */
class MainScene extends Scene
{
	public var grid:Grid;
	
	private static var _level:Int = 1;
	private var _start:Bool;
	
	override private function added():Void
	{
		super.added();
		
		startLevel();
	}
	
	private function startLevel():Void
	{
		grid = new Grid(800, 800, 32);
		createGameObject("grid", grid);
		
		var _ogmoLoader:OgmoLoader = new OgmoLoader();
		createGameObject("OgmoLoader", _ogmoLoader);
		
		if (!Assets.exists("level/Puzzle " + _level + ".oel")) _level = 1;
		
		_ogmoLoader.setOEL("level/Puzzle " + _level + ".oel");
		
		_ogmoLoader.setLayer("Collision");
		_ogmoLoader.setEntity("rect", ColliderObject);
		
		_ogmoLoader.setLayer("Tiles");
		_ogmoLoader.setEntity("tile", TileObject);
		
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
	
	override private function update():Void 
	{
		super.update();
		if (Input.keyPressed(Key.N)) 
		{
			nextLevel();
		}
	}
	
	public function nextLevel():Void
	{
		++_level;
		engine.addScene(new MainScene());
	}
}