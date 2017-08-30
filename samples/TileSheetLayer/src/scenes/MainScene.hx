package scenes;
import ze.component.graphic.tilesheet.TileImage;
import ze.component.graphic.tilesheet.TileText;
import ze.object.GameObject;
import ze.object.Scene;
import ze.util.TileSheetLayer;

/**
 * ...
 * @author Goh Zi He
 */
class MainScene extends Scene
{
	private static inline var startX:Float = 90;
	private static inline var spacingX:Float = 32;
	
	override public function added():Void
	{
		super.added();
    
    // Bottom layer
    screen.createTileSheet("TS1", "atlas/TS1");
    // Middle layer
    screen.createTileSheet("TS2", "atlas/TS2");
    // Top layer
    screen.createTileSheet("Font", "atlas/Font");
		
		createTiles("TS1", 1, 0.0,      40.0);
		createTiles("TS2", 2, spacingX, 56.0);
		createFont();
	}
	
	private function createTiles(tileName:String, layer:Int, startX:Float, startY:Float):Void
	{
		var x:Float = startX;
		var y:Float = startY;
    
    for (i in 1 ... 6)
    {
      var name:String = layer + "x" + i;
      var go:GameObject = createGameObject(name, new TileImage(tileName, name));
      go.graphic.layer = i + 1;
      
      go.transform.x = x;
      go.transform.y = y;
      x += 16;
    }
	}
	
	private function createFont():Void
	{
		var text = new TileText("Font", "Grobold");
		createGameObject("Text", text);
		text.text = "TileSheetLayer demo ";
	}
}