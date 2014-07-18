package ze.component.graphic.displaylist;
import openfl.Assets;
import openfl.text.Font;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFieldType;
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
	
	private static inline var defaultFont:String = "font/GROBOLD.ttf";
	
	public function new(text:String = "", color:Int = Color.BLACK, size:Float = 20)
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
		_textField.autoSize = TextFieldAutoSize.CENTER;
		_textField.selectable = true;
		_textField.type = TextFieldType.INPUT;
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
	
	override public function destroyed():Void 
	{
		super.destroyed();
		_textField = null;
		_format = null;
	}
}