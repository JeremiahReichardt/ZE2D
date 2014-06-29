package action.item;
import action.game.ItemManager;
import action.player.CharacterController;
import action.player.CountDown;
import ze.component.core.Component;
import ze.component.physics.Collider;

/**
 * ...
 * @author Goh Zi He
 */
class PickItem extends Component
{
	private var _itemManager:ItemManager;
	
	override public function added():Void 
	{
		super.added();
		collider.registerCallback(onCollide);
		_itemManager = getGameObjectByName("item_manager").getComponent(ItemManager);
	}
	
	private function onCollide(collider:Collider):Bool
	{
		if (collider.getComponent(CharacterController) != null)
		{
			collider.addComponent(new CountDown());
			return true;
		}
		return false;
	}
}