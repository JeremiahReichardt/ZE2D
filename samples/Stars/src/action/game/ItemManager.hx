package action.game;
import action.item.PickStar;
import ze.component.core.Component;
import ze.component.graphic.tilesheet.Sprite;
import ze.component.physics.BoxCollider;
import ze.object.GameObject;
import ze.object.Node;
import ze.util.Ops;

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
		var x, y:Float;
		var row:Int = Math.floor(704 / 32);
		var column:Int = Math.floor(1280 / 32);
		
		--row;
		--column;
		while (true)
		{
			x = Ops.randomFloat(column, 0) * 32;
			y = Ops.randomFloat(row, 0) * 32;
			
			if (getGameObjectAt(x, y))
			{
				var gameObject:GameObject = new GameObject("star", x, y);
				scene.addGameObject(gameObject);
				gameObject.addComponent(new BoxCollider(32, 32, true));
				gameObject.addComponent(new Sprite("Star"));
				gameObject.addComponent(new PickStar());
				break;
			}
		}
	}
	
	private function getGameObjectAt(x:Float, y:Float):Bool 
	{
		var node:Node = scene._child;
		while (node != null)
		{
			var go:GameObject = cast(node, GameObject);
			if (x == go.transform.x && y == go.transform.y)
			{
				return false;
			}
			node = node._next;
		}
		return true;
	}
}