package entities;
import scenes.MainScene;
import ze.component.graphic.displaylist.Image;
import ze.component.physics.BoxCollider;
import ze.object.GameObject;
import ze.util.MathUtil;

/**
 * ...
 * @author Goh Zi He
 */
class Alien extends GameObject 
{
	private var _speed:Float;
	override public function added():Void 
	{
		super.added();
		addComponent(new Image("Alien", "gfx/Alien.png"));
		addComponent(new BoxCollider(32, 24, true));
		_speed = MathUtil.randomFloat(4, 1);
	}
	
	override public function update():Void 
	{
		super.update();
		transform.moveBy(0, _speed);
		
		if (transform.y > scene.screen.height)
		{
			cast(scene, MainScene).loseHealth();
			scene.removeGameObject(this);
		}
	}
}