package puzzle.prefab;

import flash.display.BitmapData;
import flash.geom.Rectangle;
import openfl.Assets;
import puzzle.scene.MainScene;
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
	private var _x:Float;
	private var _y:Float;
	
	public function new(params:Dynamic<Int>)
	{
		super("floor", params.x * 32, params.y * 32);
		
		_tileset = Assets.getBitmapData("gfx/Checker.png");
		_tx = params.tx;
		_ty = params.ty;
		_x = params.x;
		_y = params.y;
	}
	
	override private function added():Void 
	{
		super.added();
		cast(scene, MainScene).grid.setGrid(Std.int(_x), Std.int(_y));
		addComponent(getImageAt(_tx, _ty));
	}
	
	private function getImageAt(tx:Float, ty:Float):Image
	{
		var image:Image = new Image(tx + "" + ty, _tileset, new Rectangle(tx * 32, ty * 32, 32, 32));
		return image;
	}
}