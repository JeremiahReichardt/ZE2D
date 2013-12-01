package ze.util;

/**
 * ...
 * @author Goh Zi He
 */
class Random
{
	public static function float(high:Float, low:Float):Float
	{
		return Math.ffloor(Math.random() * (1 + high - low) + low);
	}
	
	public static function int(high:Int, low:Int):Int
	{
		return Math.floor(Math.random() * (1 + high - low) + low);
	}
}