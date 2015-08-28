package ze.component.graphic.displaylist;
import ze.component.graphic.displaylist.SplashImage.FadeEvent;
import ze.util.Time;

class SplashImage extends Image
{
	private static inline var defaultFadeSpeed:Float = 0.3;
	private var fadeSpeed:Float;
	private var fadeEvent:FadeEvent;
	
	public function new(imageName:String, imagePath:String = "") 
	{
		super(imageName, imagePath);
	}
	
	public function fade(speed:Float = defaultFadeSpeed, event:FadeEvent = null):FadeEvent
	{
		alpha = 0;
		fadeSpeed = speed;
		fadeEvent = event;
		if (fadeEvent == null)
		{
			fadeEvent = new FadeEvent(speed);
		}
		return fadeEvent.onComplete(fadeOut);
	}
	
	public function fadeIn(speed:Float = defaultFadeSpeed, event:FadeEvent = null):FadeEvent
	{
		alpha = 0;
		fadeSpeed = speed;
		fadeEvent = event;
		if (fadeEvent == null)
		{
			fadeEvent = new FadeEvent(speed, null);
		}
		return fadeEvent;
	}
	
	public function fadeOut(speed:Float = defaultFadeSpeed, event:FadeEvent = null):FadeEvent
	{
		alpha = 1;
		fadeSpeed = -speed;
		fadeEvent = event;
		if (fadeEvent == null)
		{
			fadeEvent = new FadeEvent(speed, null);
		}
		return fadeEvent;
	}
	
	override public function update():Void 
	{
		super.update();
		if (alpha >= 0 && alpha <= 1.0)
		{
			alpha += (fadeSpeed * Time.deltaTime);
		}
		else
		{
			fadeEvent.call();
		}
	}
}

class FadeEvent
{
	private var callBack:Float -> FadeEvent -> Void;
	private var next:FadeEvent;
	private var fadeSpeed:Float;
	
	public function new(speed:Float, nextEvent:FadeEvent = null)
	{
		next = nextEvent;
		fadeSpeed = speed;
	}
	
	public function onComplete(func:Float -> FadeEvent -> Void):FadeEvent
	{
		callBack = func;
		next = new FadeEvent(fadeSpeed);
		return next;
	}
	
	public function call()
	{
		if (callBack != null)
		{
			callBack(fadeSpeed, next);
		}
		callBack = null;
	}
}