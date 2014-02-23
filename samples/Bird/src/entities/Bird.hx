package entities;
import flash.display.BitmapData;
import motion.Actuate;
import ze.component.physics.BoxCollider;
import ze.component.physics.Collider;
import ze.component.rendering.Image;
import ze.object.GameObject;
import ze.util.Color;

/**
 * ...
 * @author Goh Zi He
 */
class Bird extends GameObject
{
	private var _ySpeed:Float;
	private var _dead:Bool;
	
	public function new() 
	{
		super("bird", 350, 200);
		_ySpeed = 0;
	}
	
	override private function added():Void 
	{
		super.added();
		addComponent(new Image("Bird", new BitmapData(32, 32, Color.GREEN)));
		addComponent(new BoxCollider(32, 32, true));
		collider.registerCallback(hitBird);
	}
	
	override private function update():Void 
	{
		super.update();
		if (_dead)
		{
			return;
		}
		transform.moveBy(0, _ySpeed);
		if (_ySpeed < 10)
		{
			_ySpeed += 1;
		}
	}
	
	public function fly():Void
	{
		if (_ySpeed > -10)
		{
			_ySpeed -= 5;
		}
	}
	
	private function hitBird(collider:Collider):Void
	{
		// Play dead animation
		_dead = true;
		Actuate.tween(transform, 3, { x: 400, y: 800 } );
		
		cast(scene, MainScene).endGame();
	}
}