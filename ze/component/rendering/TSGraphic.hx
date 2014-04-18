package ze.component.rendering;
import ze.component.core.Component;

/**
 * ...
 * @author Goh Zi He
 */
class TSGraphic extends Component
{
	/**
	 * Lower layer are rendered first. (Higher layer appears on top)
	 */
	public var layer(default, set):Int;
	
	private var _tileIndex:Int;
	
	public function new(layer:Int = 0)
	{
		super();
		this.layer = layer;
	}
	
	override function update():Void 
	{
		super.update();
		scene.screenTileSheet.addToDraw(layer, [transform.x, transform.y, _tileIndex]);
	}
	
	private function set_layer(value:Int):Int
	{
		var highestLayer:Int = scene.screenTileSheet.getHighestLayer();
		if (value > highestLayer)
		{
			value = highestLayer + 1;
		}
		
		layer = value;
		return layer;
	}
}