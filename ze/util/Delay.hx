package ze.util;
import openfl.Lib;

/**
 * ...
 * @author Goh Zi He
 */
class Delay
{
	private var _delay:Int;
	private var _lastTime:Int;
	
	public function new(delay:Int)
	{
		_delay = delay;
		_lastTime = Lib.getTimer() - delay;
	}
	
	public function now():Bool
	{
		if (Lib.getTimer() - _lastTime > _delay)
		{
			_lastTime = Lib.getTimer();
			return true;
		}
		return false;
	}
}