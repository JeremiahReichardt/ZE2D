package ze.component.rendering;
import ze.component.core.Component;

/**
 * ...
 * @author Goh Zi He
 */
class Draw extends Component
{
	public var width(get, null):Float;
	public var height(get, null):Float;
	public var flipped(default, set):Bool;
	public var layer(default, set):Int;
	public var visible(default, default):Bool;
	public var offsetX(default, default):Float;
	public var offsetY(default, default):Float;
	
	public function new()
	{
		super();
		offsetX = 0;
		offsetY = 0;
		layer = 0;
		width = 0;
		height = 0;
		visible = true;
	}
	
	private function get_width():Float
	{
		return width;
	}
	
	private function get_height():Float
	{
		return height;
	}
	
	private function set_flipped(value:Bool):Bool
	{
		return value;
	}
	
	private function set_layer(value:Int):Int
	{
		return value;
	}
}