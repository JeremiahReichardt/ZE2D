package ze.object;

import flash.display.BitmapData;
import flash.geom.Rectangle;
import ze.component.core.Component;
import ze.component.core.Screen;
import ze.component.rendering.Image;
import ze.Engine;
import ze.object.GameObject;
import ze.object.Node;

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
		engine = Engine.getEngine();
		screen = new Screen();
		createGameObject("screen", screen, 0, 0);
	}
	
	public function createGameObject(name:String, component:Component = null, components:Array<Component> = null, x:Float = 0, y:Float = 0):GameObject
	{
		var gameObject:GameObject = new GameObject(name, x, y);
		if (component != null)
		{
			gameObject.addChild(component);
		}
		else if (components != null)
		{
			for (component in components)
			{
				gameObject.addChild(component);
			}
		}
		return addGameObject(gameObject);
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
		var gameObject:GameObject = null;
		while (node != null)
		{
			gameObject = cast (node, GameObject);
			if (gameObject.name == name)
			{
				break;
			}
			node = node._next;
		}
		return cast gameObject;
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
		var gameObject:GameObject = null;
		var node:Node = _child.first;
		while (node != null)
		{
			gameObject = cast(node, GameObject);
			if (gameObject.getComponent(component) != null)
			{
				break;
			}
			node = node._next;
		}
		return gameObject;
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
			if (node.enable)
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