package ze.component.graphic.tilesheet;

/**
 * ...
 * @author Goh Zi He
 */
class TilesheetSprite extends TilesheetObject
{
	override function added():Void 
	{
		super.added();
		_tileID = _tileSheetLayer.getSprite(_name);
		update();
	}
}