package ze;
import openfl.display.Sprite;
import openfl.events.Event;
import ze.object.Node;
import ze.object.Scene;
import ze.util.Input;
import ze.util.Key;
import ze.util.Time;

/**
 * ...
 * @author Goh Zi He
 */
class Engine extends Sprite 
{
	public static var version(default, null):String = "0.0.0";
	
	private var _currentScene:Scene;
	private var _enable:Bool;
	
	private static var removeList:Array<Node>;
	
	public function new(initScene:Scene) 
	{
		super();
		removeList = [];
		_enable = true;
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		addEventListener(Event.DEACTIVATE, deactivate);
		addEventListener(Event.ACTIVATE, activate);
		
		// Initialization must be done first before calling scene.added()
		Input.init(stage);
		addScene(initScene);
	}
	
	private function onEnterFrame(e:Event):Void 
	{
		Time.update();
		update();
		draw();
	}
	
	public function update():Void 
	{
		if (!_enable)
		{
			return;
		}
		
		_currentScene.update();
		
		#if ((flash || windows) && debug)
		if (Input.keyPressed(Key.ESCAPE)) 
		{
			openfl.system.System.exit(0);
		}
		#end
		
		while (removeList.length > 0)
		{
			removeList[removeList.length - 1].destroyed();
			removeList.pop();
		}
		Input.update(_currentScene);
	}
	
	public function draw():Void
	{
		_currentScene.draw();
	}
	
	public function addScene(scene:Scene):Scene
	{
		if (_currentScene != null)
		{
			_currentScene.removed();
		}
		Reflect.setProperty(scene, "engine", this);
		scene.added();
		_currentScene = scene;
		return scene;
	}
	
	public function addToRemoveList(node:Node):Void
	{
		removeList.push(node);
	}
	
	private function activate(event:Event):Void
	{
		_enable = true;
	}
	
	private function deactivate(event:Event):Void
	{
		_enable = false;
	}
}