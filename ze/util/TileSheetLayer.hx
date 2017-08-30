package ze.util;
import haxe.ds.StringMap;
import openfl.Assets;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.geom.Rectangle;
import ze.component.graphic.tilesheet.TileText;
import ze.component.graphic.tilesheet.TileText.TileTextFont;

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
			var tileName:String = sprite.get("n");
			var x:Float = Std.parseFloat(sprite.get("x"));
			var y:Float = Std.parseFloat(sprite.get("y"));
			var width:Float = Std.parseFloat(sprite.get("w"));
			var height:Float = Std.parseFloat(sprite.get("h"));
      var data:Array<Int> = new Array<Int>();
      
      var tileWidth:Float = width;
      var tileHeight:Float = height;
      
			if (type == "multiple")
			{
				tileWidth = Std.parseFloat(sprite.get("tw"));
				tileHeight = Std.parseFloat(sprite.get("th"));
        
				var totalWidth:Int = Math.floor(width / tileWidth);
				var totalHeight:Int = Math.floor(height / tileHeight);
				
				for (row in 0 ... totalHeight)
				{
					for (column in 0 ... totalWidth)
					{
						var idx = _tileSet.addRect(new Rectangle(x + (column * tileWidth), y + (row * tileHeight), tileWidth, tileHeight));
            data.push(idx);
					}
				}
			}
			else if (type == "single")
			{
        var idx = _tileSet.addRect(new Rectangle(x, y, width, height));
        data.push(idx);
			}
			else if (type == "font")
			{
				var font:TileTextFont = TileText.registerFont(tileName, this);
				var xml:Xml = Xml.parse(Assets.getText("font/" + tileName + ".xml"));
				for (element in xml.firstElement().elementsNamed("chars"))
				{
					for (char in element.elements())
					{
						var id:Int = Std.parseInt(char.get("id"));
						var charX:Float = Std.parseFloat(char.get("x"));
						var charY:Float = Std.parseFloat(char.get("y"));
						var charWidth:Float = Std.parseFloat(char.get("width"));
						var charHeight:Float = Std.parseFloat(char.get("height"));
						
						var rect:Rectangle = new Rectangle(x + charX, y + charY, charWidth, charHeight);
						var index:Int = _tileSet.addRect(rect);
						font.setChar(String.fromCharCode(id), charWidth, charHeight, index);
						data.push(index);
					}
				}
			}
			
      var imageInfo = new TileImageInfo(data, tileWidth, tileHeight);
			_tiles.set(tileName, imageInfo);
		}
  }
  
  public function getID(name:String):Int
  {
    return _tiles.get(name).data[0];
  }
  
  public function getIDs(name:String):Array<Int>
  {
    return _tiles.get(name).data;
  }
  
  public function getWidth(name:String):Float
  {
    return _tiles.get(name).width;
  }
  
  public function getHeight(name:String):Float
  {
    return _tiles.get(name).height;
  }
  
  var _tiles:StringMap<TileImageInfo>;
  var _tileSet:Tileset;
  
  public var tileMap(default, null):Tilemap;
}

class TileImageInfo
{
  public var data:Array<Int> = new Array<Int>();
  public var width:Float;
  public var height:Float;
  
  public function new(data:Array<Int>, width:Float, height:Float)
  {
    this.data = data;
    this.width = width;
    this.height = height;
  }
}