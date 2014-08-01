package ze.component.physics;
import ze.component.physics.BoxCollider;
import ze.component.physics.Collider;
import ze.util.Color;

/**
 * ...
 * @author Goh Zi He
 */

class BoxCollider extends Collider
{
	public var width(default, null):Float;
	public var height(default, null):Float;
	public var left(get, null):Float;
	public var right(get, null):Float;
	public var top(get, null):Float;
	public var bottom(get, null):Float;
	
	/**
	 * Simple box collider with support for triggers
	 * @param	width		The width of the box collider
	 * @param	height		The height of the box collider 
	 * @param	trigger		Set to false to register callbacks
	 */
	public function new(width:Float, height:Float, ?xOffset:Float = 0, ?yOffset:Float = 0, trigger:Bool = false) 
	{
		super(trigger);
		setBox(width, height, xOffset, yOffset);
	}
	
	public function setBox(width:Float, height:Float, xOffset:Float = 0, yOffset:Float = 0):Void
	{
		this.width = width;
		this.height = height;
		this.offsetX = xOffset;
		this.offsetY = yOffset;
	}
	
	private function get_left():Float
	{
		return x + offsetX;
	}
	
	private function get_right():Float
	{
		return x + offsetX + width;
	}
	
	private function get_top():Float
	{
		return y + offsetY;
	}
	
	private function get_bottom():Float
	{
		return y + offsetY + height;
	}
	
	override function drawDebugShape():Void 
	{
		super.drawDebugShape();
		_debugShape.graphics.clear();
		_debugShape.graphics.beginFill(Color.PINK, 0.4);
		_debugShape.graphics.drawRect(transform.x + offsetX, transform.y + offsetY, width, height);
		_debugShape.graphics.endFill();
	}
}