package ze.component.graphic.displaylist;
import openfl.display.Bitmap;
import openfl.display.BitmapData;

/**
 * ...
 * @author Goh Zi He
 */
class BitmapObject extends DisplayListObject
{
	private var _bitmap:Bitmap;
	
	public function new()
	{
		super();
		_bitmap = new Bitmap();
		displayObject = _bitmap;
	}
	
	private function setBitmapData(bitmapData:BitmapData):Void
	{
		_bitmap.bitmapData = bitmapData;
	}
	
	override public function destroyed():Void 
	{
		super.destroyed();
		
		_bitmap.bitmapData = null;
		_bitmap = null;
	}
}