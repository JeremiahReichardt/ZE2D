package ze.util;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Stage;
import flash.geom.Point;
import flash.geom.Rectangle;
import haxe.ds.StringMap;
import openfl.display.Tilesheet;
import ze.object.Scene;

/**
 * ...
 * @author Goh Zi He
 */
class Screen
{
	public var offsetX(default, null):Float;
	public var offsetY(default, null):Float;
	public var top(get, null):Float;
	public var bottom(get, null):Float;
	public var left(get, null):Float;
	public var right(get, null):Float;
	public var midX(get, null):Float;
	public var midY(get, null):Float;
	public var width(get, null):Float;
	public var height(get, null):Float;
	
	private var _maxLayer:Int;
	private var _scene:Scene;
	private var _x:Float;
	private var _y:Float;
	private var _tileSheet:Tilesheet;
	private var _sprites:StringMap<Int>;
	private var _multipleSprites:StringMap<Array<Int>>;
	private var _tileLayer:Array<Array<Float>>;
	private var _graphics:Graphics;
	
	public function new(scene:Scene)
	{
		_x = 0;
		_y = 0;
		_scene = scene;
		_tileLayer = [[]];
		_graphics = scene.engine.current.graphics;
		_sprites = new StringMap<Int>();
		_multipleSprites = new StringMap<Array<Int>>();
		
		var stage:Stage = scene.engine.current.stage;
		offsetX = midX = stage.stageWidth >> 1;
		offsetY = midY = stage.stageHeight >> 1;
	}
	
	public function addToDraw(layer:Int, tileData:Array<Float>):Int
	{
		if (layer > _tileLayer.length + 1)
		{
			layer = _tileLayer.length + 1;
		}
		
		if (_tileLayer[layer] == null)
		{
			_tileLayer[layer] = [];
		}
		_tileLayer[layer] = _tileLayer[layer].concat(tileData);
		return layer;
	}
	
	public function draw():Void 
	{
		_graphics.clear();
		for (i in 0 ... _tileLayer.length)
		{
			if (_tileLayer[i] == null)
			{
				continue;
			}
			_tileSheet.drawTiles(_graphics, _tileLayer[i]);
			_tileLayer[i] = [];
		}
	}
	
	public function getRect(index):Rectangle
	{
		return _tileSheet.getTileRect(index);
	}
	
	public function addRect(name:String, rect:Rectangle, centerPoint:Point = null):Void
	{
		var tileIndex:Int = _tileSheet.addTileRect(rect, centerPoint);
		_sprites.set(name, tileIndex);
	}
	
	public function addTileRect(tileName:String, x:Float, y:Float, tileWidth:Float, tileHeight:Float, maxWidth:Float, maxHeight:Float, centerPoint:Point = null):Void
	{
		var row:Int =  Math.floor(maxHeight / tileHeight);
		var column:Int = Math.floor(maxWidth / tileWidth);
		
		var array:Array <Int> = [];
		for (r in 0 ... row)
		{
			for (c in 0 ... column)
			{
				var rectangle:Rectangle = new Rectangle(x + (c * tileWidth), y + (r * tileHeight), tileWidth, tileHeight);
				array.push(_tileSheet.addTileRect(rectangle));
			}
		}
		_multipleSprites.set(tileName, array);
	}
	
	public function loadTileSheet(bitmapData:BitmapData):Void
	{
		_tileSheet = new Tilesheet(bitmapData);
	}
	
	public function getTileID(tileName:String):Int
	{
		if (_sprites.exists(tileName))
		{
			return _sprites.get(tileName);
		}
		else
		{
			trace("No tile named: " + tileName + " is found.");
			return 0;
		}
	}
	
	public function getTileIndices(tileName:String):Array<Int>
	{
		if (_multipleSprites.exists(tileName))
		{
			return _multipleSprites.get(tileName);
		}
		else
		{
			trace("No tile named: " + tileName + " is found.");
			return null;
		}
	}
	
	public function removed():Void 
	{
		_scene = null;
		_tileSheet = null;
		_tileLayer = null;
		_graphics = null;
		_sprites = null;
		_multipleSprites = null;
	}
	
	private function get_top():Float
	{
		return _y;
	}
	
	private function get_bottom():Float
	{
		return (_y + _scene.engine.current.stage.stageHeight);
	}
	
	private function get_left():Float
	{
		return _x;
	}
	
	private function get_right():Float
	{
		return (_x + _scene.engine.current.stage.stageWidth);
	}
	
	private function get_midX():Float
	{
		return (right * 0.5);
	}
	
	private function get_midY():Float
	{
		return (bottom * 0.5);
	}
	
	private function get_width():Float
	{
		return _scene.engine.current.stage.stageWidth;
	}
	
	private function get_height():Float
	{
		return _scene.engine.current.stage.stageHeight;
	}
}