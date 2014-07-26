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
		x = 0;
		y = 0;
		rotation = 0;
		scaleX = 1;
		scaleY = 1;
		_moveX = 0;
		_moveY = 0;
		_diffX = 0;
		_diffY = 0;
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
	
	override public function removed():Void 
	{
		super.removed();
		_attached = null;
	}
}