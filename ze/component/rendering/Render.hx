package ze.component.rendering;

import flash.display.DisplayObject;
import flash.geom.Rectangle;
import ze.component.core.Component;

/**
 * ...
 * @author Goh Zi He
 */
class Render extends Draw
{
	public var alpha(get, set):Float;
	public var mask(default, set):Render;
	public var scrollRect(default, set):Rectangle;
	public var displayObject(default, null):DisplayObject;
	
	override private function added():Void 
	{
		super.added();
		
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
		
		displayObject.visible = visible;
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
	
	override private function set_flipped(value:Bool):Bool
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
	
	override private function get_width():Float
	{
		return displayObject.width;
	}
	
	override private function get_height():Float
	{
		return displayObject.height;
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
	
	override private function set_layer(value:Int):Int
	{
		if (gameObject != null && scene != null)
		{
			scene.screen.removeRender(this);
			layer = value;
			scene.screen.addRender(this);
		}
		else
		{
			layer = value;
		}
		return value;
	}
}