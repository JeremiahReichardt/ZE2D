package ze.component.graphic.tilesheet;
import openfl.display.Tile;
import ze.util.TileSheetLayer;

/**
 * ...
 * @author Goh Zi He
 */
class TileTiledMap extends Graphic
{
  var _tileName:String;
  var _tileSheetLayer:TileSheetLayer;
  var _numSpritesPerRow:Int;
	
	public function new(tileName:String, numSpritesPerRow:Int)
	{
		super();
    _tileName = tileName;
    _numSpritesPerRow = numSpritesPerRow;
	}
  
  override public function added():Void 
  {
    super.added();
    _tileSheetLayer = scene.screen.getTileSheet(_tileName);
  } 
	
	public function setTile(x:Int, y:Int, tx:Int, ty:Int):Void
	{
    var id = ty * _numSpritesPerRow + tx;
    var tile = new Tile(id, x, y, 1, 1, transform.rotation);
    _tileSheetLayer.tileMap.addTile(tile);
	}
  
  override public function removed()
  {
    super.removed();
    
    var tileSheetLayer = scene.screen.getTileSheet(_tileName);
    if (tileSheetLayer != null)
      tileSheetLayer.tileMap.removeTiles(0, tileSheetLayer.tileMap.numTiles);
  }
}