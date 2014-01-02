package boxed.prefab;

import flash.display.BitmapData;
import flash.geom.Rectangle;
import openfl.Assets;
import ze.component.rendering.Image;
import ze.object.GameObject;

/**
 * ...
 * @author Goh Zi He
 */
class TileObject extends GameObject
{
	private var _tileset:BitmapData;
	private var _tx:Float;
	private var _ty:Float;
	
	public function new(params:Dynamic<Int>)
	{
		super("floor", params.x * 32, params.y * 32);
		
		_tileset = Assets.getBitmapData("gfx/Checker.png");
		_tx = params.tx;
		_ty = params.ty;
	}
	
	override private function added():Void 
	{
		super.added();
		addComponent(getImageAt(_tx, _ty));
	}
	
	private function getImageAt(tx:Float, ty:Float):Image
	{
		var image:Image = new Image(tx + "" + ty, _tileset, new Rectangle(tx * 32, ty * 32, 32, 32));
		return image;
	}
}