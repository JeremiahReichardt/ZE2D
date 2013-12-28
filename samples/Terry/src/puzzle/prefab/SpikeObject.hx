package puzzle.prefab;

import puzzle.actions.Spikes;
import ze.component.physics.BoxCollider;
import ze.object.GameObject;

/**
 * ...
 * @author Goh Zi He
 */
class SpikeObject extends GameObject
{
	private var _width:Float;
	private var _height:Float;
	
	public function new(params:Dynamic<Int>)
	{
		super("spikes", params.x, params.y);
		_width = params.w;
		_height = params.h;
	}
	
	override private function added():Void 
	{
		super.added();
		addComponent(new BoxCollider(_width, _height, true));
		addComponent(new Spikes());
	}
}