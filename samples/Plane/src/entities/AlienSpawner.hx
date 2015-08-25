package entities;
import ze.object.GameObject;
import ze.util.MathUtil;
import ze.util.Time;

/**
 * ...
 * @author Goh Zi He
 */
class AlienSpawner extends GameObject 
{
	private var _lastTime:Int;
	private static inline var delay:Int = 500;
	
	override public function added():Void 
	{
		super.added();
		_lastTime = 0;
	}
	
	override public function update():Void 
	{
		super.update();
		if (Time.currentTime - _lastTime > delay)
		{
			_lastTime = Time.currentTime;
			scene.addGameObject(new Alien("Alien", MathUtil.randomFloat(scene.screen.width - 30, 30), MathUtil.randomFloat(120)));
		}
	}
}