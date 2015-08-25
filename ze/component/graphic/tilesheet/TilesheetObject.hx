package ze.component.graphic.tilesheet;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import ze.component.graphic.Graphic;
import ze.util.Screen;
import ze.util.TileSheetLayer;

/**
 * ...
 * @author Goh Zi He
 */
class TilesheetObject extends Graphic
{
	private var _name:String;
	private var _tileID:Int;
	private var _screen:Screen;
	private var _tileData:Array<Float>;
	private var _tileSheetLayer:TileSheetLayer;
	
	public function new(name:String) 
	{
		super();
		_name = name;
		_tileData = [];
	}
	
	override function added():Void 
	{
		super.added();
		_screen = scene.screen;
		_tileSheetLayer = _screen.getLayer(_name);
	}
	
	override function draw():Void 
	{
		super.draw();
		if (_tileSheetLayer == null)
		{
			return;
		}
		
		if (width == 0 || height == 0)
		{
			var rect:Rectangle = _tileSheetLayer.getTileRect(_tileID);
			width = rect.width;
			height = rect.height;
		}
		
		var index:Int = 0;
		
		if (transform.rotation == 0)
		{
			_tileData[index++] = flipped ? transform.x + width : transform.x;
			_tileData[index++] = transform.y;
			_tileData[index++] = _tileID;
			_tileData[index++] = flipped ? -1 : 1;
			_tileData[index++] = 0;
			_tileData[index++] = 0;
			_tileData[index++] = 1;
		}
		else
		{
			var sign:Int = flipped ? -1 : 1;
			var matrix:Matrix = new Matrix();
			matrix.identity();
			matrix.scale(1, sign);
			matrix.rotate(transform.rotation);
			
			_tileData[index++] = flipped ? transform.x + width : transform.x;
			_tileData[index++] = transform.y;
			_tileData[index++] = _tileID;
			_tileData[index++] = matrix.a;
			_tileData[index++] = matrix.b;
			_tileData[index++] = matrix.c;
			_tileData[index++] = matrix.d;
		}
		
		layer = _tileSheetLayer.addToDraw(layer, _tileData);
	}
}