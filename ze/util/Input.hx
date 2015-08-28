package ze.util;
import haxe.ds.StringMap;
import openfl.display.Stage;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.events.TouchEvent;
import ze.object.Scene;

/**
 * Input for handling keypresses and mouse position.
 * @author Goh Zi He
 */

class Input 
{
	public static var mouseX(get, null):Float;
	public static var mouseY(get, null):Float;
	public static var touchX(default, null):Float;
	public static var touchY(default, null):Float;
	
	private static var _init:Bool;
	private static var _stage:Stage;
	private static var _keyCode:Int;
	private static var _keys:Array<Bool>;
	private static var _lastKeyPressed:Int;
	private static var _currentKeyPressed:Int;
	private static var _currentKeyReleased:Int;
	
	private static var _mouseMoved:Bool;
	
	private static var _leftMouseDown:Bool;
	private static var _leftMousePressed:Bool;
	private static var _leftMouseReleased:Bool;
	
	private static var _rightMouseDown:Bool;
	private static var _rightMousePressed:Bool;
	private static var _rightMouseReleased:Bool;
	
	private static var _touchDown:Bool;
	private static var _touchPressed:Bool;
	private static var _touchReleased:Bool;
	
	private static var _keyMap:StringMap<Array<Int>>;
	
	private static inline var NOKEY:Int = -1;
	private static var _scene:Scene;
	
