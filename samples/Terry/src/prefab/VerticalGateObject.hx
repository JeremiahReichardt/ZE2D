package prefab;
import ze.component.graphic.tilesheet.TilesheetSprite;
import ze.component.physics.BoxCollider;
import ze.object.GameObject;

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
	
	override public function added():Void 
	{
		super.added();
		addComponent(new BoxCollider(32, 64));
		var image:TilesheetSprite = new TilesheetSprite("VerticalGate");
		addComponent(image);
		image.layer = 1;
	}
}