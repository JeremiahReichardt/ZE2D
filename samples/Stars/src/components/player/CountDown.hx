package components.player;
import ze.component.core.Component;
import ze.util.Time;

/**
 * ...
 * @author Goh Zi He
 */
class CountDown extends Component
{
	public var duration:Int;
	public var percent(get, null):Float;
	public var onCompleted:Void -> Void;
	public var onEnd:Void -> Void;
	
	private var _lastTime:Int;
	
	public function startCountDown():Void
	{
		_lastTime = Time.currentTime;
	}
	
	public function stopCountDown():Void
	{
		enable = false;
		gameObject.removeComponent(this);
		onEnd();
	}
	
	override public function update():Void 
	{
		super.update();
		if (Time.currentTime - _lastTime > duration)
		{
			onCompleted();
			gameObject.removeComponent(this);
		}
	}
	
	private function get_percent():Float
	{
		return ((duration - (Time.currentTime - _lastTime)) / duration);
	}
	
	override public function removed():Void 
	{
		super.removed();
		
		onCompleted = null;
		onEnd = null;
	}
}