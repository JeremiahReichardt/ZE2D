package objects;

import ze.component.rendering.Blank;
import ze.object.GameObject;
import ze.util.Color;
import ze.util.Time;

/**
 * ...
 * @author Goh Zi He
 */
class Bullet extends GameObject
{
	private var dirX:Float;
	private var dirY:Float;
	private static inline var speed:Float = 100;
	
	private static var index:Int;
	
	public function new(x:Float = 0, y:Float = 0, dirX:Float = 0, dirY:Float = 0)
	{
		super("Bullet", x, y);
		this.dirX = dirX;
		this.dirY = dirY;
		++index;
		id = "Bullet " + index;
	}
	
	override private function added():Void 
	{
		super.added();
		addComponent(new Blank(8, 8, Color.GREEN));
	}
	
	override private function update():Void 
	{
		super.update();
		
		transform.move(dirX * speed * Time.deltaTime, dirY * speed * Time.deltaTime);
		
		if (transform.x < 0 || transform.x > scene.screen.right)
		{
			scene.removeGameObject(this);
		}
		else if (transform.y < 0 || transform.y > scene.screen.bottom)
		{
			//scene.removeGameObject(this);
		}
	}
}