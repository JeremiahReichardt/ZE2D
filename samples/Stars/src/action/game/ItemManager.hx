package action.game;
import action.item.PickStar;
import scenes.GameScene;
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
		var x:Int = 0;
		var y:Int = 0;
		var row:Int = scene.screen.height - 32;
		var column:Int = scene.screen.width - 32;
		
		var gameObject:GameObject = new GameObject("star", x, y);
		scene.addGameObject(gameObject);
		gameObject.addComponent(new BoxCollider(32, 32, true));
		gameObject.addComponent(new PickStar());
		
		var gameScene:GameScene = cast(scene, GameScene);
		while (true)
		{
			x = Ops.randomInt(column);
			y = Ops.randomInt(row);
			
			gameObject.transform.setPos(x, y);
			gameObject.collider.setPos(x, y);
			
			if (!gameScene.getGridAt(x, y))
			{
				gameObject.addComponent(new Sprite("Star"));
				break;
			}
		}
	}
}