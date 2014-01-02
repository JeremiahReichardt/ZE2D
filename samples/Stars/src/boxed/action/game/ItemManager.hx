package boxed.action.game;

import boxed.action.item.PickStar;
import ze.component.core.Component;
import ze.component.physics.BoxCollider;
import ze.component.rendering.Image;
import ze.object.GameObject;
import ze.object.Node;
import ze.util.Random;

/**
 * ...
 * @author Goh Zi He
 */
class ItemManager extends Component
{
	override private function added():Void 
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
			x = Random.float(column, 0) * 32;
			y = Random.float(row, 0) * 32;
			
			if (getGameObjectAt(x, y))
			{
				var gameObject:GameObject = new GameObject("star", x, y);
				gameObject.addComponent(new BoxCollider(32, 32, true));
				gameObject.addComponent(new Image("star", "gfx/Star.png"));
				gameObject.addComponent(new PickStar());
				scene.addGameObject(gameObject);
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