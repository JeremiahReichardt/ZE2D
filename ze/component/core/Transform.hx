package ze.component.core;

/**
 * Transform component that includes moving, scaling, rotating of a gameobject
 * @author Goh Zi He
 */
class Transform extends Component
{
	public var x(default, default):Float;
	public var y(default, default):Float;
	public var width(get, null):Float;
	public var height(get, null):Float;
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
		_moveX = 0;
		_moveY = 0;
		_diffX = 0;
		_diffY = 0;
		x = 0;
		y = 0;
		width = 0;
		height = 0;
		rotation = 0;
	}
	
	override public function update():Void 
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
	 * Move the gameObject in the x/y axis (With collision, slower than move)
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
		
		_moveX += xDir;
		_moveY += yDir;
		
		xDir = Math.round(_moveX);
		yDir = Math.round(_moveY);
		
		_moveX -= xDir;
		_moveY -= yDir;
		
		_direction = xDir > 0 ? 1 : -1;
		while (xDir != 0)
		{
			collider.setPos(x + _direction, y);
			if (collider.checkCollisionWith() != null)
			{
				break;
			}
			x += _direction;
			xDir -= _direction;
		}
		
		_direction = yDir > 0 ? 1 : -1;
		while (yDir != 0)
		{
			collider.setPos(x, y + _direction);
			if (collider.checkCollisionWith() != null)
			{
				break;
			}
			y += _direction;
			yDir -= _direction;
		}
		
		// Reset collider position
		collider.setPos(x, y);
	}
	
	/**
	 * Attach this gameObject to another gameObject's transform
	 * @param	toTransform
	 */
	public function attachTo(toTransform:Transform):Void
	{
		_attached = toTransform;
		_diffX = toTransform.x - x;
		_diffY = toTransform.y - y;
	}
	
	/**
	 * Helper function to set the x and y of this transform. Same as setting
	 * transform.x and transform.y manually
	 * @param	xPos
	 * @param	yPos
	 */
	public function setPos(xPos:Float, yPos:Float):Void
	{
		x = xPos;
		y = yPos;
	}
	
	/**
	 * Rotate this gameObject by angle
	 * @param	angle
	 */
	public function rotate(angle:Float):Void
	{
		setRot(rotation + angle);
	}
	
	/**
	 * Helper function to set the rotation of this gameObject
	 * @param	newAngle
	 */
	public function setRot(newAngle:Float):Void
	{
		rotation = newAngle;
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
	
	override public function removed():Void 
	{
		super.removed();
		_attached = null;
	}
	
	private function get_width():Float
	{
		if (width == 0)
		{
			if (collider != null)
			{
				width = collider.width;
			}
			else if (graphic != null)
			{
				width = graphic.width;
			}
		}
		return width;
	}
	
	private function get_height():Float
	{
		if (height == 0)
		{
			if (collider != null)
			{
				height = collider.height;
			}
			else if (graphic != null)
			{
				height = graphic.height;
			}
		}
		return height;
	}
}