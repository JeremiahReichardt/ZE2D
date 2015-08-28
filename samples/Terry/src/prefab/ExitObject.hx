package prefab;
import components.Exit;
import ze.component.graphic.tilesheet.AnimatedSprite;
import ze.component.physics.BoxCollider;
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
	
	override public function added():Void 
	{
		super.added();
		addComponent(new BoxCollider(32, 32, true));
		var animation:AnimatedSprite = new AnimatedSprite("Exit");
		addComponent(animation);
		animation.addAnimation("idle", [0, 1, 2, 3]);
		animation.play("idle", 4);
		addComponent(new Exit());
	}
}