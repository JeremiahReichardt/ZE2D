package puzzle.prefab;

import puzzle.actions.Respawn;
import ze.component.physics.BoxCollider;
import ze.component.rendering.Animation;
import ze.object.GameObject;

/**
 * ...
 * @author Goh Zi He
 */
class RespawnObject extends GameObject
{
	public function new(params:Dynamic<Int>)
	{
		super("respawn", params.x, params.y);
	}
	
	override private function added():Void 
	{
		super.added();
		
		var animation:Animation = new Animation("respawn", "gfx/Respawn.png", 32, 8);
		addComponent(animation);
		animation.addAnimation("idle", [0]);
		animation.addAnimation("activated", [1]);
		animation.play("idle", 10);
		
		addComponent(new BoxCollider(32, 8, true));
		addComponent(new Respawn());
	}
}