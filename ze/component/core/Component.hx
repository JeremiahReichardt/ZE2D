package ze.component.core;
import ze.component.graphic.Graphic;
import ze.component.physics.Collider;
import ze.object.GameObject;
import ze.object.Node;
import ze.object.Scene;

/**
 * ...
 * @author Goh Zi He
 */

class Component extends Node
{
	public var scene(get, null):Scene;
	public var graphic(get, null):Graphic;
	public var collider(get, null):Collider;
	public var transform(get, null):Transform;
	public var gameObject(get, null):GameObject;
	
	public function getComponent<T:Component>(componentType:Class<T>):T
	{
		return gameObject.getComponent(componentType);
	}
	
	private function isNamed(name:String):Bool
	{
		if (gameObject != null)
		{
			if (gameObject.name == name)
			{
				return true;
			}
		}
		return false;
	}
	
	private function getGameObjectByName(name:String):GameObject
	{
		return scene.getGameObjectByName(name);
	}
	
	private function getGameObjectsByName(name:String):Array<GameObject>
	{
		return scene.getGameObjectsByName(name);
	}
	
	public function getAllGameObjects():Array<GameObject>
	{
		return scene.getAllGameObjects();
	}
	
	private function get_transform():Transform
	{
		return gameObject.transform;
	}
	
	private function get_collider():Collider
	{
		return gameObject.collider;
	}
	
	private function get_graphic():Graphic
	{
		return gameObject.graphic;
	}
	
	public function addComponent<T:Node>(node:T):T 
	{
		return gameObject.attachChild(node);
	}
	
	public function removeComponent(component:Node):Void 
	{
		detachChild(component);
	}
	
	private function get_gameObject():GameObject
	{
		return cast (_parent, GameObject);
	}
	
	private function get_scene():Scene
	{
		return gameObject.scene;
	}
	
	override public function removed():Void 
	{
		super.removed();
		scene.engine.addToRemoveList(this);
	}
	
	override public function destroyed():Void 
	{
		super.destroyed();
		transform = null;
		collider = null;
		graphic = null;
		scene = null;
		gameObject = null;
	}
}