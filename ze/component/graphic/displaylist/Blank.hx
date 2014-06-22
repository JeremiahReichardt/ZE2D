package ze.component.graphic.displaylist;
import openfl.display.BitmapData;
import ze.util.Color;

/**
 * ...
 * @author Goh Zi He
 */
class Blank extends BitmapObject
{
	public function new(width:Int, height:Int, color:Int = Color.WHITE) 
	{
		super();
		setBitmapData(new BitmapData(width, height, true, color));
	}
	
	override private function destroyed():Void 
	{
		_bitmap.bitmapData.dispose();
		super.destroyed();
	}
}