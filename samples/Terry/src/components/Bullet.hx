package components;
import ze.component.core.Component;
import ze.component.physics.Collider;

/**
 * ...
 * @author Goh Zi He
 */
class Bullet extends Component
{
	private static inline var SPEED:Int = 5;
	
	private var _directionX:Int;
	private var _directionY:Int;
	private var _player:Player;
	
	public var bulletDirection(default, null):BulletDirection;
	public function new(direction:BulletDirection, player:Player)
	{
		super();
		setDirection(direction);
		_player = player;
	}
	
	private function setDirection(direction:BulletDirection):Void
	{
		_directionX = 0;
		_directionY = 0;
		
		switch (direction)
		{
			case BulletDirection.TOP:
				_directionY = -SPEED;
				bulletDirection = TOP;
				
			case BulletDirection.LEFT:
				_directionX = -SPEED;
				bulletDirection = LEFT;
				
			case BulletDirection.RIGHT:
				_directionX = SPEED;
				bulletDirection = RIGHT;
		}
	}
	
	override public function added():Void 
	{
		super.added();
		collider.registerCallback(hitBullet);
	}
	
	private function hitBullet(collider:Collider):Void
	{
		if (collider.gameObject.name == "collisionbox" || collider.gameObject.name.substr(0, 4) == "gate")
		{
			_player.disableBullet();
			scene.removeGameObject(gameObject);
		}
	}
	
	override public function update():Void 
	{
		super.update();
		transform.move(_directionX, _directionY);
	}
}

enum BulletDirection 
{
	TOP;
	LEFT;
	RIGHT;
}