package ze.component.physics;

/**
 * ...
 * @author Goh Zi He
 */
class GridCollider extends Collider
{
	public static inline var NO_COLLISION_LAYER:Int = 0;
	public static inline var COLLISION_LAYER:Int = 1;
	
	private var _row:Int;
	private var _column:Int;
	private var _grid:Array<Int>;
	
	public function new(row:Int, column:Int, width:Float, height:Float, trigger:Bool = false)
	{
		super(trigger);
		this.width = width;
		this.height = height;
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
		var rx:Int = Std.int(cx % width);
		var ry:Int = Std.int(cy % height);
		var row:Int = Std.int((cy - ry) / height);
		var column:Int = Std.int((cx - rx) / width);
		
		return _grid[row * _column + column];
	}
}