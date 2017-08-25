package ze.component.graphic.tilesheet;
import openfl.display.Tile;
import ze.component.graphic.Graphic;

/**
 * ...
 * @author Goh Zi He
 */
class TileImage extends Graphic
{
  public function new(tileName:String, name:String) 
  {
    super();
    _tileName = tileName;
    _name = name;
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
      
      width = tileSheetLayer.getWidth(id);
      height = tileSheetLayer.getHeight(id);
    }
    
    
  }
  
  override public function draw():Void 
  {
    super.draw();
    
    _tile.x = transform.x;
    _tile.y = transform.y;
    _tile.rotation = transform.rotation;
  }
  
  var _tileName:String;
  var _name:String;
  var _tile:Tile;
}