package ze.component.rendering;

import flash.display.DisplayObject;
import flash.geom.Rectangle;
import ze.component.core.Component;

/**
 * ...
 * @author Goh Zi He
 */
class Render extends Component
{
	public var alpha(get, set):Float;
	public var flipped(default, set):Bool;
	public var height(get, set):Float;
	public var layer(default, default):Int;
	public var mask(default, set):Render;
	public var scrollRect(default, set):Rectangle;
	public var visible(get, set):Bool;
	public var width(get, set):Float;
	public var offsetX(default, default):Float;
	public var offsetY(default, default):Float;
	public var displayObject(default, null):DisplayObject;
	
	public function new()
	{
		super();
		offsetX = 0;
		offsetY = 0;
		layer = 0;
	}
	
	override private function added():Void 
	{
		super.added();
		displayObject.cacheAsBitmap = true;
		scene.screen.addRender(this);
		update();
	}
	
	override private function update():Void 
	{
		super.update();
		
		if (flipped)
		{
			displayObject.x = (transform.x - scene.screen.offsetX) + displayObject.width + offsetX;
		}
		else
		{
			displayObject.x = transform.x - scene.screen.offsetX + offsetX;
		}
		
		displayObject.scaleX = transform.scaleX;
		displayObject.scaleY = transform.scaleY;
		displayObject.y = transform.y - scene.screen.offsetY + offsetY;
		displayObject.rotation = transform.rotation;
	}
	
	override private function removed():Void 
	{
		super.removed();
		scene.screen.removeRender(this);
	}
	
	override private function destroyed():Void 
	{
		super.destroyed();
		displayObject = null;
	}
	
	private function set_flipped(value:Bool):Bool
	{
		if (flipped == value) 
		{
			return flipped;
		}
		
		flipped = value;
		displayObject.scaleX = (value) ? -1 : 1;
		transform.scaleX = displayObject.scaleX;
		displayObject.x = (value) ? transform.x - scene.screen.offsetX + displayObject.width : transform.x - scene.screen.offsetX;
		return value;
	}
	
	private function get_visible():Bool
	{
		return displayObject.visible;
	}
	
	private function set_visible(value:Bool):Bool
	{
		displayObject.visible = value;
		return value;
	}
	
	private function get_width():Float
	{
		return displayObject.width;
	}
	
	private function set_width(value:Float):Float
	{
		displayObject.width = value;
		return value;
	}
	
	private function get_height():Float
	{
		return displayObject.height;
	}
	
	private function set_height(value:Float):Float
	{
		displayObject.height = value;
		return value;
	}
	
	private function set_mask(value:Render):Render
	{
		displayObject.mask = value.displayObject;
		mask = value;
		return value;
	}
	
	private function get_alpha():Float
	{
		return displayObject.alpha;
	}
	
	private function set_alpha(value:Float):Float
	{
		displayObject.alpha = value;
		return value;
	}
	
	private function set_scrollRect(value:Rectangle):Rectangle
	{
		scrollRect = displayObject.scrollRect = value;
		return value;
	}
}