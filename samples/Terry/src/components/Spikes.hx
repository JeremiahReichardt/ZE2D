package components;
import ze.component.core.Component;
import ze.component.physics.Collider;

/**
 * ...
 * @author Goh Zi He
 */
class Spikes extends Component
{
	override public function added():Void 
	{
		super.added();
		collider.registerCallback(hitSpike);
	}
	
	private function hitSpike(collider:Collider):Void
	{
		if (collider.gameObject.name == "player")
		{
			var player:Player = collider.gameObject.getComponent(Player);
			player.die();
		}
	}
}