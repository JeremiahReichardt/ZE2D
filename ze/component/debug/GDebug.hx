package ze.component.debug;

import ze.component.core.Component;
import ze.component.rendering.Text;
import ze.object.GameObject;
import ze.object.Node;
import ze.util.Color;
import ze.util.Input;
import ze.util.Key;

/**
 * ...
 * @author Goh Zi He
 */
class GDebug extends Component
{
	private var _debugMode:Bool;
	private var _debugText:Text;
	private var _debugCallBack:GameObject -> Void;
	private var _selectedGameObject:GameObject;
	
	override private function added():Void 
	{
		super.added();
		
		_debugMode = false;
		_debugText = new Text("Paused", Color.WHITE);
		addComponent(_debugText);
		_debugText.transform.x = scene.screen.right - 75;
		_debugText.transform.y = scene.screen.top;
		_debugText.visible = _debugMode;
	}
	
	override private function update():Void 
	{
		super.update();
		
		if (Input.keyPressed(Key.TAB))
		{
			if (_debugMode)
			{
				enableAllGameObject();
			}
			else
			{
				disableAllGameObject();
			}
			_debugText.visible = _debugMode;
		}
		
		if (_debugMode)
		{
			if (Input.leftMousePressed())
			{
				selectGameObject();
			}
			
			if (Input.leftMouseDown())
			{
				if (_selectedGameObject != null)
				{
					_selectedGameObject.transform.x = Input.mouseX - (_selectedGameObject.render.width * 0.5);
					_selectedGameObject.transform.y = Input.mouseY - (_selectedGameObject.render.height * 0.5);
					_selectedGameObject.render.update();
				}
			}
			
			if (Input.leftMouseReleased())
			{
				_selectedGameObject = null;
			}
		}
	}
	
	private function selectGameObject():Void
	{
		var mouseX:Float = Input.mouseX;
		var mouseY:Float = Input.mouseY;
			
		var node:Node = scene._child.first;
		while (node != null)
		{
			var gameObject:GameObject = cast (node, GameObject);
			if (gameObject.render != null)
			{
				var x:Float = gameObject.transform.x;
				var y:Float = gameObject.transform.y;
				var width:Float = gameObject.render.width;
				var height:Float = gameObject.render.height;
				
				if (mouseX > x)
				{
					if (mouseX < x + width)
					{
						if (mouseY > y)
						{
							if (mouseY < y + height)
							{
								if (_debugCallBack != null)
								{
									_selectedGameObject = gameObject;
									_debugCallBack(gameObject);
									return;
								}
								else
								{
									trace(gameObject.name);
								}
							}
						}
					}
				}
			}
			node = node._next;
		}
		return null;
	}
	
	private function enableAllGameObject():Void
	{
		_debugMode = false;
		
		var node:Node = scene._child.first;
		while (node != null)
		{
			var gameObject:GameObject = cast (node, GameObject);
			gameObject.enable = true;
			node = node._next;
		}
		return null;
	}
	
	private function disableAllGameObject():Void
	{
		_debugMode = true;
		
		var node:Node = scene._child.first;
		while (node != null)
		{
			var gameObject:GameObject = cast (node, GameObject);
			if (gameObject != this.gameObject && gameObject.enable)
			{
				gameObject.enable = false;
			}
			node = node._next;
		}
		return null;
	}
	
	public function registerCallBack(_debugCallBack:GameObject -> Void):Void
	{
		this._debugCallBack = _debugCallBack;	
	}
}