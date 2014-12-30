package ze.component.core;

/**
 * This is for typcial platformer character codes, it includes
 * isGrounded checks for character that is standing on a platform
 * and also a hitTop for character if it hit the ceiling.
 * @author Goh Zi He
 */
class CharacterController extends Component
{
	public var isGrounded(default, null):Bool;
	public var hitTop(default, null):Bool;
	
	override public function added():Void 
	{
		super.added();
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