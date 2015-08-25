package ze.component.graphic.tilesheet;
import haxe.ds.StringMap;
import openfl.text.Font;
import ze.component.graphic.tilesheet.Text.Char;
import ze.util.TileSheetLayer;
/**
 * ...
 * @author Goh Zi He
 */
class Text extends TilesheetObject
{
	public var text(default, set):String;
	
	private var _font:Font;
	private var _charData:Array<Char>;
	
	private static var _fonts:StringMap<Font>;
	
	public function new(name:String)
	{
		super(name);
		_charData = [];
	}
	
	override function added():Void 
	{
		super.added();
		
		if (_fonts.exists(_name))
		{
			_font = _fonts.get(_name);
			_tileSheetLayer = _font.tileSheetLayer;
		}
		else
		{
			trace("Font doesn't exist");
		}
	}
	
	override public function draw():Void 
	{
		if (_tileSheetLayer == null)
		{
			return;
		}
		
		var x:Float = transform.x;
		var y:Float = transform.y;
		
		for (i in 0 ... text.length)
		{
			var index:Int = 0;
			
			if (text.charAt(i) == "\n")
			{
				y += (_charData[i - 1].height + 5);
				x = transform.x;
				continue;
			}
			_tileData[index++] = x;
			_tileData[index++] = y;
			_tileData[index++] = _charData[i].index;
			_tileData[index++] = 1;
			_tileData[index++] = 0;
			_tileData[index++] = 0;
			_tileData[index++] = 1;
			_tileSheetLayer.addToDraw(layer, _tileData);
			
			x += _charData[i].width;
		}
	}
	
	private function set_text(value:String):String
	{
		text = value;
		if (_font != null)
		{
			_charData = _font.getChar(value);
		}
		return text;
	}
	
	public static function registerFont(fontName:String, tileSheetLayer:TileSheetLayer):Font
	{
		if (_fonts == null)
		{
			_fonts = new StringMap<Font>();
		}
		
		var font:Font = new Font(tileSheetLayer);
		_fonts.set(fontName, font);
		return font;
	}
}

class Font
{
	private var _characters(default, null):StringMap<Char>;
	public var tileSheetLayer(default, null):TileSheetLayer;
	
	public function new(tileSheetLayer:TileSheetLayer)
	{
		this.tileSheetLayer = tileSheetLayer;
		_characters = new StringMap<Char>();
	}
	
	public function setChar(id:String, width:Float, height:Float, index:Int):Void
	{
		_characters.set(id, new Char(width, height, index));
	}
	
	public function getChar(text:String):Array<Char>
	{
		var chars:Array<Char> = [];
		for (i in 0 ... text.length)
		{
			chars.push(_characters.get(text.charAt(i)));
		}
		return chars;
	}
}

class Char
{
	public var width(default, null):Float;
	public var height(default, null):Float;
	public var index(default, null):Int;
	public static var carriageReturn:Char = new Char(0, 0, -1);
	
	public function new(width:Float, height:Float, index:Int)
	{
		this.width = width;
		this.height = height;
		this.index = index;
	}
}