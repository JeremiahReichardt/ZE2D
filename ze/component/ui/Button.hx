package ze.component.ui;
import ze.component.graphic.tilesheet.TileAnimation;
import ze.util.Input;

/**
 * ...
 * @author Goh Zi He
 */
class Button extends UI
{
	private var _atlas:String;
	private var _name:String;
	private var _enterCallback:Void -> Void;
	private var _exitCallback:Void -> Void;
	private var _overCallback:Void -> Void;
	private var _clickCallback:Void -> Void;
	private var _animatedSprite:TileAnimation;
	
	public function new(atlas:String, name:String, width:Float, height:Float = null)
	{
		super(width, height);
		_atlas = atlas;
    _name = name;
	}
	
	override public function added():Void 
	{
		super.added();
		_animatedSprite = new TileAnimation(_atlas, _name);
		addComponent(_animatedSprite);
	}
	
	public function addButtonState(state:ButtonState, frames:Array<Int>):Void
	{
		switch(state)
		{
			case ENTER:
				_animatedSprite.addAnimation("enter", frames);
			
			case OVER:
				_animatedSprite.addAnimation("over", frames);
			
			case CLICK:
				_animatedSprite.addAnimation("click", frames);
			
			case EXIT:
				_animatedSprite.addAnimation("exit", frames);
				_animatedSprite.play("exit");
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
		_animatedSprite.play("enter");
	}
	
	override private function onExit():Void 
	{
		super.onExit();
		if (_exitCallback != null)
		{
			_exitCallback();
		}
		_animatedSprite.play("exit");
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

enum ButtonState 
{
	ENTER;
	EXIT;
	OVER;
	CLICK;
}