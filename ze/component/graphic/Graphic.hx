package ze.component.graphic;
import ze.component.core.Component;

/**
 * ...
 * @author Goh Zi He
 */
class Graphic extends Component
{
	public var x(get, null):Float;
	public var y(get, null):Float;
	public var offsetX(default, default):Float;
	public var offsetY(default, default):Float;
	public var width(get, null):Float;
	public var height(get, null):Float;
	public var halfWidth(get, null):Float;
	public var halfHeight(get, null):Float;
	public var layer(default, set):Int;
	public var flipped(default, default):Bool;
	public var visible(default, set):Bool;
	public var centered(default, set):Bool;
	
	public function new()
	{
		super();
		x = 0;
		y = 0;
		offsetX = 0;
		offsetY = 0;
		width = 0;
		height = 0;
		layer = 0;
		flipped = false;
		visible = true;
		centered = false;
	}
	
	private function get_x():Float
	{
		return transform.x - offsetX;
	}
	
	private function get_y():Float
	{
		return transform.x - offsetY;
	}
	
	private function get_width():Float
	{
		return width;
	}
	
	private function get_height():Float
	{
		return height;
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
	
	private function set_flipped(value:Bool):Bool
	{
		flipped = value;
		return flipped;
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
}