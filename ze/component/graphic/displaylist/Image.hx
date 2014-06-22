package ze.component.graphic.displaylist;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Goh Zi He
 */

class Image extends BitmapObject
{
	private static var _imageCache:Map<String, BitmapData> = new Map<String, BitmapData>();
	
	public function new(label:String, imagePath:String = "",  imageData:BitmapData = null, rectangle:Rectangle = null) 
	{
		super();
		var cacheData:BitmapData = _imageCache.get(label);
		if (cacheData == null)
		{
			cacheData = createImage(label, imagePath, imageData, rectangle);
		}
		
		setBitmapData(cacheData);
	}
	
	private static function createImage(label:String, imagePath:String = "", imageData:BitmapData = null, rectangle:Rectangle = null):BitmapData
	{
		if (!_imageCache.exists(label))
		{
			if (imageData == null) 
			{
				imageData = Assets.getBitmapData(imagePath);
			}
			
			if (rectangle != null)
			{
				var destPoint:Point = new Point(0, 0);
				var croppedImage:BitmapData = new BitmapData(Math.floor(rectangle.width), Math.floor(rectangle.height));
				croppedImage.copyPixels(imageData, rectangle, destPoint);
				imageData = croppedImage;
			}
			
			_imageCache.set(label, imageData);
		}
		
		return imageData;
	}
	
	public function setImage(name:String):Void
	{
		var cacheData:BitmapData = _imageCache.get(name);
		if (cacheData == null)
		{
			trace("No image of name: " + name + " is found");
			return;
		}
		
		setBitmapData(cacheData);
	}
}