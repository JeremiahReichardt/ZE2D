package ze;
import openfl.display.MovieClip;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.events.Event;
import openfl.Lib;
import openfl.system.System;
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
	private static var removeList:Array<Node>;
	
	public var current(default, null):MovieClip;
	
	public function new(initScene:Scene) 
	{
		super();
		removeList = [];
		current = Lib.current;
		current.stage.align = StageAlign.LEFT;
		current.stage.scaleMode = StageScaleMode.NO_SCALE;
		current.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		current.addEventListener(Event.DEACTIVATE, deactivate);
		current.addEventListener(Event.ACTIVATE, activate);
		
		Input.init(current.stage);
		Reflect.setProperty(initScene, "engine", this);
		addChildNode(initScene);
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
		
		if (_child.enable)
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
		removeChildNode(_child);
		Reflect.setProperty(scene, "engine", this);
		addChildNode(scene);
		return scene;
	}
	
	public function addToRemoveList(node:Node):Void
	{
		removeList.push(node);
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