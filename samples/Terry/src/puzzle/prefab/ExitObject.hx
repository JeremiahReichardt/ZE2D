package puzzle.prefab;

import puzzle.actions.Exit;
import ze.component.physics.BoxCollider;
import ze.component.rendering.Animation;
import ze.object.GameObject;

/**
 * ...
 * @author Goh Zi He
 */
class ExitObject extends GameObject
{
	public function new(params:Dynamic<Int>)
	{
		super("exit", params.x, params.y);
	}
	
	override private function added():Void 
	{
		super.added();
		addComponent(new BoxCollider(32, 32, true));
		var animation:Animation = new Animation("Exit", "gfx/Exit.png", 32, 32);
		addComponent(animation);
		animation.addAnimation("idle", [0, 1, 2, 3]);
		animation.play("idle", 4);
		addComponent(new Exit());
	}
}