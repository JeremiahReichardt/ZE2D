package boxed.prefab;

import ze.component.physics.BoxCollider;
import ze.object.GameObject;

/**
 * ...
 * @author Goh Zi He
 */
class ColliderObject extends GameObject
{
	public function new(params:Dynamic<Int>)
	{
		super("collisionbox", params.x, params.y);
		
		addComponent(new BoxCollider(params.w, params.h));
	}
}