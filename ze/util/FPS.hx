package ze.util;

import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFormat;
import haxe.Timer;
import openfl.Assets;

class FPS extends TextField
{
	private var _times:Array<Float>;
	
	public function new(xPos:Float = 10.0, yPos:Float = 10.0, fontSize:Int = 12, fontColor:Int = 0x000000)
	{	
		super();
		
		x = xPos;
		y = yPos;
		selectable = false;
		text = "FPS: ";
		_times = [];
		
		defaultTextFormat = new TextFormat("ARIAL", fontSize, fontColor, true);
		
		addEventListener(Event.ENTER_FRAME, onEnter);
	}
	
	private function onEnter(_):Void
	{
		moveToTop();
		
		var now:Float = Timer.stamp();
		_times.push(now);
		
		while (_times[0] < now - 1)
		{
			_times.shift();
		}
		
		if (visible)
		{	
			text = "FPS: " + _times.length;	
		}
	}
	
	private function moveToTop():Void
	{
		if (parent.getChildIndex(this) < parent.numChildren - 1)
		{
			parent.setChildIndex(this, parent.numChildren - 1);
		}
	}
}
