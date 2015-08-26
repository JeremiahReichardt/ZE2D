package prefab;
import components.game.MouseSelectMovement;
import components.player.PlayerController;
import ze.component.graphic.tilesheet.TilesheetSprite;
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
		addComponent(new TilesheetSprite("Player"));
		addComponent(new MouseSelectMovement());
	}
}