package ze.object;

import ze.component.core.Component;
import ze.component.core.Transform;
import ze.component.physics.Collider;
import ze.component.rendering.Animation;
import ze.component.rendering.Render;
import ze.Engine;

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
	public var animation(get, null):Animation;
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
		
		var first:Node = _child.getFirstNode();
		for (node in first)
		{
			node.update();
		}
	}
	
	public function getComponent<T:Component>(componentType:Class<T>):T
	{
		var node:Node = _child;
		while (node._next != null)
		{
			if (Std.is(node, componentType))
			{
				return cast node;
			}
			node = node._next;
		}
		
		node = _child;
		while (node._previous != null)
		{
			if (Std.is(node, componentType))
			{
				return cast node;
			}
			node = node._previous;
		}
		
		return null;
	}
	
	public function addComponent<T:Node>(node:T):T 
	{
		if (_child == null)
		{
			addChild(node);
		}
		else
		{
			_child.addNode(node);
		}
		return node;
	}
	
	public function removeComponent(node:Node):Void 
	{
		if (_child == node)
		{
			removeChild(node);
		}
		else
		{
			_child.addNode(node);
		}
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
	
	private function get_animation():Animation
	{
		if (animation == null)
		{
			animation = getComponent(Animation);
		}
		return animation;
	}
	
	private function get_scene():Scene
	{
		return cast (Engine.getEngine()._child, Scene);
	}
	
	override private function removeNext():Void 
	{
		var next:GameObject = cast(_next, GameObject);
		var child:Component = cast(_child, Component);
		
		if (next != null)
		{
			next.removeNext();
		}
		
		if (_child != null)
		{
			child.removeNext();
		}
		
		super.removeNext();
	}
	
	override private function removed():Void 
	{
		var node:Node = _child;
		while (node._next != null)
		{
			node.removed();
			node = node._next;
		}
		
		node = _child;
		//while (node._previous != null)
		//{
			//node.removed();
			//node = node._previous;
		//}
		//
		//var iter:Node = node = _child._next;
		//while (node._next != null)
		//{
			//iter = node._next;
			//node.cleanup();
			//node = iter;
		//}
		//
		//iter = node = _child._previous;
		//while (node._previous != null)
		//{
			//iter = node._next;
			//node.cleanup();
			//node = iter;
		//}
		//_child.cleanup();
	}
}