package ze.component.core;

import ze.component.core.Transform;

/**
 * ...
 * @author Goh Zi He
 */

class Transform extends Component
{
	public var x(default, default):Float;
	public var y(default, default):Float;
	public var scaleX(default, default):Float;
	public var scaleY(default, default):Float;
	public var rotation(default, null):Float;
	
	private var _direction:Int;
	private var _diffX:Float;
	private var _diffY:Float;
	private var _moveX:Float;
	private var _moveY:Float;
	private var _attached:Transform;
	
	public function new() 
	{
		super();
		
		x = y = rotation = 0;
		scaleX = scaleY = 1;
		_moveX = _moveY = _diffX = _diffY = 0;
	}
	
	override private function update():Void 
	{
		super.update();
		
		if (_attached != null)
		{
			x = _attached.x - _diffX;
			y = _attached.y - _diffY;
		}
	}
	
	/**
	 * Move the gameObject in the x/y axis (Ignore collision, Fast)
	 * @param	x
	 * @param	y
	 */
	public function move(xDir:Float = 0, yDir:Float = 0):Void
	{
		x += xDir;
		y += yDir;
	}
	
	/**
	 * Move the gameObject in the x/y axis (With collision, Slow)
	 * @param	x
	 * @param	y
	 */
	public function moveBy(xDir:Float = 0, yDir:Float = 0):Void
	{
		if (collider == null)
		{
			move(xDir, yDir);
			return;
		}
		
		collider.setPos(x, y);
		
		_moveX += xDir;
		_moveY += yDir;
		
		xDir = Math.round(_moveX);
		yDir = Math.round(_moveY);
		
		_moveX -= xDir;
		_moveY -= yDir;
		
		_direction = xDir > 0 ? 1 : -1;
		while (xDir != 0)
		{
			collider.x = x + _direction;
			collider.y = y;
			
			if (collider.checkCollisionWith() == null)
			{
				x += _direction;
			}
			else
			{
				break;
			}
			
			xDir -= _direction;
		}
		
		_direction = yDir > 0 ? 1 : -1;
		while (yDir != 0)
		{
			collider.x = x;
			collider.y = y + _direction;
			
			if (collider.checkCollisionWith() == null)
			{
				y += _direction;
			}
			else
			{
				break;
			}
			
			yDir -= _direction;
		}
		
		//Ensure that collider is back in position before calling moveBy again
		collider.setPos(x, y);
	}
	
	public function attachTo(toTransform:Transform):Void
	{
		_attached = toTransform;
		_diffX = toTransform.x - x;
		_diffY = toTransform.y - y;
	}
	
	public function setPos(xPos:Float, yPos:Float):Void
	{
		x = xPos;
		y = yPos;
	}
	
	public function rotate(angle:Float):Void
	{
		setRot(rotation + angle);
	}
	
	public function setRot(angle:Float):Void
	{
		rotation = angle;
		if (rotation >= 360)
		{
			var exceed:Float = rotation - 360;
			rotation = exceed;
		}
		else if (rotation < 0)
		{
			var exceed:Float = rotation + 360;
			rotation = exceed;
		}
	}
	
	public function resize(sizeX:Float = 0, sizeY:Float = 0):Void
	{
		scaleX += sizeX;
		scaleY += sizeY;
	}
}