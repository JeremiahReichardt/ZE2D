package ze.util;

/**
 * @author Goh Zi He
 */
class Color
{
	/**
	 * See if r/g/b component is more than 255 or less than 0
	 * @param	colorComponent R/G/B component
	 * @return
	 */
	private static inline function checkWithinRange(colorComponent:Int):Int
	{
		if (colorComponent < 0)
		{
			return 0;
		}
		else if (colorComponent > 255)
		{
			return 255;
		}
		else
		{
			return colorComponent;
		}
	}
	
	public static inline function toHex(red:Int, green:Int, blue:Int):String
	{
		red = checkWithinRange(red);
		green = checkWithinRange(green);
		blue = checkWithinRange(blue);
		
		var hexString:String = "";
		hexString += convert(red);
		hexString += convert(green);
		hexString += convert(blue);
		hexString = "0x" + hexString;
		
		return hexString;
		//return red << 16 ^ green << 8 ^ blue;	
	}
	
	private static inline function getHex(decimal:Int):String
	{
		switch(decimal)
		{
			case 10:
				return "A";
				
			case 11:
				return "B";
				
			case 12:
				return "C";
				
			case 13:
				return "D";
				
			case 14:
				return "E";
				
			case 15:
				return "F";
				
			default:
				return Std.string(decimal);
		}
	}
	
	private static inline function convert(color:Int):String
	{
		var colorString:String = "";
		var remainder:Int = color % 16;
		if (remainder > 1)
		{
			var divide:Int = Math.floor(color / 16);
			colorString += getHex(divide);
			colorString += getHex(remainder);
		}
		else
		{
			colorString += "0";
			colorString += getHex(color);
		}
		return colorString;
	}
	
	public static inline function getRed(hex:Int):Int
	{
		return hex >> 16;
	}
	
	public static inline function getGreen(hex:Int):Int
	{
		return  ((hex ^ hex >> 16 << 16) >> 8);
	}
	
	public static inline function getBlue(hex:Int):Int
	{
		return (hex >> 8 << 8 ^ hex);
	}
	
	/**
	 * Static const colors (Feel free to define more)
	 */
	public static inline var RED:Int = 0xFFFF0000;
	public static inline var LIMEGREEN:Int = 0xFFAEF02A;
	public static inline var GREEN:Int = 0xFF00FF00;
	public static inline var BLUE:Int = 0xFF0000FF;
	public static inline var BLACK:Int = 0xFF000000;
	public static inline var WHITE:Int = 0xFFFFFFFF;
	public static inline var YELLOW:Int = 0xFFFFFF00;
	public static inline var CYAN:Int = 0xFF00FFFF;
	public static inline var PINK:Int = 0xFFFF9191;
	public static inline var GREY:Int = 0xFF646464;
	public static inline var LIGHTGREY:Int = 0xFF969696;
	public static inline var BROWN:Int = 0xFF8B4513;
	public static inline var LIGHTRED:Int = 0xFFFF9696;
	public static inline var BEIGE:Int = 0xFFE6D59E;
	public static inline var CARAMEL:Int = 0xFFFFEF21;
}