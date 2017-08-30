package prefab;
import components.MouseSelectMovement;
import components.Player;
import ze.component.core.CharacterController;
import ze.component.graphic.tilesheet.TileImage;
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
		var image:TileImage = new TileImage("game", "Player");
		addComponent(image);
		image.layer = 1;
		addComponent(new BoxCollider(16, 16));
		addComponent(new CharacterController());
		addComponent(new Player());
		addComponent(new MouseSelectMovement());
	}
}