package ze.component.core;

/**
 * ...
 * @author Goh Zi He
 */
class CharacterController extends Component
{
	public var isGrounded(default, null):Bool;
	public var hitTop(default, null):Bool;
	
	override private function update():Void 
	{
		super.update();
		collider.set(transform.x, transform.y + 1, render.width, render.height);
		isGrounded = (collider.checkCollisionWith() != null);
		
		collider.set(transform.x, transform.y - 1, render.width, render.height);
		hitTop = collider.checkCollisionWith() != null;
	}
}