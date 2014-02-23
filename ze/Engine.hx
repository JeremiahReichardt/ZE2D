package ze;

import flash.display.MovieClip;
import flash.events.Event;
import flash.Lib;
import flash.system.System;
import ze.object.Node;
import ze.object.Object;
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
	private static var removeList:Array<Node>;
	
	public var scene(get, null):Scene;
	private var _engineRunning:Bool;
	
	public function new(initScene:Scene) 
	{
		super();
		_engineRunning = true;
		_engine = this;
		removeList = [];
		
		var current:MovieClip = Lib.current;
		
		current.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		current.addEventListener(Event.DEACTIVATE, deactivate);
		current.addEventListener(Event.ACTIVATE, activate);
		
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
		if (!_engineRunning)
		{
			return;
		}
		
		if (cast(_child, Object).enable)
		{
			_child.update();
		}
		
		if (Input.keyPressed(Key.ESCAPE)) 
		{
			System.exit(0);
		}
		
		while (removeList.length > 0)
		{
			removeList[removeList.length - 1].destroyed();
			removeList.pop();
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
	
	public function addToRemoveList(node:Node):Void
	{
		removeList.push(node);
	}
	
	private function get_scene():Scene
	{
		return cast(_child, Scene);
	}
	
	private function activate(event:Event):Void
	{
		_engineRunning = true;
	}
	
	private function deactivate(event:Event):Void
	{
		_engineRunning = false;
	}
}