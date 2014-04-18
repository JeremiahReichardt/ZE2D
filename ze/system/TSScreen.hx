package ze.system;
import flash.display.Graphics;
import flash.geom.Point;
import flash.geom.Rectangle;
import haxe.ds.StringMap;
import openfl.Assets;
import openfl.display.Tilesheet;
import ze.Engine;

/**
 * ...
 * @author Goh Zi He
 */
class TSScreen
{
	private var _tileSheet:Tilesheet;
	private var _graphics:Graphics;
	private var _layers:Array<Array<Float>>;
	private var _section:StringMap<Int>;
	
	public function new() 
	{
		_layers = [[]];
		_graphics = Engine.getEngine().current.graphics;
		_section = new StringMap<Int>();
	}
	
	public function addToDraw(layer:Int, drawData:Array<Float>):Void
	{
		if (_layers[layer] == null)
		{
			_layers[layer] = [];
		}
		_layers[layer] = _layers[layer].concat(drawData);
	}
	
	public function draw():Void
	{
		if (_tileSheet == null)
		{
			return;
		}
		
		_graphics.clear();
		for (i in 0 ... _layers.length)
		{
			_tileSheet.drawTiles(_graphics, _layers[i]);
			_layers[i] = [];
		}
	}
	
	public function loadTileSheet(path:String):Void
	{
		_tileSheet = new Tilesheet(Assets.getBitmapData(path));
	}
	
	public function addRect(name:String, rectangle:Rectangle, centerPoint:Point = null):Void
	{
		var tileIndex:Int = _tileSheet.addTileRect(rectangle, centerPoint);
		_section.set(name, tileIndex);
	}
	
	public function getTileIndex(label:String):Int
	{
		return _section.get(label);
	}
	
	public function getTileIndices(label:String):Array<Int>
	{
		var i:Int = 0;
		var indices:Array<Int> = [];
		while (true)
		{
			if (_section.exists(label + i))
			{
				indices.push(_section.get(label + i));
			}
			
			++i;
			
			if (!_section.exists(label + i))
			{
				break;
			}
		}
		
		return indices;
	}
	
	public function getHighestLayer():Int
	{
		return _layers.length - 1;
	}
}