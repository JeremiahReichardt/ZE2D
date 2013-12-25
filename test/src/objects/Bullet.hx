package objects;

import flash.display.BitmapData;
import ze.component.rendering.Image;
import ze.object.GameObject;
import ze.util.Color;
import ze.util.Time;

/**
 * ...
 * @author Goh Zi He
 */
class Bullet extends GameObject
{
	var dirX:Float;
	var dirY:Float;
	static inline var speed:Float = 100;
	public static var g:GameObject;
	
	public function new(x:Float = 0, y:Float = 0, dirX:Float = 0, dirY:Float = 0)
	{
		super("Bullet", x, y);
		this.dirX = dirX;
		this.dirY = dirY;
		
		g = this;
	}
	
	override private function added():Void 
	{
		super.added();
		addComponent(new Image("bullet", new BitmapData(8, 8, Color.GREEN)));
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
			scene.removeGameObject(this);
		}
	}
}