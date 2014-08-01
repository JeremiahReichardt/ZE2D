package ze.component.debug;
import haxe.Timer;
import openfl.system.System;
import ze.component.core.Component;
import ze.component.graphic.displaylist.Text;
import ze.component.physics.BoxCollider;
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
	
	private var _fpsText:Text;
	private var _times:Array<Float>;
	private var _memory:Float;
	
	private var _fpsGameObject:GameObject;
	private var _debugGameObject:GameObject;
	
	override public function added():Void 
	{
		super.added();
		
		_times = [];
		
		_fpsText = new Text("FPS: ", Color.WHITE);
		_fpsGameObject = scene.createGameObject("fps", _fpsText);
		
		_debugText = new Text("Paused", Color.WHITE);
		_debugGameObject = scene.createGameObject("debug", _debugText, scene.screen.right - 75, 0);
		_debugMode = false;
		_debugText.visible = _debugMode;
	}
	
	override public function update():Void 
	{
		super.update();
		showFPS();
		
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
			
			if (Input.leftMouseDown() && (Input.keyDown(Key.Z) || Input.keyDown(Key.SHIFT)))
			{
				if (_selectedGameObject != null)
				{
					_selectedGameObject.transform.x = Input.mouseX - (_selectedGameObject.graphic.width * 0.5);
					_selectedGameObject.transform.y = Input.mouseY - (_selectedGameObject.graphic.height * 0.5);
					_selectedGameObject.graphic.update();
					_selectedGameObject.collider.update();
				}
			}
			
			if (Input.leftMouseReleased())
			{
				_selectedGameObject = null;
			}
		}
	}
	
	private function showFPS():Void
	{
		var now:Float = Timer.stamp();
		_times.push(now);
		
		while (_times[0] < now - 1)
		{
			_times.shift();
		}
		
		_memory = Math.ffloor(System.totalMemory / 1024 / 512);
		_fpsText.setText("FPS: " + _times.length + " Memory: " + _memory + " MB");
	}
	
	private function selectGameObject():Void
	{
		var mouseX:Float = Input.mouseX;
		var mouseY:Float = Input.mouseY;
			
		var node:Node = scene._child.first;
		while (node != null)
		{
			var current:GameObject = cast (node, GameObject);
			if (current.graphic != null)
			{
				var x:Float = current.transform.x + current.graphic.offsetX;
				var y:Float = current.transform.y + current.graphic.offsetY;
				var width:Float = current.graphic.width;
				var height:Float = current.graphic.height;
				
				if (mouseX > x)
				{
					if (mouseX < x + width)
					{
						if (mouseY > y)
						{
							if (mouseY < y + height)
							{
								_selectedGameObject = current;
								if (_debugCallBack != null)
								{
									_debugCallBack(current);
								}
								return;
							}
						}
					}
				}
			}
			else if (current.collider != null && Std.is(current.collider, BoxCollider))
			{
				var x:Float = current.transform.x + current.collider.offsetX;
				var y:Float = current.transform.y + current.collider.offsetY;
				var width:Float = cast(current.collider, BoxCollider).width;
				var height:Float = cast(current.collider, BoxCollider).height;
				
				if (mouseX > x)
				{
					if (mouseX < x + width)
					{
						if (mouseY > y)
						{
							if (mouseY < y + height)
							{
								_selectedGameObject = current;
								if (_debugCallBack != null)
								{
									_debugCallBack(current);
								}
								return;
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
		_fpsGameObject.enable = false;
		_debugGameObject.enable = false;
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
		_fpsGameObject.enable = true;
		_debugGameObject.enable = true;
	}
	
	public function registerCallBack(debugCallBack:GameObject -> Void):Void
	{
		_debugCallBack = debugCallBack;	
	}
}