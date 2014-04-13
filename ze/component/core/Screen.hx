package ze.component.core;
import flash.display.Sprite;
import flash.display.Stage;
import ze.component.core.Component;
import ze.component.rendering.Render;

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
	public var midX(get, null):Float;
	public var midY(get, null):Float;
	public var width(get, null):Float;
	public var height(get, null):Float;
	
	private var _root:Sprite;
	
	private var _layers:Array<Array<Render>>;
	private var _maxLayer:Int;
	
	public function new()
	{
		super();
		
		_layers = [[]];
		_root = new Sprite();
		engine.current.addChild(_root);
		
		var stage:Stage = engine.current.stage;
		_root.x = offsetX = midX = stage.stageWidth >> 1;
		_root.y = offsetY = midY = stage.stageHeight >> 1;
	}
	
	override private function update():Void 
	{
		super.update();
		
		_root.x = transform.x + offsetX;
		_root.y = transform.y + offsetY;
		_root.rotation = transform.rotation;
		
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
		_root.addChildAt(render.displayObject, index);
		_layers[render.layer].push(render);
	}
	
	public function removeRender(render:Render):Void
	{
		if (render.displayObject == null)
		{
			return;
		}
		_root.removeChild(render.displayObject);
		_layers[render.layer].remove(render);
	}
	
	override private function removed():Void 
	{
		super.removed();
		
		engine.current.removeChild(_root);
	}
	
	override private function destroyed():Void 
	{
		super.destroyed();
		
		_root = null;
		_layers = null;
	}
	
	private function get_top():Float
	{
		return transform.y;
	}
	
	private function get_bottom():Float
	{
		return (transform.y + engine.current.stage.stageHeight);
	}
	
	private function get_left():Float
	{
		return transform.x;
	}
	
	private function get_right():Float
	{
		return (transform.x + engine.current.stage.stageWidth);
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
		return engine.current.stage.stageWidth;
	}
	
	private function get_height():Float
	{
		return engine.current.stage.stageHeight;
	}
}