package ze.object;

import flash.display.BitmapData;
import flash.geom.Rectangle;
import ze.component.core.Component;
import ze.component.core.Screen;
import ze.component.rendering.Image;
import ze.object.GameObject;
import ze.object.Node;

/**
 * Handle adding/removing gameObjects, remove all gameObjects when scene changes
 * @author Goh Zi He
 */

class Scene extends Object
{
	public var screen(default, null):Screen;
	
	override private function added():Void 
	{
		super.added();
		screen = new Screen();
		createGameObject("screen", screen, 0, 0);
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
	
	public function createImage(label:String, imagePath:String = "", imageData:BitmapData = null, rectangle:Rectangle = null, x:Float = 0, y:Float = 0):GameObject
	{
		var image:Image = new Image(label, imagePath, imageData, rectangle);
		return createGameObject(label, [image], x, y);
	}
	
	public function addGameObject(gameObject:GameObject):GameObject
	{
		addChild(gameObject);
		return gameObject;
	}
	
	public function removeGameObject(gameObject:GameObject):Void 
	{
		removeChild(gameObject);
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
	
	public function loadImage(name:String, x:Float = 0, y:Float = 0):Void
	{
		var gameObject:GameObject = new GameObject(name, x, y);
		var image:Image = new Image(name, "gfx/" + name + ".png");
		gameObject.addComponent(image);
		addGameObject(gameObject);
	}
	
	override private function update():Void 
	{
		super.update();
		
		var node:Node = _child.first;
		while (node != null)
		{
			if (cast(node, Object).enable)
			{
				node.update();
			}
			node = node._next;
		}
	}
	
	override private function removed():Void 
	{
		super.removed();
		_child.removeAll();
		engine.addToRemoveList(this);
	}
}