package ze.util;
import flash.geom.Rectangle;
import openfl.Assets;
import ze.system.TSScreen;

/**
 * ...
 * @author Goh Zi He
 */
class SpriteLoader
{	
	public static function loadFromTexturePacker(name:String):Void
	{
		parseXml(name, "imagePath", "x", "y", "w", "h", "n");
	}
	
	public static function loadFromShoeBox(name:String):Void
	{
		parseXml(name, "imagePath", "x", "y", "width", "height", "name");
	}
	
	private static function parseXml(xmlFile:String, imagePath:String, x:String, y:String, width:String, height:String, name:String):Void
	{
		var xml:Xml = Xml.parse(Assets.getText(xmlFile));
		var root:Xml = xml.firstElement();
		var imagePath:String = root.get(imagePath);
		var screen:TSScreen = Engine.getEngine().scene.screenTileSheet;
		screen.loadTileSheet("gfx/" + imagePath);
		
		for (sprite in root.elements())
		{
			var rectangle:Rectangle = new Rectangle();
			rectangle.x = Std.parseInt(sprite.get(x));
			rectangle.y = Std.parseInt(sprite.get(y));
			if (sprite.exists(width)) rectangle.width = Std.parseInt(sprite.get(width));
			if (sprite.exists(height)) rectangle.height = Std.parseInt(sprite.get(height));
			
			var tileName:String = sprite.get(name);
			tileName = tileName.substr(0, tileName.length - 4);
			screen.addRect(tileName, rectangle);
		}
	}
}