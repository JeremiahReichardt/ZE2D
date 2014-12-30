package prefab;
import action.game.MouseSelectMovement;
import action.player.PlayerController;
import ze.component.graphic.tilesheet.Sprite;
import ze.component.physics.BoxCollider;
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
	
	override public function added():Void 
	{
		super.added();
		addComponent(new BoxCollider(32, 32, true));
		addComponent(new PlayerController(_playerIndex));
		addComponent(new Sprite("Player"));
		addComponent(new MouseSelectMovement());
	}
}