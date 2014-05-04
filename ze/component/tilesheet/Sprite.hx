package ze.component.tilesheet;
import ze.component.core.Component;
import ze.util.Screen;

/**
 * ...
 * @author Goh Zi He
 */
class Sprite extends Graphic
{
	override function added():Void 
	{
		super.added();
		_tileID = _screen.getTileID(_name);
		update();
	}
}