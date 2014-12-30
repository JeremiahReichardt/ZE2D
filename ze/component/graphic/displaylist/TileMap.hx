package ze.component.graphic.displaylist;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import ze.util.Color;

/**
 * ...
 * @author Goh Zi He
 */
class TileMap extends BitmapObject
{
	private var _tileData:BitmapData;
	private var _rect:Rectangle;
	private var _dest:Point;
	var _tileWidth:Int;
	var _tileHeight:Int;
	
	public function new(name:String, tileWidth:Int, tileHeight:Int, mapWidth:Int, mapHeight:Int, tileRow:Int, tileColumn:Int)
	{
		super();
		_dest = new Point();
		_tileWidth = tileWidth;
		_tileHeight = tileHeight;
		_rect = new Rectangle(0, 0, tileWidth, tileHeight);
		_tileData = Assets.getBitmapData("gfx/" + name + ".png");
		setBitmapData(new BitmapData(mapWidth, mapHeight, true, Color.TRANSPARENT));
	}
	
	public function setTile(column:Int, row:Int, tx:Int, ty:Int):Void
	{
		_rect.x = tx * _tileWidth;
		_rect.y = ty * _tileHeight;
		_dest.x = column * _tileWidth;
		_dest.y = row * _tileHeight;
		_bitmap.bitmapData.copyPixels(_tileData, _rect, _dest);
	}
	
	override public function removed():Void 
	{
		super.removed();
		_dest = null;
		_rect = null;
		_tileData.dispose();
		_tileData = null;
	}
}