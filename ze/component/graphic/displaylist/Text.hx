package ze.component.graphic.displaylist;
import openfl.Assets;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import ze.util.Color;

/**
 * ...
 * @author Goh Zi He
 */
class Text extends DisplayListObject
{
	private var _textField:TextField;
	private var _format:TextFormat;
	
	private static inline var defaultFont:String = "assets/font/GROBOLD";
	
	public function new(text:String = "", color:Int = Color.BLACK, size:Float = 20)
	{
		super();
		
		_textField = new TextField();
		displayObject = _textField;
		
		if (Assets.getFont("font/GROBOLD.ttf") == null)
		{
			trace("Remember to put GROBOLD.ttf into assets/font/");
		}
		_format = new TextFormat(defaultFont, size, color);
		
		_textField.text = text;
		_textField.embedFonts = true;
		_textField.setTextFormat(_format);
		_textField.autoSize = TextFieldAutoSize.CENTER;
		_textField.selectable = false;
		_textField.cacheAsBitmap = true;
	}
	
	public function setFont(fontPath:String):Void
	{
		_format.font = Assets.getFont(fontPath).fontName;
	}
	
	public function setText(text:String):Void
	{
		_textField.text = text;
		_textField.setTextFormat(_format);
	}
	
	override private function destroyed():Void 
	{
		super.destroyed();
		
		_textField = null;
		_format = null;
	}
}