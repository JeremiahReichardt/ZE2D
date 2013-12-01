package ze.object;

import ze.component.core.Component;
import ze.component.core.Transform;
import ze.component.physics.Collider;
import ze.component.rendering.Animation;
import ze.component.rendering.Render;
import ze.object.Object;

/**
 * Base object with a default set of components (Transform, Render)
 * Cannot be instantiated with new, must be created from Scene.createGameObject() method
 * @author Goh Zi He
 */

class GameObject extends Object
{
	public var selected(default, default):Bool;
	public var transform(get, null):Transform;
	public var collider(get, null):Collider;
	public var render(get, null):Render;
	public var animation(get, null):Animation;
	public var scene(default, null):Scene;
	
	public function new(name:String = "", x:Float = 0, y:Float = 0) 
	{
		super();
		this.name = name;
		enable = true;
		transform = new Transform();
		transform.setPos(x, y);
		add(transform);
	}
	
	override private function removed():Void
	{
		removeAllComponents();
	}
	
	public function getComponent<T:Component>(componentType:Class<T>):T
	{
		for (component in _objects)
		{
			if (Std.is(component, componentType))
			{
				return cast component;
			}
		}
		return null;
	}
	
	override public function add<T:Object>(object:T):T 
	{
		if (Std.is(object, Component)) 
		{
			Reflect.setProperty(object, "gameObject", this);
			return super.add(object);
		}
		else if (Std.is(object, GameObject))
		{
			return scene.add(object);
		}
		trace("Not component or gameobject");
		return null;
	}
	
	override public function remove(object:Object):Void 
	{
		if (Std.is(object, Component)) 
		{
			super.remove(object);
		}
		else if (Std.is(object, GameObject))
		{
			return scene.remove(object);
		}
	}
	
	private function removeAllComponents():Void
	{
		for (component in _objects)
		{
			remove(component);
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
}