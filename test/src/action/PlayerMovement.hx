package action;

import ze.component.core.Component;
import ze.util.Input;
import ze.util.Time;

/**
 * ...
 * @author Goh Zi He
 */
class PlayerMovement extends Component
{
	var xSpeed:Float;
	var ySpeed:Float;
	
	static inline var speed:Float = 100;
	static inline var maxSpeed:Float = 400;
	
	override private function added():Void 
	{
		super.added();
		xSpeed = ySpeed = 0;
	}
	
	override private function update():Void 
	{
		super.update();
		
		if (Input.keyDown("up"))
		{
			ySpeed = -speed;
		}
		else if (Input.keyDown("down"))
		{
			ySpeed = speed;
		}
		
		if (Input.keyDown("left"))
		{
			xSpeed = -speed;
		}
		else if (Input.keyDown("right"))
		{
			xSpeed = speed;
		}
		
		xSpeed *= 0.8;
		ySpeed *= 0.8;
		
		transform.moveBy(xSpeed * Time.deltaTime, ySpeed * Time.deltaTime);
	}
	
	override private function removed():Void 
	{
		super.removed();
	}
}