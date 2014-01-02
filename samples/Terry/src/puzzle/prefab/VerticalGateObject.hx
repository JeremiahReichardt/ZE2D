package puzzle.prefab;

import ze.component.physics.BoxCollider;
import ze.component.rendering.Image;
import ze.object.GameObject;
import ze.util.Input;

/**
 * ...
 * @author Goh Zi He
 */
class VerticalGateObject extends GameObject
{
	public function new(params:Dynamic<Int>)
	{
		super("gate" + params.gateIndex, params.x, params.y);
	}
	
	override private function added():Void 
	{
		super.added();
		
		addComponent(new BoxCollider(32, 64));
		
		var image:Image = new Image("VerticalGate", "gfx/VerticalGate.png");
		image.layer = 1;
		addComponent(image);
	}
}