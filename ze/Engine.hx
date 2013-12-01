package ze;

import flash.display.MovieClip;
import flash.events.Event;
import flash.Lib;
import flash.system.System;
import ze.object.Object;
import ze.object.Scene;
import ze.util.Input;
import ze.util.Key;
import ze.util.Time;

/**
 * ...
 * @author Goh Zi He
 */
class Engine extends Object 
{
	private static var _engine:Engine;
	
	public function new(initScene:Scene) 
	{
		super();
		_engine = engine = this;
		
		add(initScene);
		var current:MovieClip = Lib.current;
		Input.init(current.stage);
		
		current.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(e:Event):Void 
	{
		Time.update();
		update();
	}
	
	override private function update():Void 
	{
		super.update();
		if (Input.keyPressed(Key.ESCAPE)) 
		{
			System.exit(0);
		}
		Input.update();
	}
	
	override public function add<T:Object>(object:T):T 
	{
		if (Std.is(object, Scene))
		{
			var prevScene:Object = _objects[0];
			if (prevScene != null) 
			{
				remove(prevScene);
			}
			return super.add(object);
		}
		return null;
	}
	
	public static function getEngine():Engine
	{
		return _engine;
	}
}