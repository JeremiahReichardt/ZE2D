package ze.object;

import flash.display.MovieClip;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
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
	public var current(default, null):MovieClip;
	
	public function new(initScene:Scene) 
	{
		super();
		
		_engine = this;
		removeList = [];
		
		current = Lib.current;
		current.stage.align = StageAlign.LEFT;
		current.stage.scaleMode = StageScaleMode.NO_SCALE;
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
		if (!enable)
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
		enable = true;
	}
	
	private function deactivate(event:Event):Void
	{
		enable = false;
	}
}