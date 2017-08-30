package ze.component.graphic.tilesheet;
import haxe.ds.StringMap;
import openfl.display.Tile;
import ze.util.TileSheetLayer;
/**
 * ...
 * @author Goh Zi He
 */
class TileText extends TileDisplayObject
{
	public var text(default, set):String;
	
	private var _font:TileTextFont;
	private var _charData:Array<TileTextChar>;
  
  var _tileSheetLayer:TileSheetLayer;
  
  private static var _fonts:StringMap<TileTextFont> = new StringMap<TileTextFont>();
	
	public function new(tileName:String, name:String)
	{
		super(tileName, name);
		_charData = [];
	}
  
  override public function added():Void 
  {
    super.added();
    _tileSheetLayer = scene.screen.getTileSheet(_tileName);
    _font = _fonts.get(_name);
  }
  
  override public function draw():Void 
  {
    //super.draw();
    _tileSheetLayer.tileMap.x = transform.x;
    _tileSheetLayer.tileMap.y = transform.y;
  }
	
	private function set_text(value:String):String
	{
		text = value;
		if (_font != null)
		{
			_charData = _font.getChar(value);
		}
    
    // Remove
    var tileMap = _tileSheetLayer.tileMap;
    tileMap.removeTiles(0, tileMap.numTiles);
    
    var i = 0;
    var offsetX = 0.0;
    var offsetY = 0.0;
    for (char in _charData)
    {
      var tile = new Tile(char.index, offsetX, offsetY, 1, 1, transform.rotation);
      _tileSheetLayer.tileMap.addTile(tile);
      
      offsetX += char.width;
      if (value.charAt(i) == '\n')
      {
        offsetY += char.height;
      }
      
      ++i;
    }
    
		return text;
	}
  
  public static function registerFont(fontName:String, tileSheetLayer:TileSheetLayer):TileTextFont
	{
		var font:TileTextFont = new TileTextFont(tileSheetLayer);
		_fonts.set(fontName, font);
		return font;
	}
  
  override private function set_visible(value:Bool):Bool
  {
    if (_tileSheetLayer != null)
      _tileSheetLayer.tileMap.alpha = value ? 1.0 : 0.0; 
    return super.set_visible(value);
  }
}

class TileTextFont
{
	private var _characters(default, null):StringMap<TileTextChar>;
	public var tileSheetLayer(default, null):TileSheetLayer;
	
	public function new(tileSheetLayer:TileSheetLayer)
	{
		this.tileSheetLayer = tileSheetLayer;
		_characters = new StringMap<TileTextChar>();
	}
	
	public function setChar(id:String, width:Float, height:Float, index:Int):Void
	{
		_characters.set(id, new TileTextChar(width, height, index));
	}
	
	public function getChar(text:String):Array<TileTextChar>
	{
		var chars:Array<TileTextChar> = [];
		for (i in 0 ... text.length)
		{
      var c = _characters.get(text.charAt(i));
			if (c != null)
        chars.push(c);
		}
		return chars;
	}
  
  var _tileName:String;
  var _tile:Tile;
  var _tileSheetLayer:TileSheetLayer;
}

private class TileTextChar
{
	public var width(default, null):Float;
	public var height(default, null):Float;
	public var index(default, null):Int;
	public static var carriageReturn:TileTextChar = new TileTextChar(0, 0, -1);
	
	public function new(width:Float, height:Float, index:Int)
	{
		this.width = width;
		this.height = height;
		this.index = index;
	}
}