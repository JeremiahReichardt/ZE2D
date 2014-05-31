package prefab;
import action.game.MouseSelectMovement;
import action.player.CharacterController;
import ze.component.physics.BoxCollider;
import ze.component.tilesheet.Sprite;
import ze.object.GameObject;

/**
 * ...
 * @author Goh Zi He
 */
class PlayerObject extends GameObject
{
	private var _playerIndex:Int;
	public function new(params:Dynamic<Int>)
	{
		super("player" + params.playerIndex, params.x, params.y);
		_playerIndex = params.playerIndex;
		
	}
	
	override private function added():Void 
	{
		super.added();
		
		addComponent(new BoxCollider(32, 32, true));
		addComponent(new CharacterController(_playerIndex));
		addComponent(new Sprite("Player"));
		addComponent(new MouseSelectMovement());
	}
}