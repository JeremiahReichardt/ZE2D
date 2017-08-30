package prefab;
import ze.component.graphic.tilesheet.TileImage;
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
	
	override public function added():Void 
	{
		super.added();
		addComponent(new BoxCollider(64, 32));
		var image:TileImage = new TileImage("game", "HorizontalGate");
		addComponent(image);
		image.layer = 1;
	}
}