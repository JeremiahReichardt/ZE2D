package ze.component.physics;

import ze.component.physics.BoxCollider;
import ze.component.physics.Collider;

/**
 * ...
 * @author Goh Zi He
 */

class BoxCollider extends Collider
{	
	public function new(width:Float, height:Float, trigger:Bool = false) 
	{
		super(width, height, trigger);
	}
	
	override public function hitTest(collider:Collider):Bool 
	{
		if (super.hitTest(collider))
		{
			if (Std.is(collider, GridCollider))
			{
				return collider.hitTest(this);
			}
			return true;
		}
		return false;
	}
}