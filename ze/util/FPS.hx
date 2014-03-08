package ze.util;

import flash.events.Event;
import flash.system.System;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import haxe.Timer;
import openfl.Assets;

class FPS extends TextField
{
	private var _times:Array<Float>;
	private var _memory:Float;
	
	public function new(xPos:Float = 10.0, yPos:Float = 10.0, fontSize:Int = 12, fontColor:Int = 0x000000)
	{	
		super();
		
		x = xPos;
		y = yPos;
		selectable = false;
		text = "FPS: ";
		_times = [];
		this.autoSize = TextFieldAutoSize.LEFT;
		defaultTextFormat = new TextFormat("ARIAL", fontSize, fontColor, true);
		
		addEventListener(Event.ENTER_FRAME, onEnter);
		
		//_memReadText.text = "MEM: " + Number(System.totalMemory/1024/1024).toFixed(2) + "MB";
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
		
		_memory = Math.ffloor(System.totalMemoryNumber / 1024 / 512);
		
		if (visible)
		{	
			text = "FPS: " + _times.length + " Memory: " + _memory + " MB";	
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
