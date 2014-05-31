package ze.object;
import ze.component.core.Component;
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
	
	override private function added():Void 
	{
		super.added();
		screen = new Screen(this);
	}
	
	override private function update():Void 
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
		
		screen.draw();
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
		addChildNode(gameObject);
		return gameObject;
	}
	
	public function removeGameObject(gameObject:GameObject):Void 
	{
		removeChildNode(gameObject);
	}
	
	public function getGameObjectByName(name:String):GameObject
	{
		var node:Node = _child.first;
		while (node != null)
		{
			var gameObject:GameObject = cast (node, GameObject);
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
			var current:GameObject = cast (node, GameObject);
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
	
	override private function removed():Void 
	{
		_child.removeAll();
		engine.addToRemoveList(this);
		super.removed();
	}
}