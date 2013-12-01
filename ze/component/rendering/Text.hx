package ze.component.rendering;

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import openfl.Assets;
import ze.util.Color;

/**
 * ...
 * @author Goh Zi He
 */
class Text extends Render
{
	private var _textField:TextField;
	private var _format:TextFormat;
	
	private static inline var defaultFont:String = "assets/font/GROBOLD";
	
	public function new(text:String = "", color:Int = Color.BLACK, size:Float = 20)
	{
		super();
		_textField = new TextField();
		displayObject = _textField;
		
		_format = new TextFormat(defaultFont, size, color);
		
		_textField.text = text;
		_textField.embedFonts = true;
		_textField.setTextFormat(_format);
		_textField.autoSize = TextFieldAutoSize.CENTER;
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
}