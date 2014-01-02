package boxed.prefab;

import boxed.action.game.MouseSelectMovement;
import boxed.action.player.CharacterController;
import ze.component.physics.BoxCollider;
import ze.component.rendering.Image;
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
		addComponent(new Image("player", "gfx/Player.png"));
		addComponent(new MouseSelectMovement());
	}
}