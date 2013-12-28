package puzzle.actions;

import puzzle.prefab.RespawnObject;
import ze.component.core.Component;
import ze.component.physics.Collider;
import ze.component.rendering.Animation;
import ze.object.GameObject;

/**
 * ...
 * @author Goh Zi He
 */
class Respawn extends Component
{
	override private function added():Void 
	{
		super.added();
		collider.registerCallback(hit);
	}
	
	private function hit(collider:Collider):Void
	{
		if (collider.gameObject.name == "player")
		{
			var player:Player = collider.gameObject.getComponent(Player);
			player.respawnPoint = this;
			disableAllRespawnPoint();
		}
	}
	
	private function disableAllRespawnPoint():Void
	{
		var respawnPoints:Array<GameObject> = scene.getGameObjectsByName("respawn");
		for (go in respawnPoints)
		{
			var anim:Animation = go.getComponent(Animation);
			if (go == gameObject)
			{
				anim.play("activated", 10);
			}
			else
			{
				anim.play("idle", 10);
			}
		}
	}
}