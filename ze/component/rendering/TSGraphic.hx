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
	public var layer(default, default):Int;
	
	private var _tileIndex:Int;
	
	public function new()
	{
		super();
	}
	
	override function update():Void 
	{
		super.update();
		scene.screenTileSheet.addToDraw(0, [transform.x, transform.y, _tileIndex]);
	}
}