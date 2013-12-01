package ze.util;

import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

/**
 * Input for handling keypresses and mouse
 * @author Goh Zi He
 */

class Input 
{
	public static var mouseX(get, null):Float;
	public static var mouseY(get, null):Float;
	
	private static var _mouseX:Float;
	private static var _mouseY:Float;
	
	private static var _init:Bool;
	private static var _stage:Stage;
	
	private static var _currentKeyPressed:Int;
	private static var _currentKeyReleased:Int;
	private static var _lastKeyPressed:Int;
	private static var _keys:Array<Bool>;
	
	private static var _leftMouseDown:Bool;
	private static var _leftMousePressed:Bool;
	private static var _leftMouseReleased:Bool;
	private static var _rightMouseDown:Bool;
	private static var _rightMousePressed:Bool;
	private static var _rightMouseReleased:Bool;
	
	private static var _keyMap:Map<String, Array<Int>>;
	
	public static function init(stage:Stage):Void
	{
		if (_init)
		{
			return;
		}
		
		_init = true;
		
		_keys = [];
		_stage = stage;
		_keyMap = new Map < String, Array<Int> > ();
		_currentKeyPressed = -1;
		
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownEvent);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUpEvent);
		
		stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownEvent);
		stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpEvent);
		
		//stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, rightMouseDownEvent);
		//stage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, rightMouseUpEvent);
		
		addKey("left", [Key.A, Key.LEFT]);
	}
	
	public static function update():Void
	{
		if (_leftMousePressed)
		{
			_leftMousePressed = false;
		}
		
		if (_leftMouseReleased)
		{
			_leftMouseReleased = false;
		}
		
		//if (_rightMousePressed)
		//{
			//_rightMousePressed = false;
		//}
		//
		//if (_rightMouseReleased)
		//{
			//_rightMouseReleased = false;
		//}
		
		_mouseX = _stage.mouseX;
		_mouseY = _stage.mouseY;
		_lastKeyPressed = _currentKeyPressed;
	}
	
	public static function addKey(name:String, ?key:Int, ?keys:Array<Int>):Void
	{
		if (_keyMap.exists(name))
		{
			_keyMap.get(name).push(key);
		}
		else
		{
			if (key != null)
			{
				_keyMap.set(name, [key]);
			}
			else
			{
				_keyMap.set(name, keys);
			}
		}
	}
	
	private static function keyDownEvent(event:KeyboardEvent):Void
	{
		_currentKeyPressed = event.keyCode;
		_keys[event.keyCode] = true;
	}
	
	private static function keyUpEvent(event:KeyboardEvent):Void
	{
		_currentKeyPressed = -1;
		_lastKeyPressed = -1;
		
		_currentKeyReleased = event.keyCode;
		_keys[event.keyCode] = false;
	}
	
	public static function keyPressed(?keyInt:Int, ?keyString:String):Bool
	{
		if (keyInt != null)
		{
			return checkKeyPressed(keyInt);
		}
		else
		{
			var keys:Array<Int> = _keyMap.get(keyString);
			if (keys != null)
			{
				for (key in keys)
				{
					if (checkKeyPressed(key))
					{
						return true;
					}
				}
			}
		}
		
		return false;
	}
	
	//public static function anyKeyPressed():Bool 
	//{
		//for (key in _keys)
		//{
			//if (key)
			//{
				//return key;
			//}
		//}
		//return false;
	//}
	
	private static function checkKeyPressed(key:Int):Bool
	{
		if (key == _currentKeyPressed && _currentKeyPressed != _lastKeyPressed)
		{
			return true;
		}
		return false;
	}
	
	public static function keyDown(?keyInt:Int, ?keyString:String):Bool
	{
		if (keyInt != null)
		{
			return _keys[keyInt];
		}
		else
		{
			var keys:Array<Int> = _keyMap.get(keyString);
			if (keys != null)
			{
				for (key in keys)
				{
					if (_keys[key])
					{
						return true;
					}
				}
			}
		}
		return false;
	}
	
	public static function keyUp(keyInt:Int):Bool
	{
		if (keyInt == _currentKeyReleased)
		{
			_currentKeyReleased = -1;
			return true;
		}
		else
		{
			return false;
		}
	}
	
	private static function mouseDownEvent(event:MouseEvent):Void
	{
		_leftMouseDown = true;
		_leftMousePressed = true;
		_leftMouseReleased = false;
	}
	
	private static function mouseUpEvent(event:MouseEvent):Void
	{
		_leftMouseDown = false;
		_leftMousePressed = false;
		_leftMouseReleased = true;
	}
	
	private static function rightMouseUpEvent(event:MouseEvent):Void 
	{
		_rightMouseDown = true;
		_rightMousePressed = true;
		_rightMouseReleased = false;
	}
	
	private static function rightMouseDownEvent(event:MouseEvent):Void 
	{
		_rightMouseDown = false;
		_rightMousePressed = false;
		_rightMouseReleased = true;
	}
	
	public static function leftMouseReleased():Bool
	{
		return _leftMouseReleased;
	}
	
	public static function leftMouseDown():Bool
	{
		return _leftMouseDown;
	}
	
	public static function leftMousePressed():Bool
	{
		return _leftMousePressed;
	}
	
	//public static function rightMouseReleased():Bool
	//{
		//return _rightMouseReleased;
	//}
	//
	//public static function rightMouseDown():Bool
	//{
		//return _rightMouseDown;
	//}
	//
	//public static function rightMousePressed():Bool
	//{
		//return _rightMousePressed;
	//}
	
	public static function mouseMoved():Bool
	{
		if (_mouseX != _stage.mouseX || _mouseY != _stage.mouseY)
		{
			_mouseX = _stage.mouseX;
			_mouseY = _stage.mouseY;
			return true;
		}
		else
		{
			return false;
		}
	}
	
	private static function get_mouseX():Float
	{
		return _stage.mouseX;
	}
	
	private static function get_mouseY():Float
	{
		return _stage.mouseY;
	}
}