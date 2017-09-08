package ze.component.graphic;
import ze.component.core.Component;

/**
 * ...
 * @author Goh Zi He
 */
class Graphic extends Component
{
	public var offsetX:Float;
	public var offsetY:Float;
	public var x(get, null):Float;
	public var y(get, null):Float;
	public var width(get, null):Float;
	public var height(get, null):Float;
	public var layer(default, set):Int;
	public var halfWidth(get, null):Float;
	public var halfHeight(get, null):Float;
	public var visible(default, set):Bool;
	public var centered(default, set):Bool;
	public var flipped(default, default):Bool;
	public var scaleX(get, set):Float;
	public var scaleY(get, set):Float;
	
	public function new()
	{
		super();
		x = 0;
		y = 0;
		offsetX = 0;
		offsetY = 0;
		width = 0;
		height = 0;
		flipped = false;
		visible = true;
		centered = false;
	}
	
	public function setOffset(x:Float = 0, y:Float = 0):Void
	{
		offsetX = x;
		offsetY = y;
	}
	
	private function get_x():Float
	{
		return transform.x + offsetX;
	}
	
	private function get_y():Float
	{
		return transform.x + offsetY;
	}
  
	private function get_width():Float
	{
		return width * scaleX;
	}
	
	private function get_height():Float
	{
		return height * scaleY;
	}
	
	private function get_halfWidth():Float
	{
		return (width * 0.5);
	}
	
	private function get_halfHeight():Float
	{
		return (height * 0.5);
	}
	
	private function set_layer(value:Int):Int
	{
		layer = value;
		return value;
	}
	
	private function set_centered(value:Bool):Bool
	{
		centered = value;
		if (centered)
		{
			offsetX = -halfWidth;
			offsetY = -halfHeight;
		}
		else
		{
			offsetX = 0;
			offsetY = 0;
		}
		return centered;
	}
	
	private function set_visible(value:Bool):Bool
	{
		visible = value;
		return visible;
	}
	
	function get_scaleX():Float 
	{
		return 1.0;
	}
	
	function set_scaleX(value:Float):Float 
	{
		return value;
	}
	
	function get_scaleY():Float 
	{
		return 1.0;
	}
	
	function set_scaleY(value:Float):Float 
	{
		return value;
	}
	
	public function draw():Void
	{
	}
}