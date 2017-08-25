package ze.util;
import haxe.ds.StringMap;
import openfl.Assets;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Goh Zi He
 */
class TileSheetLayer 
{
  public function new(name:String, width:Int, height:Int) 
  {
    var bmData = Assets.getBitmapData(name + ".png");
    _tileSet = new Tileset(bmData);
    
    _tiles = new StringMap();
    _tileWidth = new Array<Float>();
    _tileHeight = new Array<Float>();
    
    loadXML(name + ".xml");
    tileMap = new Tilemap(width, height, _tileSet);
  }
  
  function loadXML(name:String)
  {
    var xml:Xml = Xml.parse(Assets.getText(name));
		var root:Xml = xml.firstElement();
		
		for (sprite in root.elements())
		{
			var type:String = sprite.get("type");
			//var tileName:String = sprite.get("n");
			var x:Float = Std.parseFloat(sprite.get("x"));
			var y:Float = Std.parseFloat(sprite.get("y"));
			var width:Float = Std.parseFloat(sprite.get("w"));
			var height:Float = Std.parseFloat(sprite.get("h"));
      
			if (type == "multiple")
			{
				var tileWidth:Float = Std.parseFloat(sprite.get("tw"));
				var tileHeight:Float = Std.parseFloat(sprite.get("th"));
				var totalWidth:Int = Math.floor(width / tileWidth);
				var totalHeight:Int = Math.floor(height / tileHeight);
        
        _tileWidth.push(tileWidth);
        _tileHeight.push(tileHeight);
				
				for (row in 0 ... totalHeight)
				{
					for (column in 0 ... totalWidth)
					{
						_tileSet.addRect(new Rectangle(x + (column * tileWidth), y + (row * tileHeight), tileWidth, tileHeight));
					}
				}
			}
			else if (type == "single")
			{
        _tileWidth.push(width);
        _tileHeight.push(height);
        
        _tileSet.addRect(new Rectangle(x, y, width, height));
			}
			//else if (type == "font")
			//{
				//var font:TilesheetTextFont = TilesheetText.registerFont(tileName, this);
				//var xml:Xml = Xml.parse(Assets.getText("font/" + tileName + ".xml"));
				//for (element in xml.firstElement().elementsNamed("chars"))
				//{
					//for (char in element.elements())
					//{
						//var id:Int = Std.parseInt(char.get("id"));
						//var charX:Float = Std.parseFloat(char.get("x"));
						//var charY:Float = Std.parseFloat(char.get("y"));
						//var charWidth:Float = Std.parseFloat(char.get("width"));
						//var charHeight:Float = Std.parseFloat(char.get("height"));
						//
						//var rect:Rectangle = new Rectangle(x + charX, y + charY, charWidth, charHeight);
						//var index:Int = addRect(rect);
						//font.setChar(String.fromCharCode(id), charWidth, charHeight, index);
						//data.push(index);
					//}
				//}
			//}
			
			//_sprites.set(tileName, data);
		}
  }
  
  public function getID(name:String)
  {
    return _tiles.get(name);
  }
  
  public function getWidth(id:Int):Float
  {
    return _tileWidth[id];
  }
  
  public function getHeight(id:Int):Float
  {
    return _tileHeight[id];
  }
  
  var _tiles:StringMap<Int>;
  var _tileSet:Tileset;
  var _tileWidth:Array<Float>;
  var _tileHeight:Array<Float>;
  
  public var tileMap(default, null):Tilemap;
}