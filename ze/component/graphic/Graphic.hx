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
	public var layer(default, set):Int;
	public var flipped(default, default):Bool;
	public var visible(default, default):Bool;
	
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
	}
	
	override function removed():Void 
	{
		super.removed();
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
}