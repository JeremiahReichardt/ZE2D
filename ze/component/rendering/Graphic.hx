package ze.component.rendering;

import flash.display.Bitmap;
import flash.display.BitmapData;

/**
 * ...
 * @author Goh Zi He
 */
class Graphic extends Render
{
	private var _bitmap:Bitmap;
	
	public function new()
	{
		super();
		_bitmap = new Bitmap();
		displayObject = _bitmap;
	}
	
	private function setBitmapData(bitmapData:BitmapData)
	{
		_bitmap.bitmapData = bitmapData;
	}
	
	override private function destroyed():Void 
	{
		super.destroyed();
		
		_bitmap.bitmapData = null;
		_bitmap = null;
	}
}