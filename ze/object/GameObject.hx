package ze.object;
import ze.component.core.Component;
import ze.component.core.Transform;
import ze.component.debug.GDebug;
import ze.component.graphic.Graphic;
import ze.component.physics.Collider;

/**
 * @author Goh Zi He
 */

class GameObject extends Node
{
	public var scene(get, null):Scene;
	public var graphic(get, null):Graphic;
	public var collider(get, null):Collider;
	public var transform(get, null):Transform;
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
	
	override public function update():Void 
	{
		if (_child == null)
		{
			return;
		}
		
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
	
	public function draw():Void 
	{
		if (graphic != null && graphic.visible)
		{
			graphic.draw();
		}
	}
	
	override public function removed():Void 
	{
		_child.removeAll();
		scene.engine.addToRemoveList(this);
		super.removed();
	}
	
	override public function destroyed():Void 
	{
		super.destroyed();
		transform = null;
		collider = null;
		graphic = null;
		scene = null;
	}
	
	public function getComponent<T:Component>(componentType:Class<T>):T
	{
		var component:Component = null;
		var node:Node = _child.first;
		while (node != null)
		{
			component = cast(node, Component);
			if (Std.is(component, componentType))
			{
				return cast component;
			}
			node = node._next;
		}
		return null;
	}
	
	public function addComponent<T:Node>(component:T):T 
	{
		attachChild(component);
		if (Std.is(component, Graphic))
		{
			graphic = cast(component, Graphic);
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
		detachChild(node);
	}
	
	/**
	 * Will remove this gameObject from the scene, same as calling
	 * scene.removeGameObject(this);
	 */
	public function kill():Void
	{
		scene.removeGameObject(this);
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
	
	private function get_graphic():Graphic
	{
		if (graphic == null)
		{
			graphic = getComponent(Graphic);
		}
		return graphic;
	}
	
	private function get_scene():Scene
	{
		return (cast(_parent, Scene));
	}
	
	private function log(msg:Dynamic):Void
	{
		GDebug.logMsg(msg);
	}
}