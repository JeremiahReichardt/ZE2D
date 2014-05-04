package ze.util;
import flash.geom.Rectangle;
import haxe.ds.StringMap;
import openfl.Assets;
import openfl.display.Tilesheet;
import ze.object.Scene;

/**
 * ...
 * @author Goh Zi He
 */
class TileSheetLoader
{
	private var _regions:StringMap<SpriteInfo>;
	private var _screen:Screen;
	private var _atlasFile:String;
	private var _tileSheet:Tilesheet;
	
	public function new(atlasFile:String, screen:Screen) 
	{
		_regions = new StringMap<SpriteInfo>();
		_screen = screen;
		_atlasFile = atlasFile;
	}
	
	public function defineRegion(name:String, width:Float, height:Float):Void
	{
		_regions.set(name, new SpriteInfo(width, height));
	}
	
	public function loadAtlas():Void
	{
		var xml:Xml = Xml.parse(Assets.getText(_atlasFile));
		var root:Xml = xml.firstElement();
		var imagePath:String = root.get("imagePath");
		_screen.loadTileSheet(Assets.getBitmapData("atlas/" + imagePath));
		
		for (sprite in root.elements())
		{
			var x:Float = Std.parseFloat(sprite.get("x"));
			var y:Float = Std.parseFloat(sprite.get("y"));
			var width:Float = Std.parseFloat(sprite.get("width"));
			var height:Float = Std.parseFloat(sprite.get("height"));
			
			var tileName:String = sprite.get("name");
			tileName = tileName.substr(0, tileName.length - 4);
			
			if (_regions.exists(tileName))
			{
				var spriteInfo:SpriteInfo = _regions.get(tileName);
				_screen.addTileRect(tileName, x, y, spriteInfo.width, spriteInfo.height, width, height);
			}
			else
			{
				var rectangle:Rectangle = new Rectangle(x, y, width, height);
				_screen.addRect(tileName, rectangle);
			}
		}
		
		_regions = null;
		_tileSheet = null;
		_screen = null;
		
	}
}

private class SpriteInfo
{
	public var width:Float;
	public var height:Float;
	
	public function new(width:Float, height:Float)
	{
		this.width = width;
		this.height = height;
	}
}