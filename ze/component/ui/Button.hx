package ze.component.ui;

import flash.geom.Rectangle;
import ze.component.rendering.Image;
import ze.util.Input;

/**
 * ...
 * @author Goh Zi He
 */
class Button extends UI
{
	private var _enterCallback:Void -> Void;
	private var _exitCallback:Void -> Void;
	private var _overCallback:Void -> Void;
	private var _clickCallback:Void -> Void;
	
	public function new(name:String, buttonGfx:String, width:Float, height:Float, exitGfxPos:Array<Int> = null, overGfxPos:Array<Int> = null, clickGfxPos:Array<Int> = null)
	{
		super(width, height);
		_name = name;
		
		init(name + "_exitGfx", buttonGfx, width, height, exitGfxPos);
		init(name + "_overGfx", buttonGfx, width, height, overGfxPos);
		init(name + "_clickGfx", buttonGfx, width, height, clickGfxPos);
	}
	
	override private function added():Void 
	{
		super.added();
		addComponent(new Image(_name + "_exitGfx"));
	}
	
	private function init(name:String, buttonGfx:String, width:Float, height:Float, btnPos:Array<Int>):Void
	{
		if (btnPos != null)
		{
			var rect:Rectangle = new Rectangle(width * btnPos[0], height * btnPos[1], width, height);
			new Image(name, buttonGfx, rect);
		}
	}
	
	public function registerCallback(enterCallBack:Void -> Void = null, exitCallBack:Void -> Void = null, overCallBack:Void -> Void = null, clickCallBack:Void -> Void = null):Void
	{
		_enterCallback = enterCallBack;
		_exitCallback = exitCallBack;
		_overCallback = overCallBack;
		_clickCallback = clickCallBack;
	}
	
	override private function onEnter():Void 
	{
		super.onEnter();
		if (_enterCallback != null)
		{
			_enterCallback();
		}
		cast(draw, Image).setImage(_name + "_overGfx");
	}
	
	override private function onExit():Void 
	{
		super.onExit();
		if (_exitCallback != null)
		{
			_exitCallback();
		}
		cast(draw, Image).setImage(_name + "_exitGfx");
	}
	
	override private function onOver():Void 
	{
		super.onOver();
		if (_overCallback != null)
		{
			_overCallback();
		}
		
		if (Input.leftMousePressed())
		{
			onClick();
		}
	}
	
	private function onClick():Void
	{
		if (_clickCallback != null)
		{
			_clickCallback();
		}
	}
}