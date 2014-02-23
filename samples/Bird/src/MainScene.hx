package;
import entities.Bird;
import entities.Wall;
import ze.object.Scene;
import ze.util.Input;

/**
 * ...
 * @author Goh Zi He
 */
class MainScene extends Scene
{
	private var _bird:Bird;
	private var _walls:Array<Wall>;
	private var _gameEnd:Bool;
	
	private static inline var LEFTSPAWN:Int = 500;
	private static inline var RIGHT:Int = 800;
	private static inline var LEFTDESTROY:Int = -20;
	
	override private function added():Void
	{
		super.added();
		
		_bird = new Bird();
		addGameObject(_bird);
		
		_walls = [new Wall(RIGHT)];
		addGameObject(_walls[0]);
	}
	
	override private function update():Void 
	{
		super.update();
		
		if (_gameEnd)
		{
			if (Input.leftMousePressed())
			{
				engine.addScene(new MainScene());
			}
			return;
		}
		if (Input.leftMouseDown())
		{
			_bird.fly();
		}
		
		if (_walls.length > 0 && _walls[_walls.length - 1].transform.x < LEFTSPAWN)
		{
			_walls.push(new Wall(RIGHT));
			addGameObject(_walls[_walls.length - 1]);
		}
		
		var i:Int = 0;
		while (i < _walls.length)
		{
			if (_walls[i].transform.x < LEFTDESTROY)
			{
				removeGameObject(_walls[i]);
				_walls.remove(_walls[i]);
			}
			else
			{
				++i;
			}
		}
	}
	
	public function endGame():Void
	{
		for (wall in _walls)
		{
			wall.enable = false;
		}
		_gameEnd = true;
	}
}