package ze;

import flash.display.MovieClip;
import flash.events.Event;
import flash.Lib;
import flash.system.System;
import ze.object.Node;
import ze.object.Scene;
import ze.util.Input;
import ze.util.Key;
import ze.util.Time;

/**
 * ...
 * @author Goh Zi He
 */
class Engine extends Node 
{
	private static var _engine:Engine;
	
	public function new(initScene:Scene) 
	{
		super();
		_engine = this;
		
		var current:MovieClip = Lib.current;
		current.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		Input.init(current.stage);
		
		addChild(initScene);
	}
	
	private function onEnterFrame(e:Event):Void 
	{
		Time.update();
		update();
	}
	
	override private function update():Void 
	{
		_child.update();
		if (Input.keyPressed(Key.ESCAPE)) 
		{
			System.exit(0);
		}
		Input.update();
	}
	
	public function addScene(scene:Scene):Scene
	{
		removeChild(_child);
		addChild(scene);
		return scene;
	}
	
	public static function getEngine():Engine
	{
		return _engine;
	}
}