package scenes;
import ze.object.Scene;
import ze.util.IMGUI;

/**
 * ...
 * @author Goh Zi He
 */
class MainScene extends Scene
{
	private var valInt:ValueInt;
	static var bgColor:Int;
	static var textStr:ValueStr;
	
	override public function added():Void
	{
		super.added();
		IMGUI.init(engine);
		valInt = new ValueInt(10);
		textStr = new ValueStr("Editable textfield");
	}
	
	override public function update():Void
	{
		super.update();
		
		IMGUI.begin();
		
		if (IMGUI.button(200, 100, 32, 32))
		{
			log("Clicked and released.");
		}
		
		if (IMGUI.button(248, 100, 32, 32, false))
		{
			log("Clicked and hold.");
		}
		
		valInt.value = bgColor & 0xff;
		if (IMGUI.slider(600, 40, 255, valInt))
		{
			bgColor = (bgColor & 0xffff00) | valInt.value;
		}
		
		valInt.value = ((bgColor >> 10) & 0x3f);
		if (IMGUI.slider(550, 40, 63, valInt))
		{
			bgColor = (bgColor & 0xff00ff) | (valInt.value << 10);
		}
		
		valInt.value = ((bgColor >> 20) & 0xf);
		if (IMGUI.slider(500, 40, 15, valInt))
		{
			bgColor = (bgColor & 0x00ffff) | (valInt.value << 20);
		}
		
		engine.graphics.beginFill(bgColor);
		engine.graphics.drawRect(500, 350, 130, 100);
		engine.graphics.endFill();
		
		IMGUI.textfield(50, 200, textStr);
		IMGUI.label(50, 240, "Label");
	}
}