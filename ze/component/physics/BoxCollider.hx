package ze.component.physics;
import ze.component.physics.BoxCollider;
import ze.component.physics.Collider;

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
	public function new(width:Float, height:Float, trigger:Bool = false) 
	{
		super(trigger);
		this.width = width;
		this.height = height;
	}
	
	private function get_left():Float
	{
		return x;
	}
	
	private function get_right():Float
	{
		return x + width;
	}
	
	private function get_top():Float
	{
		return y;
	}
	
	private function get_bottom():Float
	{
		return y + height;
	}
}