package ze.util;
import openfl.display.Graphics;
import openfl.display.Stage;
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
	
	private var _tileSheetLayers:Array<TileSheetLayer>;
	private var _scene:Scene;
	private var _graphics:Graphics;
	private var _x:Float;
	private var _y:Float;
	
	public function new(scene:Scene)
	{
		_x = 0;
		_y = 0;
		_scene = scene;
		_graphics = scene.engine.graphics;
		
		var stage:Stage = scene.engine.stage;
		offsetX = midX = stage.stageWidth >> 1;
		offsetY = midY = stage.stageHeight >> 1;
		
		_tileSheetLayers = [];
	}
	
	public function draw():Void 
	{
		_graphics.clear();
		for (layer in _tileSheetLayers)
		{
			layer.draw();
		}
	}
	
	public function addLayer(layer:TileSheetLayer):Void
	{
		_tileSheetLayers.push(layer);
		layer.graphics = _graphics;
	}
	
	public function getLayer(name:String):TileSheetLayer
	{
		for (layer in _tileSheetLayers)
		{
			if (layer.spriteExist(name))
			{
				return layer;
			}
		}
		
		return null;
	}
	
	public function removed():Void 
	{
		_scene = null;
		_graphics = null;
	}
	
	private function get_top():Float
	{
		return _y;
	}
	
	private function get_bottom():Float
	{
		return (_y + _scene.engine.stage.stageHeight);
	}
	
	private function get_left():Float
	{
		return _x;
	}
	
	private function get_right():Float
	{
		return (_x + _scene.engine.stage.stageWidth);
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
		return _scene.engine.stage.stageWidth;
	}
	
	private function get_height():Float
	{
		return _scene.engine.stage.stageHeight;
	}
}