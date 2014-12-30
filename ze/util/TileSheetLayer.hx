package ze.util;
import haxe.ds.StringMap;
import openfl.Assets;
import openfl.display.Graphics;
import openfl.display.Tilesheet;
import openfl.geom.Rectangle;
import ze.component.graphic.tilesheet.Text;

/**
 * ...
 * @author Goh Zi He
 */
class TileSheetLayer extends Tilesheet
{
	public var graphics(default, default):Graphics;
	
	private var _layer:Array<Array<Float>>;
	private var _sprites:StringMap<Array<Int>>;
	
	public function new(name:String)
	{
		super(Assets.getBitmapData(name + ".png"));
		_sprites = new StringMap<Array<Int>>();
		loadXML(name + ".xml");
		_layer = [[]];
	}
	
	private function loadXML(name:String):Void
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
			
			var data:Array<Int> = [];
			
			if (type == "multiple")
			{
				var tileWidth:Float = Std.parseFloat(sprite.get("tw"));
				var tileHeight:Float = Std.parseFloat(sprite.get("th"));
				var totalWidth:Int = Math.floor(width / tileWidth);
				var totalHeight:Int = Math.floor(height / tileHeight);
				
				var column:Int = 0;
				var row:Int = 0;
				
				for (row in 0 ... totalHeight)
				{
					for (column in 0 ... totalWidth)
					{
						var rect:Rectangle = new Rectangle(x + (column * tileWidth), y + (row * tileHeight), tileWidth, tileHeight);
						data.push(addTileRect(rect));
					}
				}
			}
			else if (type == "single")
			{
				var rect:Rectangle = new Rectangle(x, y, width, height);
				data.push(addTileRect(rect));
			}
			else if (type == "font")
			{
				var font:Font = Text.registerFont(tileName, this);
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
						var index:Int = addTileRect(rect);
						font.setChar(String.fromCharCode(id), charWidth, charHeight, index);
						data.push(index);
					}
				}
			}
			
			_sprites.set(tileName, data);
		}
	}
	
	public function spriteExist(name:String):Bool
	{
		return _sprites.exists(name);
	}
	
	public function getSprite(name:String):Int
	{
		if (_sprites.exists(name))
		{
			return _sprites.get(name)[0];
		}
		return 0;
	}
	
	public function getSpriteIndices(name:String):Array<Int>
	{
		if (_sprites.exists(name))
		{
			return _sprites.get(name);
		}
		return null;
	}
	
	public function addToDraw(layer:Int, data:Array<Float>):Int
	{
		if (layer > _layer.length + 1)
		{
			layer = _layer.length + 1;
		}
		
		if (_layer[layer] == null)
		{
			_layer[layer] = [];
		}
		
		_layer[layer] = _layer[layer].concat(data);
		return layer;
	}
	
	public function draw():Void
	{
		for (i in 0 ... _layer.length)
		{
			if (_layer[i] == null)
			{
				continue;
			}
			var drawFlag = 0;
			drawFlag |= Tilesheet.TILE_TRANS_2x2;
			
			drawTiles(graphics, _layer[i], false, drawFlag);
			_layer[i] = [];
		}
	}
}