package objects;

import action.PlayerGun;
import action.PlayerMovement;
import ze.component.physics.BoxCollider;
import ze.component.rendering.Animation;
import ze.object.GameObject;

/**
 * ...
 * @author Goh Zi He
 */
class Player extends GameObject
{
	public function new() 
	{
		super("Player", 200, 200);
	}
	
	override private function added():Void 
	{
		super.added();
		
		var animation:Animation = new Animation("Square", "gfx/Square.png", 32, 32);
		animation.addAnimationFromFrame("idle", 0, 10);
		animation.play("idle");
		
		addComponent(animation);
		addComponent(new BoxCollider(32, 32));
		addComponent(new PlayerMovement());
		addComponent(new PlayerGun());
		
	}
}