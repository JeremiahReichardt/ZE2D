package ze.util;
import openfl.display.Graphics;
import openfl.text.TextField;
import openfl.text.TextFormat;
import ze.Engine;
import ze.util.Input;
import ze.util.Key;

/**
 * This the IMGUI tutorial from http://sol.gfxile.net/imgui, adapted to ZE2D
 * @author Goh Zi He
 */
class IMGUI
{
	// So that no need to manually type new ID
	private static var internalUIIndex:Int;
	
	// For adding textField
	private static var root:Engine;
	
	// Rendering stuff
	private static var graphics:Graphics;
	
	// Internal UI States
	private static var uiState:UIState;
	
	// Managing Text Fields
	private static var textFieldIndex:Int;
	private static var textFields:Array<TextField>;
	
	public static function init(engine:Engine):Void
	{
		root = engine;
		graphics = engine.graphics;
		uiState = new UIState();
		textFields = new Array();
	}
	
	public static function begin():Void
	{
		// Clear graphics for rendering UI
		graphics.clear();
		
		// No active items when mouse is up
		if (uiState.mouseDown == 0)
		{
			uiState.activeItem = 0;
		}
		
		// If no widget grabbed tab, clear focus
		if (uiState.keyEntered == Key.TAB)
		{
			uiState.keyBoardItem = 0;
		}
		
		// Reset all id count to 0
		internalUIIndex = 0;
		
		// Clear the UI state
		uiState.hotItem = 0;
		uiState.keyChar = 0;
		uiState.mouseDown = 0;
		uiState.keyEntered = 0;
		uiState.keyMod = 0;
		textFieldIndex = 0;
		
		if (Input.mouseMoved())
		{
			uiState.mouseX = Math.floor(Input.mouseX);
			uiState.mouseY = Math.floor(Input.mouseY);
		}
		
		if (Input.leftMouseDown())
		{
			uiState.mouseDown = 1;
		}
		
		if (Input.keyPressed(Input.keyCode()))
		{
			uiState.keyEntered = Input.keyCode();
			uiState.keyChar = Input.keyCode();
		}
		
		if (Input.keyDown(Key.SHIFT))
		{
			uiState.keyMod = Key.SHIFT;
		}
		
		if (Input.keyDown(Key.CTRL))
		{
			uiState.keyMod = Key.CTRL;
		}
	}
	
	private static function drawRect(x:Float, y:Float, width:Float, height:Float, color:Int)
	{
		// Simple drawing routine
		graphics.beginFill(color);
		graphics.drawRect(x, y, width, height);
		graphics.endFill();
	}
	
	private static function drawString(msg:String, x:Int, y:Int):Void
	{
		var tf:TextField = textFields[textFieldIndex];
		tf.text = msg;
		tf.x = x;
		tf.y = y + 3;
	}
	
	public static function button(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0, triggerOnce:Bool = true):Bool
	{
		// Get the current ID of the UI element
		var id:Int = getID();
		
		// Check whether current mouse position is within a rectangle
		inGUI(id, x, y, width, height);
		
		// If we have keyboard focus, show it
		if (uiState.keyBoardItem == id)
		{
			drawRect(x - 4, y - 4, 48, 48, 0xff0000);
		}
		
		// Render buttons
		drawRect(x + 4, y + 4, width, height, 0xFFFFFF);
		
		if (uiState.hotItem == id)
		{
			if (uiState.activeItem == id)
			{
				if (triggerOnce && uiState.activeItem != -1)
				{
					uiState.activeItem = -1;
					return true;
				}
				
				// Button is hot and active
				drawRect(x + 2, y + 2, width, height, 0xFFFF00);
			}
			else
			{
				// Button is merely hot
				drawRect(x, y, width, height, 0xFFFF00);
			}
		}
		else
		{
			// Button is only active
			drawRect(x, y, width, height, 0xAAAAAA);
		}
		
		// If we have keyboard focus, we'll need to process the keys
		if (uiState.keyBoardItem == id)
		{
			switch (uiState.keyEntered)
			{
				case Key.TAB:
				{
					// If tab is pressed, lose keyboard focus.
					// Next widget will grab the focus.
					//uiState.keyBoardItem = 0;
					if (uiState.hotItem != id)
					{
						uiState.keyBoardItem = 0;
					}
					
					// If shift was also pressed, we want to move focus
					// to the previous widget instead.
					if (uiState.keyMod == Key.SHIFT)
					{
						uiState.keyBoardItem = uiState.lastWidget;
					}
					// Also clear the key so that next widget
					// won't process it
					uiState.keyEntered = 0;
				}
				
				case Key.ENTER:
				{
					// Had keyboard focus, received return,
					// so we'll act as if we were clicked.
					return true;
				}
			}
		}
		uiState.lastWidget = id;
		
		// If button is hot and active, but mouse button is not down, use must have clicked
		// the button
		if (uiState.mouseDown == 0 &&
			id == uiState.hotItem &&
			id == uiState.activeItem)
		{
			return true;
		}
		
		// No click
		return false;
	}
	
