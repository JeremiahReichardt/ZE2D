package ze.object;
import ze.component.core.Component;
import ze.component.debug.GDebug;
import ze.object.GameObject;
import ze.object.Node;
import ze.util.Screen;
/**
 * Handle adding/removing gameObjects, remove all gameObjects when scene changes
 * @author Goh Zi He
 */

class Scene extends Node
{
	public var screen(default, null):Screen;
	public var engine(default, null):Engine;
	
	private var _gDebug:GDebug;
	
	override public function added():Void 
	{
		super.added();
		screen = new Screen(this);
		
		// Enable GDebug
		#if debug
		_gDebug = new GDebug();
		createGameObject("GDebug", _gDebug);
		#end
	}
	
	override public function update():Void 
	{
		if (!enable || _child == null)
		{
			return;
		}
		
		super.update();
		var node:Node = _child.first;
		
		while (node != null)
		{
			if (node.enable)
			{
				node.update();
			}
			node = node._next;
		}
		
		if (screen != null)
		{
			screen.draw();
		}
	}
	
	public function createGameObject(name:String, component:Component = null, components:Array<Component> = null, x:Float = 0, y:Float = 0):GameObject
	{
		var gameObject:GameObject = new GameObject(name, x, y);
		addGameObject(gameObject);
		
		if (component != null)
		{
			gameObject.addComponent(component);
		}
		else if (components != null)
		{
			for (component in components)
			{
				gameObject.addComponent(component);
			}
		}
		return gameObject;
	}
	
	public function addGameObject(gameObject:GameObject):GameObject
	{
		attachChild(gameObject);
		return gameObject;
	}
	
	public function removeGameObject(gameObject:GameObject):Void 
	{
		detachChild(gameObject);
	}
	
	public function getGameObjectByName(name:String):GameObject
	{
		var node:Node = _child.first;
		while (node != null)
		{
			var gameObject:GameObject = cast(node, GameObject);
			if (gameObject.name == name)
			{
				return gameObject;
			}
			node = node._next;
		}
		return null;
	}
	
	public function getGameObjectsByName(name:String):Array<GameObject>
	{
		var node:Node = _child.first;
		var gameObjectsWithName:Array<GameObject> = [];
		while (node != null)
		{
			var current:GameObject = cast(node, GameObject);
			if (current.name == name)
			{
				gameObjectsWithName.push(current);
			}
			node = node._next;
		}
		return gameObjectsWithName;
	}
	
	public function getGameObjectByComponent(component:Class<Component>):GameObject
	{
		var node:Node = _child.first;
		while (node != null)
		{
			var gameObject:GameObject = cast(node, GameObject);
			if (gameObject.getComponent(component) != null)
			{
				return gameObject;
			}
			node = node._next;
		}
		return null;
	}
	
	public function getGameObjectsByComponent(component:Class<Component>):Array<GameObject>
	{
		var gameObjects:Array<GameObject> = [];
		var gameObject:GameObject;
		var node:Node = _child.first;
		while (node != null)
		{
			gameObject = cast(node, GameObject);
			if (gameObject.getComponent(component) != null)
			{
				gameObjects.push(gameObject);
			}
		}
		return gameObjects;
	}
	
	public function getAllGameObjects():Array<GameObject>
	{
		var node:Node = _child.first;
		var gameObjects:Array<GameObject> = [];
		while (node != null)
		{
			var current:GameObject = cast(node, GameObject);
			gameObjects.push(current);
			node = node._next;
		}
		return gameObjects;
	}
	
	public function nextLevel():Void
	{
	}
	
	override public function removed():Void 
	{
		screen.removed();
		_child.removeAll();
		engine.addToRemoveList(this);
		screen = null;
		engine = null;
		super.removed();
	}
	
	private function log(msg:Dynamic):Void
	{
		GDebug.logMsg(msg);
	}
}