package ze.component.graphic.displaylist;
import openfl.Assets;
import openfl.text.Font;
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
	private var _format:TextFormat;
	private var _textField:TextField;
	
	private static inline var defaultFont:String = "font/GROBOLD.ttf";
	
	public var length(default, null):Int;
	
	public function new(text:String = "", color:Int = Color.BLACK, size:Int = 20)
	{
		super();
		_textField = new TextField();
		displayObject = _textField;
		
		var font:Font = Assets.getFont(defaultFont);
		if (font == null)
		{
			trace("Remember to put " + defaultFont + " into assets/");
		}
		_format = new TextFormat(font.fontName, size, color);
		
		_textField.text = text;
		_textField.embedFonts = true;
		_textField.setTextFormat(_format);
		_textField.autoSize = TextFieldAutoSize.LEFT;
		
		length = _textField.length;
	}
	
	public function setFont(fontPath:String):Void
	{
		_format.font = Assets.getFont(fontPath).fontName;
	}
	
	public function setText(text:String):Void
	{
		_textField.text = text;
		_textField.setTextFormat(_format);
		length = _textField.length;
	}
	
	override public function destroyed():Void 
	{
		super.destroyed();
		_textField = null;
		_format = null;
	}
}