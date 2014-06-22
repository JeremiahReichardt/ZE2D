package prefab;
import ze.component.graphic.tilesheet.Sprite;
import ze.component.physics.BoxCollider;
import ze.object.GameObject;

/**
 * ...
 * @author Goh Zi He
 */
class HorizontalGateObject extends GameObject
{
	public function new(params:Dynamic<Int>)
	{
		super("gate" + params.gateIndex, params.x, params.y);
	}
	
	override private function added():Void 
	{
		super.added();
		addComponent(new BoxCollider(64, 32));
		var image:Sprite = new Sprite("HorizontalGate");
		addComponent(image);
		image.layer = 1;
	}
}