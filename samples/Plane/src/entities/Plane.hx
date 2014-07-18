package entities;
import scenes.MainScene;
import ze.component.graphic.displaylist.Image;
import ze.component.physics.BoxCollider;
import ze.component.physics.Collider;
import ze.object.GameObject;
import ze.util.Input;
import ze.util.Time;

/**
 * ...
 * @author Goh Zi He
 */
class Plane extends GameObject
{
	override public function added():Void 
	{
		super.added();
		_lastTime = 0;
		addComponent(new Image("Plane", "gfx/Plane.png"));
		graphic.centered = true;
		addComponent(new BoxCollider(20, 32, true));
		collider.registerCallback(enterCollision);
	}
	
	override public function update():Void 
	{
		super.update();
		transform.x = Input.mouseX;
		transform.y = Input.mouseY;
		
		if (transform.x + graphic.width >= scene.screen.width)
		{
			transform.x = scene.screen.width - graphic.width;
		}
		
		if (transform.x <= 0)
		{
			transform.x = 0;
		}
		
		if (transform.y + graphic.height >= scene.screen.height)
		{
			transform.y = scene.screen.height - graphic.height;
		}
		
		if (transform.y <= 0)
		{
			transform.y = 0;
		}
		
		repeatFire(Time.seconds(0.3));
	}
	
	private var _lastTime:Int;
	private function repeatFire(delay:Float):Void
	{
		if (Time.currentTime - _lastTime > delay)
		{
			scene.addGameObject(new Missile(transform.x, transform.y - graphic.halfHeight));
			_lastTime = Time.currentTime;
		}
	}
	
	private function enterCollision(collider:Collider):Void
	{
		if (collider.gameObject.name == "Alien")
		{
			cast(scene, MainScene).loseHealth();
			scene.removeGameObject(collider.gameObject);
		}
	}
}