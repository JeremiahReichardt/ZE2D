package ze.util;

import flash.Lib;

/**
 * ...
 * @author Goh Zi He
 */

class Time 
{
	public static var deltaTime(default, null):Float;
	public static var currentTime(default, null):Int;
	
	private static var _lastTime:Int;
	
	public static function update():Void
	{
		currentTime = Lib.getTimer();
		deltaTime = (currentTime - _lastTime) * 0.001;
		_lastTime = currentTime;
	}
	
	/**
	 * Input a duration of seconds and convert to millisecond
	 * @param	duration	in seconds
	 * @return
	 */
	public static inline function seconds(duration:Float):Float
	{
		return duration * 1000;
	}
	
	/**
	 * Input a duration of minutes and convert to millisecond
	 * @param	duration	in minutes
	 * @return
	 */
	public static inline function minutes(duration:Float):Float
	{
		return (seconds(duration * 60));
	}
}