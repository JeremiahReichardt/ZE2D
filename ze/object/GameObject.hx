package ze.object;

import ze.component.core.Component;
import ze.component.core.Transform;
import ze.component.physics.Collider;
import ze.component.rendering.Animation;
import ze.component.rendering.Render;

/**
 * Base object with a default set of components (Transform, Render)
 * Cannot be instantiated with new, must be created from Scene.createGameObject() method
 * @author Goh Zi He
 */

class GameObject extends Node
{
	public var selected(default, default):Bool;
	public var transform(get, null):Transform;
	public var collider(get, null):Collider;
	public var render(get, null):Render;
	public var scene(get, null):Scene;
	public var name(default, default):String;
	
	public function new(name:String = "", x:Float = 0, y:Float = 0) 
	{
		super();
		this.name = name;
		enable = true;
		transform = new Transform();
		transform.setPos(x, y);
		addComponent(transform);
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
	
	public function getComponent<T:Component>(componentType:Class<T>):T
	{
		var component:Component = null;
		var first:Node = _child.first;
		for (comp in first)
		{
			var current:Component = cast(comp, Component);
			if (Std.is(current, componentType))
			{
				component = current;
			}
		}
		return cast component;
	}
	
	public function addComponent<T:Node>(component:T):T 
	{
		addChild(component);
		if (Std.is(component, Render))
		{
			render = cast(component, Render);
		}
		else if (Std.is(component, Transform))
		{
			transform = cast(component, Transform);
		}
		else if (Std.is(component, Collider))
		{
			collider = cast(component, Collider);
		}
		
		return component;
	}
	
	public function removeComponent(node:Node):Void 
	{
		removeChild(node);
	}
	
	private function get_transform():Transform
	{
		if (transform == null)
		{
			transform = getComponent(Transform);
		}
		return transform;
	}
	
	private function get_collider():Collider
	{
		if (collider == null)
		{
			collider = getComponent(Collider);
		}
		return collider;
	}
	
	private function get_render():Render
	{
		if (render == null)
		{
			render = getComponent(Render);
		}
		return render;
	}
	
	private function get_scene():Scene
	{
		return cast (_parent, Scene);
	}
	
	override private function removed():Void 
	{
		super.removed();
		_child.removeAll();
		scene.engine.addToRemoveList(this);
	}
}