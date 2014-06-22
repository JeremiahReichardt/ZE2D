package prefab;
import actions.Switch;
import ze.component.graphic.tilesheet.AnimatedSprite;
import ze.component.physics.BoxCollider;
import ze.object.GameObject;

/**
 * ...
 * @author Goh Zi He
 */
class SwitchObject extends GameObject
{
	private var _switchIndex:Int;
	public function new(params:Dynamic<Int>)
	{
		super("switch", params.x, params.y);
		_switchIndex = params.switchIndex;
	}
	
	override private function added():Void 
	{
		super.added();
		addComponent(new BoxCollider(25, 13, true));
		var animation:AnimatedSprite = new AnimatedSprite("Switch");
		addComponent(animation);
		animation.addAnimation("idle", [0, 1, 2, 3, 4]);
		addComponent(new Switch(_switchIndex));
	}
}