	public static function slider(x:Int, y:Int, max:Int, valueObj:ValueInt):Bool
	{
		// Get the current ID of the UI element
		var id:Int = getID();
		
		// Calculate mouse pos
		var yPos:Int = Std.int(((256 - 16) * valueObj.value) / max);
		
		// Check for hotness
		inGUI(id, x + 8, y + 8, 16, 255);
		
		// If we have keyboard focus, show it
		if (uiState.keyBoardItem == id)
		{
			drawRect(x - 4, y - 4, 40, 280, 0xff0000);
		}
		
		// Render the scroll bar
		drawRect(x, y, 32, 256 + 16, 0x777777);
		
		if (uiState.activeItem == id || uiState.hotItem == id)
		{
			drawRect(x + 8, y + 8 + yPos, 16, 16, 0xFFFFFF);
		}
		else 
		{
			drawRect(x + 8, y + 8 + yPos, 16, 16, 0xAAAAAA);
		}
		
		// If we have keyboard focus, we'll need to process the keys
		if (uiState.keyBoardItem == id)
		{
			switch (uiState.keyEntered)
			{
				case Key.TAB:
				{
					// If tab is pressed, lose keyboard focus.
					// Next widget will grab the focus.
					//uiState.keyBoardItem = 0;
					if (uiState.hotItem != id)
					{
						uiState.keyBoardItem = 0;
					}
					
					// If shift was also pressed, we want to move focus
					// to the previous widget instead.
					if (uiState.keyMod == Key.SHIFT)
					{
						uiState.keyBoardItem = uiState.lastWidget;
					}
					// Also clear the key so that next widget
					// won't process it
					uiState.keyEntered = 0;
				}
				
				case Key.UP:
				{
					// Slide slider up (if not at zero)
					if (valueObj.value > 0)
					{
						--valueObj.value;
						return true;
					}
				}
				
				case Key.DOWN:
				{
					// Slide slider down (if not at max)
					if (valueObj.value < max)
					{
						++valueObj.value;
						return true;
					}
				}
			}
		}
		
		uiState.lastWidget = id;
		
		// Update widget value
		if (uiState.activeItem == id)
		{
			var mousePos:Int = uiState.mouseY - (y + 8);
			if (mousePos < 0) mousePos = 0;
			if (mousePos > 255) mousePos = 255;
			
			var newVal = Std.int((mousePos * max) / 255);
			if (newVal != valueObj.value)
			{
				valueObj.value = newVal;
				return true;
			}
		}
		return false;
	}
	
	public static function textfield(x:Int, y:Int, valueStr:ValueStr):Bool
	{
		var textField:TextField = null;
		if (textFieldIndex == textFields.length)
		{
			textField = new TextField();
			textFields.push(textField);
			root.addChild(textField);
		}
		else
		{
			textField = textFields[textFieldIndex];
		}
		
		var len:Int = valueStr.value.length;
		var changed:Bool = false;
		
		// Get the current ID of the UI element
		var id:Int = getID();
		
		// Check for hotness
		inGUI(id, x - 4, y - 4, 30 * 14 + 8, 24 + 8);
		
		// If we have keyboard focus, show it
		if (uiState.keyBoardItem == id)
		{
			drawRect(x - 6, y - 6, 30 * 14 + 12, 24 + 12, 0xff0000);
		}
		
		// Render the text field
		if (uiState.activeItem == id || uiState.hotItem == id)
		{
			drawRect(x - 4, y - 4, 30 * 14 + 8, 24 + 8, 0xaaaaaa);
		}
		else
		{
			drawRect(x - 4, y - 4, 30 * 14 + 8, 24 + 8, 0x777777);
		}
		
		// Render cursor if we have keyboard focus
		if (id == uiState.keyBoardItem)
		{
			drawString(valueStr.value + "_", x, y);
		}
		else
		{
			drawString(valueStr.value, x, y);
		}
		
		// If we have keyboard focus, we'll need to process the keys
		if (uiState.keyBoardItem == id)
		{
			switch (uiState.keyEntered)
			{
				case Key.TAB:
				{
					// If tab is pressed, lose keyboard focus.
					// Next widget will grab the focus.
					//uiState.keyBoardItem = 0;
					if (uiState.hotItem != id)
					{
						uiState.keyBoardItem = 0;
					}
					
					// If shift was also pressed, we want to move focus
					// to the previous widget instead.
					if (uiState.keyMod == Key.SHIFT)
					{
						uiState.keyBoardItem = uiState.lastWidget;
					}
					
					// Also clear the key so that next widget
					// won't process it
					uiState.keyEntered = 0;
				}
				
				case Key.BACKSPACE:
				{
					if (len > 0)
					{
						--len;
						valueStr.value = valueStr.value.substr(0, len);
						changed = true;
					}
				}
			}
			
			if (uiState.keyChar >= 32 && uiState.keyChar < 127 && len < 30)
			{
				if (uiState.keyMod != Key.SHIFT &&
					uiState.keyChar != Key.SPACEBAR)
				{
					uiState.keyChar += 32;
				}
				
				if (textField.textWidth < textField.width - 5)
				{
					valueStr.value += String.fromCharCode(uiState.keyChar);
				}
				
				++len;
				uiState.keyChar = 0;
				changed = true;
			}
		}
		
		// If button is hot and active, but mouse button is not
		// down, the user must have clicked the widget; give it 
		// keyboard focus.
		if (uiState.mouseDown == 0 && 
			uiState.hotItem == id && 
			uiState.activeItem == id)
		{
			uiState.keyBoardItem = id;
		}
		uiState.lastWidget = id;
		
		++textFieldIndex;
		return changed;
	}
	
