package ze.component.rendering;

/**
 * ...
 * @author Goh Zi He
 */
class TSGraphic extends Draw
{
	private var _tileIndex:Int;
	
	public function new()
	{
		super();
		width = scene.screenTileSheet.getTileRect(_tileIndex).width;
		height = scene.screenTileSheet.getTileRect(_tileIndex).height;
	}
	
	override function update():Void 
	{
		super.update();
		if (!visible)
		{
			return;
		}
		addToDraw();
	}
	
	public function addToDraw():Void
	{
		scene.screenTileSheet.addToDraw(layer, [transform.x + scene.screenTileSheet.x, transform.y + scene.screenTileSheet.y, _tileIndex]);
	}
	
	override private function set_layer(value:Int):Int
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