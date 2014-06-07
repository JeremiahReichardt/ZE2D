package prefab;
import actions.MouseSelectMovement;
import actions.Player;
import ze.component.core.CharacterController;
import ze.component.physics.BoxCollider;
import ze.component.tilesheet.Sprite;
import ze.object.GameObject;

/**
 * ...
 * @author Goh Zi He
 */
class PlayerObject extends GameObject
{
	public function new(params:Dynamic<Int>)
	{
		super("player", params.x, params.y);
	}
	
	override private function added():Void 
	{
		super.added();
		var image:Sprite = new Sprite("Player");
		addComponent(image);
		image.layer = 1;
		addComponent(new BoxCollider(16, 16));
		addComponent(new CharacterController());
		addComponent(new Player());
		addComponent(new MouseSelectMovement());
	}
}