package ze.component.core;

import ze.component.physics.Collider;
import ze.component.rendering.Render;
import ze.object.GameObject;
import ze.object.Object;
import ze.object.Scene;

/**
 * ...
 * @author Goh Zi He
 */

class Component extends Object
{
	public var transform(get, null):Transform;
	public var collider(get, null):Collider;
	public var render(get, null):Render;
	public var gameObject(default, null):GameObject;
	public var scene(get, null):Scene;
	
	public function new()
	{
		super();
		enable = true;
	}
	
	public function getComponent<T:Component>(componentType:Class<T>):T
	{
		return gameObject.getComponent(componentType);
	}
	
	private function getGameObjectByName(name:String):GameObject
	{
		return scene.getGameObjectByName(name);
	}
	
	private function getGameObjectsByName(name:String):Array<GameObject>
	{
		return scene.getGameObjectsByName(name);
	}
	
	private function get_transform():Transform
	{
		if (transform == null)
		{
			transform = gameObject.transform;
		}
		return transform;
	}
	
	private function get_collider():Collider
	{
		if (collider == null)
		{
			collider = gameObject.collider;
		}
		return collider;
	}
	
	private function get_render():Render
	{
		if (render == null)
		{
			render = gameObject.render;
		}
		return render;
	}
	
	override public function add<T:Object>(object:T):T 
	{
		if (Std.is(object, Component))
		{
			if (gameObject != null)
			{
				return gameObject.add(object);
			}
		}
		else if (Std.is(object, GameObject))
		{
			if (scene != null)
			{
				return scene.add(object);
			}
		}
		trace("Not Added");
		return null;
	}
	
	override public function remove(object:Object):Void 
	{
		if (Std.is(object, Component))
		{
			gameObject.remove(object);
		}
		else if (Std.is(object, GameObject))
		{
			scene.remove(object);
		}
		return null;
	}
	
	private function get_scene():Scene
	{
		return gameObject.scene;
	}
}