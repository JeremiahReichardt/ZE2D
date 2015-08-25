package ze.util;

/**
 * ...
 * @author Goh Zi He
 */
class MathUtil
{
	public static inline function distance(x1:Float, x2:Float, y1:Float, y2:Float):Float
	{
		var y:Float = y2 - y1;
		var x:Float = x2 - x1;
		
		y *= y;
		x *= x;
		return (Math.sqrt(y + x));
	}
	
	public static inline function randomFloat(high:Float, low:Float = 0):Float
	{
		return Math.ffloor(Math.random() * (1 + high - low) + low);
	}
	
	public static inline function randomInt(high:Int, low:Int = 0):Int
	{
		return Math.floor(Math.random() * (1 + high - low) + low);
	}
}