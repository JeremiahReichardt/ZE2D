package ze.component.core;

import ze.component.physics.Collider;
import ze.component.rendering.Render;
import ze.object.GameObject;
import ze.object.Node;
import ze.object.Object;
import ze.object.Scene;

/**
 * ...
 * @author Goh Zi He
 */

class Component extends Node
{
	public var transform(get, null):Transform;
	public var collider(get, null):Collider;
	public var render(get, null):Render;
	public var gameObject(get, null):GameObject;
	public var scene(get, null):Scene;
	
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
		return gameObject.transform;
	}
	
	private function get_collider():Collider
	{
		return gameObject.collider;
	}
	
	private function get_render():Render
	{
		return gameObject.render;
	}
	
	public function addComponent<T:Node>(node:T):T 
	{
		return gameObject.addChild(node);
	}
	
	public function removeComponent(component:Node):Void 
	{
		removeChild(component);
	}
	
	private function get_gameObject():GameObject
	{
		return cast (_parent, GameObject);
	}
	
	private function get_scene():Scene
	{
		if (scene == null)
		{
			scene = engine.scene;
		}
		return scene;
	}
	
	override private function removed():Void 
	{
		super.removed();
		engine.addToRemoveList(this);
	}
	
	override private function destroyed():Void 
	{
		super.destroyed();
		
		transform = null;
		collider = null;
		render = null;
		scene = null;
		gameObject = null;
	}
}