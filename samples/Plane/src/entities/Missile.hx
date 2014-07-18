package entities;
import scenes.MainScene;
import ze.component.graphic.displaylist.Image;
import ze.component.physics.BoxCollider;
import ze.component.physics.Collider;
import ze.object.GameObject;
/**
 * ...
 * @author Goh Zi He
 */
class Missile extends GameObject
{
	private static inline var speed:Int = -10;
	public function new(x:Float, y:Float)
	{
		super("Missle", x, y);
	}
	
	override public function added():Void 
	{
		super.added();
		addComponent(new Image("Missle", "gfx/Missile.png"));
		graphic.centered = true;
		addComponent(new BoxCollider(2, 8, true));
		collider.registerCallback(enterCollision);
	}
	
	override public function update():Void 
	{
		super.update();
		transform.moveBy(0, speed);
		
		if (transform.y < -10)
		{
			scene.removeGameObject(this);
		}
	}
	
	private function enterCollision(collider:Collider):Void
	{
		if (collider.gameObject.name == "Alien")
		{
			scene.removeGameObject(this);
			scene.removeGameObject(collider.gameObject);
			cast(scene, MainScene).addScore();
		}
	}
}