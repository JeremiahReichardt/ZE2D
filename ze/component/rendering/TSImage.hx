package ze.component.rendering;

/**
 * ...
 * @author Goh Zi He
 */

class TSImage extends TSGraphic
{
	public function new(label:String, layer:Int = 0) 
	{
		super(layer);
		_tileIndex = scene.screenTileSheet.getTileIndex(label);
	}
}