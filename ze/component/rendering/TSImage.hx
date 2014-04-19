package ze.component.rendering;

/**
 * ...
 * @author Goh Zi He
 */

class TSImage extends TSGraphic
{
	public function new(label:String) 
	{
		_tileIndex = scene.screenTileSheet.getTileIndex(label);
		super();
	}
}