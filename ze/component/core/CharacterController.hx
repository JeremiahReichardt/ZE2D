package ze.component.core;

/**
 * ...
 * @author Goh Zi He
 */
class CharacterController extends Component
{
	public var isGrounded(default, null):Bool;
	public var hitTop(default, null):Bool;
	
	override private function added():Void 
	{
		super.added();
		if (draw == null)
		{
			trace("Add a draw component");
		}
	}
	
	override private function update():Void 
	{
		super.update();
		collider.setPos(transform.x, transform.y + 1);
		isGrounded = (collider.checkCollisionWith() != null);
		
		collider.setPos(transform.x, transform.y - 1);
		hitTop = collider.checkCollisionWith() != null;
	}
}