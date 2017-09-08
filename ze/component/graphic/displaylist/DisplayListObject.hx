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
	public var scrollRect(default, set):Rectangle;
	public var mask(default, set):DisplayListObject;
	public var displayObject(default, null):DisplayObject;
	
	override public function added():Void 
	{
		super.added();
		scene.screen.addChild(displayObject);
		update();
		layer = 0;
	}
	
	override public function draw():Void 
	{
		super.draw();
		if (displayObject == null)
		{
			return;
		}
		
		if (flipped)
		{
			displayObject.scaleX = -scaleX;
			displayObject.x = transform.x + displayObject.width + offsetX;
		}
		else
		{
			displayObject.scaleX = scaleX;
			displayObject.x = transform.x + offsetX;
		}
		
		displayObject.y = transform.y + offsetY;
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
		scene.screen.removeChild(displayObject);
	}
	
	override public function destroyed():Void 
	{
		super.destroyed();
		displayObject = null;
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
	
	override function set_layer(value:Int):Int 
	{
		scene.screen.sortDisplayObject();
		return super.set_layer(value);
	}
	
	override function get_scaleX():Float 
	{
		return displayObject.scaleX;
	}
	
	override function set_scaleX(value:Float):Float 
	{
		displayObject.scaleX = value;
		set_centered(true);
		return value;
	}
	
	override function get_scaleY():Float 
	{
		return displayObject.scaleY;
	}
	
	override function set_scaleY(value:Float):Float 
	{
		displayObject.scaleY = value;
		set_centered(true);
		return value;
	}
}