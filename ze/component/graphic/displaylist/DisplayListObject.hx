package ze.component.graphic.displaylist;
import openfl.display.DisplayObject;
import openfl.geom.Rectangle;
import ze.component.graphic.Graphic;

/**
 * ...
 * @author Goh Zi He
 */
class DisplayListObject extends Graphic
{
	public var alpha(get, set):Float;
	public var mask(default, set):DisplayListObject;
	public var scrollRect(default, set):Rectangle;
	public var displayObject(default, null):DisplayObject;
	
	override public function added():Void 
	{
		super.added();
		scene.engine.addChild(displayObject);
		update();
	}
	
	override public function update():Void 
	{
		super.update();
		if (displayObject == null)
		{
			return;
		}
		
		if (flipped)
		{
			displayObject.x = transform.x + displayObject.width + offsetX;
		}
		else
		{
			displayObject.x = transform.x + offsetX;
		}
		
		displayObject.y = transform.y + offsetY;
		displayObject.scaleX = transform.scaleX;
		displayObject.scaleY = transform.scaleY;
		displayObject.rotation = transform.rotation;
		
		if (width == 0 || height == 0)
		{
			width = displayObject.width;
			height = displayObject.height;
		}
	}
	
	override public function removed():Void 
	{
		super.removed();
		scene.engine.removeChild(displayObject);
	}
	
	override public function destroyed():Void 
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
	
	private function set_mask(value:DisplayListObject):DisplayListObject
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
	
	override function set_visible(value:Bool):Bool 
	{
		if (displayObject != null)
		{
			displayObject.visible = value;
		}
		return super.set_visible(value);
	}
}