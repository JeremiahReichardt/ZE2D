package prefab;
import components.Respawn;
import ze.component.graphic.tilesheet.AnimatedSprite;
import ze.component.physics.BoxCollider;
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
	
	override public function added():Void 
	{
		super.added();
		var animation:AnimatedSprite = new AnimatedSprite("Respawn");
		addComponent(animation);
		animation.addAnimation("idle", [0]);
		animation.addAnimation("activated", [1]);
		animation.play("idle", 10);
		
		addComponent(new BoxCollider(32, 8, true));
		addComponent(new Respawn());
	}
}