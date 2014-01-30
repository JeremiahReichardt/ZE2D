package ze.component.physics;

/**
 * ...
 * @author Goh Zi He
 */
class GridCollider extends Collider
{
	private var _grid:Array<Int>;
	private var _tileWidth:Float;
	private var _tileHeight:Float;
	private var _row:Int;
	private var _column:Int;
	
	public static inline var NO_COLLISION_LAYER:Int = 0;
	public static inline var COLLISION_LAYER:Int = 1;
	
	public function new(row:Int, column:Int, width:Float, height:Float, trigger:Bool = false)
	{
		super(trigger);
		
		_tileWidth = width;
		_tileHeight = height;
		_row = row;
		_column = column;
		_grid = [];
		
		for (r in 0 ... _row)
		{
			for (c in 0 ... _column)
			{
				_grid[r * _column + c] = NO_COLLISION_LAYER;
			}
		}
		
		createWall();
	}
	
	private function createWall():Void
	{
		var maxRow:Int = _row - 2;
		var maxColumn:Int = _column - 2;
		
		for (r in 0 ... _row)
		{
			for (c in 0 ... _column)
			{
				if (r == 0 || c == 0 || r == maxRow || c == maxColumn)
				{
					_grid[r * _column + c] = COLLISION_LAYER;
					continue;
				}
			}
		}
	}
	
	public function getGridAt(x:Float, y:Float):Int
	{
		var cx:Float = x - collider.x;
		var cy:Float = y - collider.y;
		var rx:Int = Std.int(cx % _tileWidth);
		var ry:Int = Std.int(cy % _tileHeight);
		var row:Int = Std.int((cy - ry) / _tileHeight);
		var column:Int = Std.int((cx - rx) / _tileWidth);
		
		return _grid[row * _column + column];
	}
}