package prefab;
import actions.Sign;
import ze.component.graphic.tilesheet.Sprite;
import ze.component.physics.BoxCollider;
import ze.object.GameObject;

/**
 * ...
 * @author Goh Zi He
 */
class SignObject extends GameObject
{
	private var _sign:Sign;
	private var _signIndex:Int;
	
	public function new(params:Dynamic<Int>)
	{
		super("sign" + params.signIndex, params.x, params.y);
		_signIndex = params.signIndex;
	}
	
	override public function added():Void 
	{
		super.added();
		addComponent(new BoxCollider(32, 32, true));
		addComponent(new Sprite("Sign"));
		
		_sign = new Sign();
		addComponent(_sign);
		
		switch (_signIndex)
		{
			case 0:
				_sign.addText("Press Enter/Space to shoot, press again\n to teleport.");
			case 1:
				_sign.addText("If you die, respawn from here.");
			case 2:
				_sign.addText("Press W to aim up.");
		}
	}
}