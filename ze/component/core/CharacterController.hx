package ze.component.core;
import ze.component.physics.BoxCollider;
import ze.component.physics.Collider;

/**
 * ...
 * @author Goh Zi He
 */
class CharacterController extends Component
{
	public var isGrounded(default, null):Bool;
	public var hitTop(default, null):Bool;
	
	override public function added():Void 
	{
		super.added();
		if (graphic == null)
		{
			trace("Add a graphic component");
		}
		if (collider == null)
		{
			trace("Add a collider component");
		}
	}
	
	override public function update():Void 
	{
		super.update();
		collider.setPos(transform.x, transform.y + 1);
		isGrounded = (collider.checkCollisionWith() != null);
		
		collider.setPos(transform.x, transform.y - 1);
		hitTop = collider.checkCollisionWith() != null;
	}
}