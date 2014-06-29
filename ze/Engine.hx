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
	private static var removeList:Array<Node>;
	private var _currentScene:Scene;
	private var _enable:Bool;
	
	public function new(initScene:Scene) 
	{
		super();
		removeList = [];
		_enable = true;
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		addEventListener(Event.DEACTIVATE, deactivate);
		addEventListener(Event.ACTIVATE, activate);
		Input.init(stage);
		addScene(initScene);
	}
	
	private function onEnterFrame(e:Event):Void 
	{
		Time.update();
		update();
	}
	
	public function update():Void 
	{
		if (!_enable)
		{
			return;
		}
		
		if (_currentScene.enable)
		{
			_currentScene.update();
		}
		
		#if (flash || windows)
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
		Input.update();
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