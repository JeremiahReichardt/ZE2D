package scenes;
import ze.component.graphic.tilesheet.TilesheetSprite;
import ze.component.graphic.tilesheet.TilesheetText;
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
		var tileSheetLayer1:TileSheetLayer = new TileSheetLayer("atlas/TS1");
		var tileSheetLayer2:TileSheetLayer = new TileSheetLayer("atlas/TS2");
		var fontLayer:TileSheetLayer = new TileSheetLayer("atlas/Font");
		
		// Bottom layer
		screen.addLayer(tileSheetLayer1);
		// Middle layer
		screen.addLayer(tileSheetLayer2);
		// Top layer
		screen.addLayer(fontLayer);
		
		createTiles();
		createFont();
	}
	
	private function createTiles():Void
	{
		var x:Float = startX;
		var y:Float = 40;
		
		for (layer in 1 ... 3)
		{
			for (i in 1 ... 6)
			{
				var name:String = layer + "x" + i;
				var go:GameObject = createGameObject(name, new TilesheetSprite(name));
				go.graphic.layer = i + 1;
				
				go.transform.x = x;
				go.transform.y = y;
				x += 16;
			}
			x = startX + spacingX;
			y += 16;
		}
	}
	
	private function createFont():Void
	{
		var text:TilesheetText = new TilesheetText("Grobold");
		var goText:GameObject = createGameObject("Text", text);
		text.text = "TileSheetLayer demo ";
	}
}