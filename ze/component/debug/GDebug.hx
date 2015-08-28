package ze.component.debug;
import haxe.Timer;
import openfl.geom.Point;
import ze.component.core.Component;
import ze.component.graphic.displaylist.Text;
import ze.component.physics.BoxCollider;
import ze.component.physics.Collider;
import ze.object.GameObject;
import ze.object.Node;
import ze.util.Color;
import ze.util.Input;
import ze.util.Key;

/**
 * Game Debug. Include FPS information and also pausing/resume game(tab key).
 * When in pause mode, gameObject can be selected with mouse and move while
 * holding down shift/z key.
 * @author Goh Zi He
 */
class GDebug extends Component
{
	private var _debugMode:Bool;
	private var _memory:Float;
	private var _fpsText:Text;
	private var _pausedText:Text;
	private var _positionText:Text;
	private var _helpText:Text;
	
	private var _times:Array<Float>;
	private var _selectedGameObject:GameObject;
	private var _debugCallBack:GameObject -> Void;
	
	private static var _consoleText:Text;
	
	private var _oldPos:Point;
	
	override public function added():Void 
	{
		super.added();
		_times = [];
		_debugMode = false;
		
		_oldPos = new Point();
		
		_fpsText = new Text("FPS: ", Color.WHITE, 15);
		scene.createGameObject("fps", _fpsText, 300);
		
		_pausedText = new Text("Paused", Color.WHITE, 15);
		_pausedText.visible = _debugMode;
		scene.createGameObject("debug", _pausedText, scene.screen.right - 60, 0);
		
		_positionText = new Text("X: - Y: - ", Color.WHITE, 15);
		_positionText.visible = _debugMode;
		scene.createGameObject("Position", _positionText, scene.screen.right - 110, scene.screen.bottom - 20);
		
		_helpText = new Text("Select with mouse and move item when Z/Ctrl key is pressed.", Color.WHITE, 15);
		_helpText.visible = _debugMode;
		scene.createGameObject("Help", _helpText, 0, scene.screen.bottom - 20);
		
		_consoleText = new Text("Debug: Press Tilde key to pause game and move things around.", Color.WHITE, 15);
		scene.createGameObject("Console", _consoleText, 0, scene.screen.bottom - 20);
		
		scene.createGameObject("Logo", new Text("ZE2D Game Engine v" + Engine.version, Color.WHITE, 15));
	}
	
	override public function update():Void 
	{
		super.update();
		showFPS();
		
		if (Input.keyPressed(Key.BACKTICK))
		{
			if (_debugMode)
			{
				enableAllGameObject();
			}
			else
			{
				disableAllGameObject();
			}
			
			// Toggle collider debug shapes
			Collider.toggleAllDebugShape(_debugMode);
			
			// Show/Hide the text
			_pausedText.visible = _debugMode;
			_positionText.visible = _debugMode;
			_helpText.visible = _debugMode;
			_consoleText.visible = !_debugMode;
		}
		
		if (_debugMode)
		{
			if (Input.leftMousePressed())
			{
				selectGameObject();
				if (Input.keyDown(Key.SPACEBAR))
				{
					_oldPos.x = Input.mouseX;
					_oldPos.y = Input.mouseY;
				}
			}
			else if (Input.leftMouseDown())
			{
				if (Input.keyDown(Key.Z) || Input.keyDown(Key.SHIFT) || Input.keyDown(Key.CTRL))
				{
					if (_selectedGameObject != null)
					{	
						_selectedGameObject.transform.x = Input.mouseX - (_selectedGameObject.graphic.width * 0.5);
						_selectedGameObject.transform.y = Input.mouseY - (_selectedGameObject.graphic.height * 0.5);
						
						if (_selectedGameObject.collider != null)
						{
							_selectedGameObject.collider.update();
						}
					}
				}
				else if (Input.keyDown(Key.SPACEBAR))
				{
					scene.screen.shift(_oldPos.x - Input.mouseX, _oldPos.y - Input.mouseY);
					_oldPos.x = Input.mouseX;
					_oldPos.y = Input.mouseY;
				}
			}
			else if (Input.leftMouseReleased())
			{
				if (_selectedGameObject != null)	
				{
					printSelectObjectPosition();
				}
				_selectedGameObject = null;
			}
			
			if (Input.keyPressed(Key.R))
			{
				// Reset view
				scene.screen.setXY(0, 0);
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
		
		#if flash
		_memory = Math.ffloor(openfl.system.System.totalMemory / 1024 / 512);
		_fpsText.setText("FPS: " + _times.length + " Memory: " + _memory + " MB");
		#else
		_fpsText.setText("FPS: " + _times.length);
		#end
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
								printSelectObjectPosition();
								
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
								printSelectObjectPosition();
								
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
		
		_positionText.setText("X: - Y: - ");
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
	}
	
	private function disableAllGameObject():Void
	{
		_debugMode = true;
		
		var node:Node = scene._child.first;
		while (node != null)
		{
			var current:GameObject = cast (node, GameObject);
			if (current != gameObject && current.enable)
			{
				current.enable = false;
			}
			node = node._next;
		}
	}
	
	public function registerCallBack(debugCallBack:GameObject -> Void):Void
	{
		_debugCallBack = debugCallBack;	
	}
	
	public static function logMsg(item:Dynamic):Void
	{
		#if debug
		var message:String = "Debug: ";
		if (Std.is(item, Int) || Std.is(item, Float) || Std.is(item, String))
		{
			message += item;
		}
		_consoleText.setText(message);
		trace(message);
		#end
	}
	
	private function printSelectObjectPosition():Void
	{
		_positionText.setText("X: " + Math.round(_selectedGameObject.transform.x) + " Y: " + Math.round(_selectedGameObject.transform.y));
	}
}