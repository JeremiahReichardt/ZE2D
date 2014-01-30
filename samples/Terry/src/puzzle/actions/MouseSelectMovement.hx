package puzzle.actions;

import ze.component.core.Component;
import ze.util.Input;

/**
 * ...
 * @author Goh Zi He
 */
class MouseSelectMovement extends Component
{
	private var _isMoving:Bool;
	private var _player:Player;
	
	override private function added():Void 
	{
		super.added();
		_player = getComponent(Player);
	}
	
	override private function update():Void 
	{
		if (Input.leftMouseDown() && inEntity())
		{
			disableSeletedEntity();
		}
		
		if (Input.leftMouseReleased())
		{
			enableSelectedEntity();
		}
		
		if (_isMoving)
		{
			gameObject.transform.setPos(Input.mouseX, Input.mouseY);
		}
		super.update();
	}
	
	private function inEntity():Bool 
	{
		var x:Float = transform.x;
		var y:Float = transform.y;
		var mx:Float = Input.mouseX;
		var my:Float = Input.mouseY;
		var width:Float = render.width;
		var height:Float = render.height;
		return (mx > x && mx < x + width && my > y && y < y + height);
	}
	
	private function enableSelectedEntity():Void
	{	
		_player.enable = true;
		_isMoving = false;
	}
	
	private function disableSeletedEntity():Void
	{
		_player.enable = false;
		_isMoving = true;
	}
}