	public static function label(x:Int, y:Int, msg:String):Void
	{
		var textField:TextField = null;
		if (textFieldIndex == textFields.length)
		{
			textField = new TextField();
			textFields.push(textField);
			root.addChild(textField);
			textField.selectable = false;
		}
		else
		{
			textField = textFields[textFieldIndex];
		}
		
		var len:Int = msg.length;
		var changed:Bool = false;
		
		// Get the current ID of the UI element
		var id:Int = getID();
		
		// Check for hotness
		inGUI(id, x - 4, y - 4, 30 * 14 + 8, 24 + 8);
		
		// If we have keyboard focus, show it
		if (uiState.keyBoardItem == id)
		{
			drawRect(x - 6, y - 6, 30 * 14 + 12, 24 + 12, 0xff0000);
		}
		
		// Render the text field
		if (uiState.activeItem == id || uiState.hotItem == id)
		{
			drawRect(x - 4, y - 4, 30 * 14 + 8, 24 + 8, 0xaaaaaa);
		}
		else
		{
			drawRect(x - 4, y - 4, 30 * 14 + 8, 24 + 8, 0x777777);
		}
		
		drawString(msg, x, y);
		
		// If we have keyboard focus, we'll need to process the keys
		if (uiState.keyBoardItem == id)
		{
			switch (uiState.keyEntered)
			{
				case Key.TAB:
				{
					// If tab is pressed, lose keyboard focus.
					// Next widget will grab the focus.
					//uiState.keyBoardItem = 0;
					if (uiState.hotItem != id)
					{
						uiState.keyBoardItem = 0;
					}
					
					// If shift was also pressed, we want to move focus
					// to the previous widget instead.
					if (uiState.keyMod == Key.SHIFT)
					{
						uiState.keyBoardItem = uiState.lastWidget;
					}
					
					// Also clear the key so that next widget
					// won't process it
					uiState.keyEntered = 0;
				}
			}
		}
		
		// If button is hot and active, but mouse button is not
		// down, the user must have clicked the widget; give it 
		// keyboard focus.
		if (uiState.mouseDown == 0 && 
			uiState.hotItem == id && 
			uiState.activeItem == id)
		{
			uiState.keyBoardItem = id;
		}
		uiState.lastWidget = id;
		
		++textFieldIndex;
	}
	
	private static function inGUI(id:Int, x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0):Void
	{
		// Check if the mouse is within the UI
		if (Input.mouseX < x) return;
		if (Input.mouseX > x + width) return;
		if (Input.mouseY < y) return;
		if (Input.mouseY > y + height) return;
		
		// If mouse is within the UI, set our UI state to this current UI element
		uiState.hotItem = id;
		uiState.keyBoardItem = id;
		
		// Only Set the element as active if mouse is down and is not active
		if (uiState.activeItem == 0 && 
			uiState.mouseDown == 1)
		{
			uiState.activeItem = id;
		}
		
		// If no widget has keyboard focus, take it
		if (uiState.keyBoardItem == 0)
		{
			uiState.keyBoardItem = id;
		}
	}
	
	private static function getID():Int
	{
		// Update the ID of the GUI
		return ++internalUIIndex;
	}
}

private class UIState
{
	public var mouseX:Int;
	public var mouseY:Int;
	public var mouseDown:Int;
	
	public var hotItem:Int;
	public var activeItem:Int;
	
	public var keyBoardItem:Int;
	public var keyEntered:Int;
	public var keyMod:Int;
	public var keyChar:Int;
	
	public var lastWidget:Int;
	
	public function new()
	{
	}
}

class ValueInt
{
	public var value(default, default):Int;
	public function new(val:Int)
	{
		value = val;
	}
}

class ValueStr
{
	public var value(default, default):String;
	public function new(val:String)
	{
		value = val;
	}
}