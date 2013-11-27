package ze.object;

import flash.display.BitmapData;
import flash.geom.Rectangle;
import ze.component.core.Component;
import ze.component.core.Screen;
import ze.component.rendering.Image;
import ze.object.GameObject;
import ze.object.Object;

/**
 * Handle adding/removing gameObjects, remove all gameObjects when scene changes
 * @author Goh Zi He
 */

class Scene extends Object
{
	public var screen(default, null):Screen;
	public var gameObjects(get, null):Array<GameObject>;
	public var numGameObjects(get, null):Int;
	
	override private function added():Void 
	{
		super.added();
		screen = new Screen();
		addGameObject("screen", screen, 0, 0);
	}
	
	override private function removed():Void
	{
		while (_objects.length > 0)
		{
			_objects.pop().removed();
		}
	}
	
	private function removeAllGameObjects():Void
	{
		for (gameObject in _objects)
		{
			if (gameObject.name == "screen")
			{
				continue;
			}
			
			remove(gameObject);
		}
	}
	
	override public function add<T:Object>(object:T):T 
	{
		if (Std.is(object, GameObject))
		{
			Reflect.setProperty(object, "scene", this);
			return super.add(object);
		}
		else if (Std.is(object, Scene))
		{
			return engine.add(object);
		}
		trace("Not added");
		return null;
	}
	
	override public function remove(object:Object):Void 
	{
		if (Std.is(object, GameObject))
		{
			super.remove(object);
		}
	}
	
	public function getGameObjectByName(name:String):GameObject
	{
		var gameObject:GameObject = null;
		for (go in gameObjects)
		{
			if (go.name == name)
			{
				gameObject = go;
				break;
			}
		}
		return gameObject;
	}
	
	public function getGameObjectsByName(name:String):Array<GameObject>
	{
		var gameObjectsWithName:Array<GameObject> = [];
		for (go in gameObjects)
		{
			if (go.name == name)
			{
				gameObjectsWithName.push(go);
			}
		}
		return gameObjectsWithName;
	}
	
	public function getGameObjectByComponent(component:Class<Component>):GameObject
	{
		var gameObject:GameObject = null;
		for (go in gameObjects)
		{
			if (go.getComponent(component) != null)
			{
				gameObject = go;
				break;
			}
		}
		return gameObject;
	}
	
	public function getGameObjectsByComponent(component:Class<Component>):Array<GameObject>
	{
		var gameObjects:Array<GameObject> = [];
		for (go in gameObjects)
		{
			if (go.getComponent(component) != null)
			{
				gameObjects.push(go);
			}
		}
		return gameObjects;
	}
	
	private function addGameObject(name:String, component:Component = null, components:Array<Component> = null, x:Float = 0, y:Float = 0):GameObject
	{
		var gameObject:GameObject = new GameObject(name, x, y);
		
		if (component != null)
		{
			gameObject.add(component);
		}
		else if (components != null)
		{
			for (component in components)
			{
				gameObject.add(component);
			}
		}
		add(gameObject);
		return gameObject;
	}
	
	private function addImage(label:String, imagePath:String = "", imageData:BitmapData = null, rectangle:Rectangle = null, x:Float = 0, y:Float = 0):GameObject
	{
		var image:Image = new Image(label, imagePath, imageData, rectangle);
		return addGameObject(label, [image], x, y);
	}
	
	private function get_numGameObjects():Int 
	{
		return _objects.length;
	}
	
	private function get_gameObjects():Array<GameObject> 
	{
		return cast _objects;
	}
	
	private function loadImage(name:String, x:Float = 0, y:Float = 0):Void
	{
		var gameObject:GameObject = new GameObject(name, x, y);
		var image:Image = new Image(name, "gfx/" + name + ".png");
		gameObject.add(image);
		add(gameObject);
	}
}