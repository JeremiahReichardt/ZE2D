package prefab;
import components.Switch;
import ze.component.graphic.tilesheet.TileAnimation;
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
	
	override public function added():Void 
	{
		super.added();
		addComponent(new BoxCollider(25, 13, true));
		var animation:TileAnimation = new TileAnimation("game", "Switch");
		addComponent(animation);
		animation.addAnimation("idle", [0, 1, 2, 3, 4]);
		addComponent(new Switch(_switchIndex));
	}
}