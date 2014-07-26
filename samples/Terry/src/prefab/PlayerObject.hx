package prefab;
import actions.MouseSelectMovement;
import actions.gameObjects.Player;
import ze.component.core.CharacterController;
import ze.component.graphic.tilesheet.Sprite;
import ze.component.physics.BoxCollider;
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
	
	override public function added():Void 
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