package components;
import openfl.geom.Point;
import ze.component.core.Component;

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
	
	/**
	 * Checks the cell on the grid, if the cell is 1, it is occupied.
	 * @param	x	The x index of the cell
	 * @param	y	The y index of the cell
	 * @return	True if the cell is occupied, equals to 1
	 */
	public function hasGridCollision(x:Int, y:Int):Bool
	{
		x = pointToGrid(x);
		y = pointToGrid(y);
		
		return _grid[y][x] == 1;
	}
	
	public function gridCollision(x:Int, y:Int):Point
	{
		var gridX:Int = pointToGrid(x);
		var gridY:Int = pointToGrid(y);
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
	
	/**
	 * Converts real point coordinate to grid cell coordinate
	 * @param	point
	 * @return
	 */
	private inline function pointToGrid(point:Int):Int
	{
		return Std.int(snapPoints(point) / _tileSize);
	}
	
	/**
	 * Snaps the point to the wall of the cells of the grid.
	 * @param	point
	 * @return
	 */
	public inline function snapPoints(point:Int):Int
	{
		var remainder:Int = point % _tileSize;
		return (point - remainder);
	}
}