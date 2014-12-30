package ze.util;

/**
 * ...
 * @author Goh Zi He
 */
class Vec2
{
	public var x(default, default):Float;
	public var y(default, default):Float;
	
	public function new(x:Float = 0, y:Float = 0) 
	{
		setXY(x, y);
	}
	
	public function setXY(x:Float = 0, y:Float = 0):Vec2
	{
		this.x = x;
		this.y = y;
		return this;
	}
	
	public function normalize():Vec2
	{
		var dist:Float = distance();
		x /= dist;
		y /= dist;
		return this;
	}
	
	public function distance():Float
	{
		return Math.sqrt((x * x) + (y * y));
	}
	
	public function dot(vec:Vec2):Float
	{
		return (vec.x * x) + (vec.y * y);
	}
	
	public function scale(factor:Float):Vec2
	{
		x *= factor;
		y *= factor;
		return this;
	}
}