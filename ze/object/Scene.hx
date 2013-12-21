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
		addGameObject(createGameObject("screen", screen, 0, 0));
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
		return gameObject;
	}
	
	public function addGameObject(gameObject:GameObject):GameObject
	{
		addChild(gameObject);
		return gameObject;
	}
	
	public function addImage(label:String, imagePath:String = "", imageData:BitmapData = null, rectangle:Rectangle = null, x:Float = 0, y:Float = 0):GameObject
	{
		var image:Image = new Image(label, imagePath, imageData, rectangle);
		return createGameObject(label, [image], x, y);
	}
	
	public function removeGameObject(gameObject:GameObject):Void 
	{
		removeChild(gameObject);
	}
	
	public function getGameObjectByName(name:String):GameObject
	{
		var first:Node = _child.first;
		var gameObject:GameObject = null;
		for (go in first)
		{
			var current:GameObject = cast (go, GameObject);
			if (current.name == name)
			{
				gameObject = current;
			}
		}
		return gameObject;
	}
	
	public function getGameObjectsByName(name:String):Array<GameObject>
	{
		var first:Node = _child.first;
		var gameObjectsWithName:Array<GameObject> = [];
		for (go in first)
		{
			var current:GameObject = cast (go, GameObject);
			if (current.name == name)
			{
				gameObjectsWithName.push(current);
			}
		}
		return gameObjectsWithName;
	}
	
	public function getGameObjectByComponent(component:Class<Component>):GameObject
	{
		var gameObject:GameObject = null;
		var first:Node = _child.first;
		for (go in first)
		{
			var current:GameObject = cast(go, GameObject);
			if (current.getComponent(component) != null)
			{
				gameObject = current;
			}
		}
		return gameObject;
	}
	
	public function getGameObjectsByComponent(component:Class<Component>):Array<GameObject>
	{
		var gameObjects:Array<GameObject> = [];
		var gameObject:GameObject;
		var first:Node = _child.first;
		for (go in first)
		{
			gameObject = cast(go, GameObject);
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
		
		var first:Node = _child.first;
		for (node in first)
		{
			node.update();
		}
	}
	
	override private function removed():Void 
	{
		super.removed();
		_child.removeAll();
		engine.addToRemoveList(this);
	}
}