	/**
	 * Init input stuff like adding mouse/keyboard events to the stage
	 * @param	stage	For adding the event listener
	 */
	public static function init(stage:Stage):Void
	{
		if (_init)
		{
			return;
		}
		
		// Holding an array of bools
		_keys = [];
		
		_stage = stage;
		
		// Use for custom added keys
		_keyMap = new StringMap<Array<Int>>();
		
		// No key pressed yet
		_keyCode = NOKEY;
		_currentKeyPressed = NOKEY;
		
		mouseX = 0;
		mouseY = 0;
		touchX = 0;
		touchY = 0;
		
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownEvent);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUpEvent);
		
		stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveEvent);
		stage.addEventListener(MouseEvent.MOUSE_DOWN, leftMouseDownEvent);
		stage.addEventListener(MouseEvent.MOUSE_UP, leftMouseUpEvent);
		
		stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, rightMouseDownEvent);
		stage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, rightMouseUpEvent);
		
		//Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
		stage.addEventListener(TouchEvent.TOUCH_BEGIN, touchBeginEvent);
		stage.addEventListener(TouchEvent.TOUCH_MOVE, touchMoveEvent);
		stage.addEventListener(TouchEvent.TOUCH_END, touchEndEvent);
		
		_init = true;
	}
	
	/**
	 * Called by engine after all the components have been updated because this will
	 * clear all the internal pressed state.
	 * @param	scene	Scene for mouse tracking
	 */
	public static function update(scene:Scene):Void
	{
		_scene = scene;
		
		// Resets all state.
		_touchPressed = false;
		_touchReleased = false;
		
		_mouseMoved = false;
		_leftMousePressed = false;
		_leftMouseReleased = false;
		_rightMousePressed = false;
		_rightMouseReleased = false;
		
		// Set the last key pressed to the current key pressed at the end of the frame.
		_lastKeyPressed = _currentKeyPressed;
	}
	
	/**
	 * Add a custom key asscociated with a string, for example a key named jump associated with spacebar and return key.
	 * @param	name	The name of the key.
	 * @param	key		Either one key to be binded.
	 * @param	keys	Or multiple keys to be binded.
	 */
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
	
	/**
	 * Private internal keyboard event handling.
	 * @param	event
	 */
	private static function keyDownEvent(event:KeyboardEvent):Void
	{
		// Assign the current keyCode to the keycode sent by the event.
		_keyCode = event.keyCode;
		
		// This will be the current key pressed
		_currentKeyPressed = _keyCode;
		
		// Set the bool array of this key to be true
		_keys[_keyCode] = true;
	}
	
	/**
	 * Private internal keyboard event handling.
	 * @param	event
	 */
	private static function keyUpEvent(event:KeyboardEvent):Void
	{
		// When key up is detected, reset back to no key pressed
		_currentKeyPressed = NOKEY;
		_lastKeyPressed = NOKEY;
		
		// Set the current key released to the keycode of the event
		_currentKeyReleased = event.keyCode;
		
		// Set the bool array back to false
		_keys[_currentKeyReleased] = false;
	}
	
	/**
	 * Get the keycode of the last key pressed.
	 * @return
	 */
	public static function keyCode():Int
	{
		return _keyCode;
	}
	
	/**
	 * Check if any key is being held down for multiple frames.
	 * @return	True if any key is being held down.
	 */
	public static function anyKeyDown():Bool 
	{
		// Go through the bool array and look for true
		for (key in _keys)
		{
			if (key)
			{
				return true;
			}
		}
		return false;
	}
	
	/**
	 * Check if any key is being pressed this frame.
	 * @return	True if any key is being pressed.
	 */
	public static function anyKeyPressed():Bool 
	{
		// Go through the bool array and call checkKeyPressed on the keyCode
		for (i in 0 ... _keys.length)
		{
			if (_keys[i] && checkKeyPressed(i))
			{
				return true;
			}
		}
		return false;
	}
	
	/**
	 * Check for the specified key released this frame.
	 * @param	keyInt			The key code of the key.
	 * @param	keyString		Or the string of the key added by keyAdd.
	 * @return	True if the key is just released.
	 */
	public static function keyUp(?keyInt:Int, ?keyString:String):Bool
	{
		// If user specify the keycode
		if (keyInt != null)
		{
			if (keyInt == _currentKeyReleased)
			{
				// Reset the current key released
				_currentKeyReleased = NOKEY;
				return true;
			}
		}
		else
		{
			// Go through the keyCode that user have specified.
			var keys:Array<Int> = _keyMap.get(keyString);
			if (keys != null)
			{
				for (key in keys)
				{
					// Make sure to check for all keys, and only if one of them is true.
					if (keyUp(key))
					{
						return true;
					}
				}
			}
		}
		
		return false;
	}
	
	/**
	 * Check for the specified key being hold down this frame. (Note: Down trigger while key is held down until released.)
	 * @param	keyInt			The key code of the key.
	 * @param	keyString		Or the string of the key added by keyAdd.
	 * @return	True if the key is being hold down.
	 */
	public static function keyDown(?keyInt:Int, ?keyString:String):Bool
	{
		// If user specify the keycode
		if (keyInt != null)
		{
			// Check the bool array.
			return _keys[keyInt];
		}
		else
		{
			// Go through the keyCode that user have specified.
			var keys:Array<Int> = _keyMap.get(keyString);
			if (keys != null)
			{
				for (key in keys)
				{
					// Make sure to check for all keys, and only if one of them is true.
					if (_keys[key])
					{
						return true;
					}
				}
			}
		}
		
		return false;
	}
	
	/**
	 * Check for the specified key being pressed this frame. (Note: Pressed only trigger once until user press again.)
	 * @param	keyInt			The key code of the key.
	 * @param	keyString		Or the string of the key added by keyAdd.
	 * @return	True if the key is being pressed.
	 */
	public static function keyPressed(?keyInt:Int, ?keyString:String):Bool
	{
		// If user specify the keycode
		if (keyInt != null)
		{
			return checkKeyPressed(keyInt);
		}
		else
		{
			// Go through the keyCode that user have specified.
			var keys:Array<Int> = _keyMap.get(keyString);
			if (keys != null)
			{
				for (key in keys)
				{
					// Make sure to check for all keys, and only if one of them is true.
					if (checkKeyPressed(key))
					{
						return true;
					}
				}
			}
		}
		
		return false;
	}
	
	/**
	 * Internal helper function to check if the keyCode have been pressed in the current frame.
	 * @param	key		The keycode to process.
	 * @return			True if the keycode have been pressed in this frame.
	 */
	private static function checkKeyPressed(key:Int):Bool
	{
		// Make sure the key is currently being pressed and is not the key of the last frame.
		if (key == _currentKeyPressed && _currentKeyPressed != _lastKeyPressed)
		{
			return true;
		}
		return false;
	}
	
	/**
	 * Private internal mouse event handling.
	 * @param	event
	 */
	private static function mouseMoveEvent(event:MouseEvent):Void
	{
		_mouseMoved = true;
	}
	
	/**
	 * Private internal mouse event handling. 
	 * @param	event
	 */
	private static function leftMouseDownEvent(event:MouseEvent):Void
	{
		_leftMouseDown = true;
		_leftMousePressed = true;
		_leftMouseReleased = false;
	}
	
	/**
	 * Private internal mouse event handling. 
	 * @param	event
	 */
	private static function leftMouseUpEvent(event:MouseEvent):Void
	{
		_leftMouseDown = false;
		_leftMousePressed = false;
		_leftMouseReleased = true;
	}
	
	/**
	 * Private internal mouse event handling. 
	 * @param	event
	 */
	private static function rightMouseDownEvent(event:MouseEvent):Void 
	{
		_rightMouseDown = true;
		_rightMousePressed = true;
		_rightMouseReleased = false;
	}
	
	/**
	 * Private internal mouse event handling. 
	 * @param	event
	 */
	private static function rightMouseUpEvent(event:MouseEvent):Void 
	{
		_rightMouseDown = false;
		_rightMousePressed = false;
		_rightMouseReleased = true;
	}
	
	/**
	 * Private internal touch event handling. 
	 * @param	event
	 */
	private static function touchBeginEvent(event:TouchEvent):Void
	{
		_touchDown = true;
		_touchPressed = true;
		_touchReleased = false;
		
		touchX = event.stageX;
		touchY = event.stageY;
	}
	
	/**
	 * Private internal touch event handling. 
	 * @param	event
	 */
	private static function touchMoveEvent(event:TouchEvent):Void
	{
		touchX = event.stageX;
		touchY = event.stageY;
	}
	
	/**
	 * Private internal touch event handling. 
	 * @param	event
	 */
	private static function touchEndEvent(event:TouchEvent):Void
	{
		_touchDown = false;
		_touchPressed = false;
		_touchReleased = true;
	}
	
	/**
	 * Checks if mouse has moved.
	 * @return	True if mouse have moved.
	 */
	public static function mouseMoved():Bool
	{
		return _mouseMoved;
	}
	
	/**
	 * Checks if left mouse button is released this frame.
	 * @return	True when left mouse button is released.
	 */
	public static function leftMouseReleased():Bool
	{
		return _leftMouseReleased;
	}
	
	/**
	 * Checks if left mouse button is held down.
	 * @return	True when left mouse button is held down.
	 */
	public static function leftMouseDown():Bool
	{
		return _leftMouseDown;
	}
	
	/**
	 * Checks if left mouse button is pressed this frame.
	 * @return	True when left mouse button is pressed.
	 */
	public static function leftMousePressed():Bool
	{
		return _leftMousePressed;
	}
	
	/**
	 * Checks if right mouse button is released this frame.
	 * @return	True when right mouse button is released.
	 */
	public static function rightMouseReleased():Bool
	{
		return _rightMouseReleased;
	}
	
	/**
	 * Checks if right mouse button is held down this frame.
	 * @return	True when right mouse button is held down.
	 */
	public static function rightMouseDown():Bool
	{
		return _rightMouseDown;
	}
	
	/**
	 * Checks if right mouse button is pressed this frame.
	 * @return	True when right mouse button is pressed.
	 */
	public static function rightMousePressed():Bool
	{
		return _rightMousePressed;
	}
	
	/**
	 * Get the mouse X position.
	 * @return	The x position of the mouse.
	 */
	private static function get_mouseX():Float
	{
		return _stage.mouseX + _scene.screen.left;
	}
	
	/**
	 * Get the mouse Y position.
	 * @return	The y position of the mouse.
	 */
	private static function get_mouseY():Float
	{
		return _stage.mouseY + _scene.screen.top;
	}
	/**
	 * Checks if touch controls is released this frame.
	 * @return	True when touch controls is released.
	 */
	public static function touchReleased():Bool
	{
		return _touchReleased;
	}
	
	/**
	 * Checks if touch controls is held down this frame.
	 * @return	True when touch controls is held down.
	 */
	public static function touchDown():Bool
	{
		return _touchDown;
	}
	
	/**
	 * Checks if touch controls is pressed this frame.
	 * @return	True when touch controls is pressed.
	 */
	public static function touchPressed():Bool
	{
		return _touchPressed;
	}
}