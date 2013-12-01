package ze.component.core;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import ze.component.core.Component;
import ze.component.rendering.Render;
import ze.util.FPS;

/**
 * ...
 * @author Goh Zi He
 */
class Screen extends Component
{
	public var offsetX(default, null):Float;
	public var offsetY(default, null):Float;
	public var top(get, null):Float;
	public var bottom(get, null):Float;
	public var left(get, null):Float;
	public var right(get, null):Float;
	
	private var _sprite:Sprite;
	private var _current:MovieClip;
	private var _fps:FPS;
	
	private var _layers:Array<Array<Render>>;
	private var _maxLayer:Int;
	
	public function new()
	{
		super();
		_current = Lib.current;
		_sprite = new Sprite();
		_current.addChild(_sprite);
		
		var stage:Stage = _current.stage;
		stage.align = StageAlign.LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		
		_sprite.x = offsetX = stage.stageWidth >> 1;
		_sprite.y = offsetY = stage.stageHeight >> 1;
		
		_fps = new FPS( -offsetX, -offsetY, 24, 0xFFFFFF);
		_sprite.addChild(_fps);
		_layers = [[]];
	}
	
	
	private function get_top():Float
	{
		return transform.y;
	}
	
	private function get_bottom():Float
	{
		return transform.y + _current.stage.stageHeight;
	}
	
	private function get_left():Float
	{
		return transform.x;
	}
	
	private function get_right():Float
	{
		return transform.x + _current.stage.stageWidth;
	}
	
	override private function update():Void 
	{
		super.update();
		
		_sprite.x = transform.x + offsetX;
		_sprite.y = transform.y + offsetY;
		_sprite.rotation = transform.rotation;
		
		for (i in 0 ... _maxLayer + 1)
		{
			if (_layers[i] == null)
			{
				continue;
			}
			
			for (j in 0 ... _layers[i].length)
			{
				if (_layers[i][j].layer != i)
				{
					removeRender(_layers[i][j]);
					addRender(_layers[i][j]);
				}
			}
		}
	}
	
	public function hideFPS():Void
	{
		_fps.visible = false;
	}
	
	public function showFPS():Void
	{
		_fps.visible = true;
	}
	
	public function addRender(render:Render):Void
	{
		if (_layers[render.layer] == null)
		{
			_layers[render.layer] = [];
			if (render.layer > _maxLayer)
			{
				_maxLayer = render.layer;
			}
		}
		
		var index:Int = 0;
		for (i in 0 ... _maxLayer)
		{
			if (_layers[i] == null)
			{
				continue;
			}
			
			index += _layers[i].length;
		}
		_sprite.addChildAt(render.displayObject, index);
		_layers[render.layer].push(render);
	}
	
	public function removeRender(render:Render):Void
	{
		if (render.displayObject == null)
		{
			return;
		}
		_sprite.removeChild(render.displayObject);
		_layers[render.layer].remove(render);
	}
	
	override private function removed():Void 
	{
		super.removed();
		_current.removeChild(_sprite);
		
		_sprite = null;
		_current = null;
		_fps = null;
		_layers = null;
	}
}