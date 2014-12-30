package ze.component.physics;
import ze.component.physics.Collider;

/**
 * ...
 * @author Goh Zi He
 */
class CircleCollider extends Collider
{
	public var radius(default, null):Float;
	
	public function new(radius:Float, trigger:Bool = false) 
	{
		super(trigger);
		this.radius = radius;
		width = height = radius;
	}
}