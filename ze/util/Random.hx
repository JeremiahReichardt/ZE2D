package ze.util;

/**
 * ...
 * @author Goh Zi He
 */
class Random
{
	public static inline function float(high:Float, low:Float = 0):Float
	{
		return Math.ffloor(Math.random() * (1 + high - low) + low);
	}
	
	public static inline function int(high:Int, low:Int = 0):Int
	{
		return Math.floor(Math.random() * (1 + high - low) + low);
	}
}