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
 * holding down ctrl/z key, and snapping with shift key.
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
	
	private static inline var TEXTLAYER:Int = 20;
	
	override public function added():Void 
	{
		super.added();
		_times = [];
		_debugMode = false;
		
		_oldPos = new Point();
		
		_fpsText = new Text("FPS: ", Color.WHITE, 15);
		scene.createGameObject("fps", _fpsText, 240);
		_fpsText.layer = TEXTLAYER;
		
		_pausedText = new Text("Paused", Color.WHITE, 15);
		scene.createGameObject("debug", _pausedText, scene.screen.right - 60, 0);
		_pausedText.visible = _debugMode;
		_pausedText.layer = TEXTLAYER;
		
		_positionText = new Text("X: - Y: - ", Color.WHITE, 15);
		scene.createGameObject("Position", _positionText, scene.screen.right - 110, scene.screen.bottom - 20);
		_positionText.visible = _debugMode;
		_positionText.layer = TEXTLAYER;
		
		_helpText = new Text("Select and move item with Z/Ctrl.", Color.WHITE, 15);
		scene.createGameObject("Help", _helpText, 0, scene.screen.bottom - 20);
		_helpText.visible = _debugMode;
		_helpText.layer = TEXTLAYER;
		
		_consoleText = new Text("Press tilde to pause and move things around.", Color.WHITE, 15);
		scene.createGameObject("Console", _consoleText, 0, scene.screen.bottom - 20);
		_consoleText.layer = TEXTLAYER;
		
		var logo:Text = new Text("ZE2D Game Engine v" + Engine.version, Color.WHITE, 15);
		scene.createGameObject("Logo", logo);
		logo.layer = TEXTLAYER;
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
			toggleColliderDebugDraw(_debugMode);
			
			// Show/Hide the text
			_pausedText.visible = _debugMode;
			_positionText.visible = _debugMode;
			_helpText.visible = _debugMode;
			_consoleText.visible = !_debugMode;
		}
		else if (Input.keyPressed(Key.PAGEUP))
		{
			toggleColliderDebugDraw(true);
		}
		else if (Input.keyPressed(Key.PAGEDOWN))
		{
			toggleColliderDebugDraw(false);
		}
		
		if (_debugMode)
		{
			if (Input.keyPressed(Key.R))
			{
				// Reset view
				scene.screen.setXY(0, 0);
			}
			
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
				if (Input.keyDown(Key.Z) || Input.keyDown(Key.CTRL))
				{
					if (_selectedGameObject != null)
					{
            var graphic = _selectedGameObject.graphic;
						_selectedGameObject.transform.x = Input.mouseX - (graphic.width  * 0.5) - graphic.offsetX - scene.screen.left;
						_selectedGameObject.transform.y = Input.mouseY - (graphic.height * 0.5) - graphic.offsetY + scene.screen.top;
						
						if (_selectedGameObject.collider != null)
						{
							_selectedGameObject.collider.update();
						}
					}
				}
				else if (Input.keyDown(Key.SHIFT))
				{
					if (_selectedGameObject != null)
					{
						var width:Float;
						var height:Float;
						
						// Do snapping
						if (_selectedGameObject.graphic != null)
						{
							width = _selectedGameObject.graphic.width;
							height = _selectedGameObject.graphic.height;
						}
						else if (_selectedGameObject.collider != null)
						{
							width = _selectedGameObject.collider.width;
							height = _selectedGameObject.collider.height;
						}
						else 
						{
							return;
						}
						
						var x:Float = Math.ffloor(Input.mouseX / width) * width;
						var y:Float = Math.ffloor(Input.mouseY / height) * height;
						
						_selectedGameObject.transform.setPos(x, y);
					}
				}
				else if (Input.keyDown(Key.SPACEBAR))
				{
					scene.screen.shift(_oldPos.x - Input.mouseX, _oldPos.y - Input.mouseY);
					_oldPos.x = Input.mouseX;
					_oldPos.y = Input.mouseY;
          
          toggleColliderDebugDraw(true);
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
		_fpsText.setText("FPS: " + _times.length + " Mem: " + _memory + " MB");
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
			var current:GameObject = cast(node, GameObject);
      
      // Select the object based on the biggest size item (collider/graphics)
      var x:Float = 0.0;
			var y:Float = 0.0;
      var width:Float = 0.0;
      var height:Float = 0.0;
      
      if (current.graphic != null)
			{
				x = current.transform.x + current.graphic.offsetX;
				y = current.transform.y + current.graphic.offsetY;
				width = current.graphic.width;
				height = current.graphic.height;
      }
			
      if (current.collider != null && Std.is(current.collider, BoxCollider))
			{
				x = current.transform.x + current.collider.offsetX;
				y = current.transform.y + current.collider.offsetY;
				width = Math.max(cast(current.collider, BoxCollider).width, width);
				height = Math.max(cast(current.collider, BoxCollider).height, height);
      }
      
      x += scene.screen.left;
      y -= scene.screen.top;
      
      //trace(mouseX, mouseY, x, y);
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
			node = node._next;
		}
		
		_positionText.setText("X: - Y: - ");
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
	
	private function toggleColliderDebugDraw(toggle:Bool):Void
	{
		Collider.toggleAllDebugShape(toggle);
	}
}