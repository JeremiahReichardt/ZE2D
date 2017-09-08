package ze.component.graphic.tilesheet;
import openfl.display.Tile;
import ze.component.graphic.Graphic;

/**
 * ...
 * @author Goh Zi He
 */
class TileDisplayObject extends Graphic
{
  public function new(tileName:String, name:String) 
  {
    super();
    _tileName = tileName;
    _name = name;
  }
  
  override public function draw():Void 
  {
    super.draw();
    
    _tile.x = transform.x;
    _tile.y = transform.y;
    _tile.rotation = transform.rotation;
  }
  
  override public function removed()
  {
    super.removed();
    
    var tileSheetLayer = scene.screen.getTileSheet(_tileName);
    if (tileSheetLayer != null)
      _tile = tileSheetLayer.tileMap.removeTile(_tile);
    
    _tile = null;
  }
  
  override private function set_visible(value:Bool):Bool
  {
    if (_tile != null)
      _tile.alpha = value ? 1.0 : 0.0; 
    return super.set_visible(value);
  }
  
	override function get_scaleX():Float 
	{
		return _tile.scaleX;
	}
	
	override function set_scaleX(value:Float):Float 
	{
		_tile.scaleX = value;
		return value;
	}
	
	override function get_scaleY():Float 
	{
		return _tile.scaleY;
	}
	
	override function set_scaleY(value:Float):Float 
	{
		_tile.scaleY = value;
		return value;
	}
  
  var _tileName:String;
  var _name:String;
  var _tile:Tile;
}