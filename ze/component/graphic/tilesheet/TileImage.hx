package ze.component.graphic.tilesheet;
import openfl.display.Tile;

/**
 * ...
 * @author Goh Zi He
 */
class TileImage extends TileDisplayObject
{
  public function new(tileName:String, name:String) 
  {
    super(tileName, name);
  }
  
  override public function added():Void 
  {
    super.added();
    
    var tileSheetLayer = scene.screen.getTileSheet(_tileName);
    if (tileSheetLayer != null)
    {
      var id = tileSheetLayer.getID(_name);
      _tile = new Tile(id, transform.x, transform.y, 1, 1, transform.rotation);
      tileSheetLayer.tileMap.addTile(_tile);
      
      width = tileSheetLayer.getWidth(_name);
      height = tileSheetLayer.getHeight(_name);
    }
  }
}

