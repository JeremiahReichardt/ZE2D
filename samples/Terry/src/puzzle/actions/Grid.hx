package puzzle.actions;
import flash.geom.Point;
import ze.component.core.Component;
import ze.util.Input;
import ze.util.Key;

/**
 * ...
 * @author Goh Zi He
 */
class Grid extends Component
{
	private var _grid:Array<Array<Int>>;
	private var _tileSize:Int;
	
	public function new(width:Int, height:Int, tileSize:Int)
	{
		super();
		_grid = [];
		_tileSize = tileSize;
		width = Std.int(width / tileSize);
		height = Std.int(height / tileSize);
		
		for (h in 0 ... height)
		{
			_grid[h] = [];
			for (w in 0 ... width)
			{
				_grid[h][w] = 0;
			}
		}
	}
	
	public function setGrid(x:Int, y:Int):Void
	{
		_grid[y][x] = 1;
	}
	
	public function hasGridCollision(x:Float, y:Float):Bool
	{
		var gridX:Int = Std.int(getGridPoint(x));
		var gridY:Int = Std.int(getGridPoint(y));
		
		return _grid[gridY][gridX] == 1;
	}
	
	public function gridCollision(x:Float, y:Float):Point
	{
		var gridX:Int = Std.int(getGridPoint(x));
		var gridY:Int = Std.int(getGridPoint(y));
		var point:Point = new Point();
		
		if (_grid[gridY][gridX] == 1)
		{
			if (_grid[gridY + 1][gridX] == 0) // Hit top celing tile
			{
				point.y = 1;
			}
			else if (_grid[gridY][gridX - 1] == 0) // Hit right wall
			{
				point.x = -1;
			}
			else if (_grid[gridY][gridX + 1] == 0) // Hit left wall
			{
				point.x = 1;
			}
		}
		
		return point;
	}
	
	private function getGridPoint(point:Float):Float
	{
		var remainder:Float = point % _tileSize;
		point -= remainder;
		point /= _tileSize;
		return point;
	}
	
	public function getPoint(point:Float):Float
	{
		var remainder:Float = point % _tileSize;
		point -= remainder;
		return point;
	}
}