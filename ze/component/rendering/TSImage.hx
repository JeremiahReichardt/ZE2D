package ze.component.rendering;
import ze.component.core.Component;
import ze.util.SpriteLoader;

/**
 * ...
 * @author Goh Zi He
 */

class TSImage extends TSGraphic
{
	public function new(label:String) 
	{
		super();
		_tileIndex = scene.screenTileSheet.getTileIndex(label);
	}
}