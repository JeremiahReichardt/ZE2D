package puzzle.prefab;

import puzzle.actions.Sign;
import ze.component.physics.BoxCollider;
import ze.component.rendering.Image;
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
	
	override private function added():Void 
	{
		super.added();
		
		addComponent(new BoxCollider(32, 32, true));
		addComponent(new Image("Sign", "gfx/Sign.png"));
		
		_sign = new Sign();
		addComponent(_sign);
		
		switch (_signIndex)
		{
			case 0:
				_sign.addText("Press Enter/Space to shoot, press again to teleport.");
			case 1:
				_sign.addText("If you die, respawn from here.");
			case 2:
				_sign.addText("Press W to aim up.");
			case 3:
				_sign.addText("Shoot and touch the spikes. Press shoot again.");
		}
	}
}