package ze.component.graphic.tilesheet;

/**
 * ...
 * @author Goh Zi He
 */
class TiledSprite extends TilesheetObject
{
	private var _indices:Array<Array<Int>>;
	private var _mapWidth:Float;
	private var _mapHeight:Float;
	private var _tileWidth:Float;
	private var _tileHeight:Float;
	private var _tileRow:Int;
	private var _tileColumn:Int;
	
	public function new(name:String, tileWidth:Float, tileHeight:Float, mapWidth:Float, mapHeight:Float, tileRow:Int, tileColumn:Int)
	{
		super(name);
		_indices = [[]];
		_tileWidth = tileWidth;
		_tileHeight = tileHeight;
		_mapWidth = mapWidth;
		_mapHeight = mapHeight;
		_tileRow = tileRow;
		_tileColumn = tileColumn;
		
		var row:Int = Math.floor(_mapHeight / _tileHeight);
		var column:Int = Math.floor(_mapWidth / _tileWidth);
		
		for (r in 0 ... row)
		{
			_indices[r] = [];
			for (c in 0 ... column)
			{
				_indices[r][c] = -1;
			}
		}
	}
	
	override function added():Void 
	{
		super.added();
	}
	
	public function setTile(column:Int, row:Int, tx:Float, ty:Float):Void
	{
		var tiles:Array<Int> = _tileSheetLayer.getSpriteIndices(_name);
		_indices[row][column] = tiles[Math.floor(tx + (ty * _tileRow))];
		_tileID = _indices[row][column];
	}
	
	override function update():Void 
	{
		if (!visible || _tileSheetLayer == null)
		{
			return;
		}
		
		var x:Float = transform.x;
		var y:Float = transform.y;
		
		for (row in 0 ... _indices.length)
		{
			for (column in 0 ... _indices[row].length)
			{
				if (_indices[row][column] == -1)
				{
					continue;
				}
				var index:Int = 0;
				_tileData[index++] = x + (column * _tileWidth);
				_tileData[index++] = y + (row * _tileHeight);
				_tileData[index++] = _indices[row][column];
				_tileData[index++] = 1;
				_tileData[index++] = 0;
				_tileData[index++] = 0;
				_tileData[index++] = 1;
				_tileSheetLayer.addToDraw(layer, _tileData);
			}
		}
	}
}