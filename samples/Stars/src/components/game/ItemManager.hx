package components.game;
import components.Grid;
import components.item.PickStar;
import scenes.GameScene;
import ze.component.core.Component;
import ze.component.graphic.tilesheet.TileImage;
import ze.component.physics.BoxCollider;
import ze.object.GameObject;
import ze.util.MathUtil;

/**
 * ...
 * @author Goh Zi He
 */
class ItemManager extends Component
{
	override public function added():Void 
	{
		super.added();
		spawnStar();
	}
	
	public function spawnStar():Void
	{
		var x:Int = 0;
		var y:Int = 0;
		var row:Int = scene.screen.height - 32;
		var column:Int = scene.screen.width - 32;
		
		var gameObject:GameObject = new GameObject("star", x, y);
		scene.addGameObject(gameObject);
		gameObject.addComponent(new BoxCollider(32, 32, true));
		gameObject.addComponent(new PickStar());
		
		var grid:Grid = cast(scene, GameScene).grid;
		while (true)
		{
			x = MathUtil.randomInt(column);
			y = MathUtil.randomInt(row);
			
			if (!grid.hasGridCollision(x, y))
			{
				gameObject.transform.setPos(grid.snapPoints(x), grid.snapPoints(y));
				gameObject.addComponent(new TileImage("sprites", "Star"));
				break;
			}
		}
	}
}