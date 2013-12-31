package ze.component.ui;

import ze.component.core.Component;
import ze.util.Input;

/**
 * ...
 * @author Goh Zi He
 */
class UI extends Component
{
	private var _width:Float;
	private var _height:Float;
	private var _entered:Bool;
	
	private var _name:String;
	
	public function new(width:Float, height:Float)
	{
		super();
		_width = width;
		_height = height;
	}
	
	override private function update():Void 
	{
		super.update();
		
		if (inUI())
		{
			if (!_entered)
			{
				_entered = true;
				onEnter();
			}
			onOver();
		}
		else if (!inUI() && _entered)
		{
			_entered = false;
			onExit();
		}
	}
	
	private function inUI():Bool
	{
		if (Input.mouseX > transform.x)
		{
			if (Input.mouseX < transform.x + _width)
			{
				if (Input.mouseY > transform.y)
				{
					if (Input.mouseY < transform.y + _height)
					{
						return true;
					}
				}
			}
		}
		return false;
	}
	
	private function onEnter():Void
	{
	}
	
	private function onExit():Void
	{
	}
	
	private function onOver():Void
	{
	}
}