package puzzle.actions;

import flash.display.BitmapData;
import ze.component.core.CharacterController;
import ze.component.core.Component;
import ze.component.physics.BoxCollider;
import ze.component.rendering.Image;
import ze.component.sounds.Audio;
import ze.object.GameObject;
import ze.util.Input;
import ze.util.Key;
import ze.util.Time;

/**
 * ...
 * @author Goh Zi He
 */
class Player extends Component
{
	public var respawnPoint:Respawn;
	
	private static inline var GRAVITY:Float = 20;
	private static inline var WALKING_SPEED:Float = 100;
	private static inline var MAX_SPEED:Float = 500;
	
	private static var bullet:GameObject;
	private static var flippedRender:Bool;
	private var _characterController:CharacterController;
	private var _grid:Grid;
	
	private var _moveX:Float;
	private var _moveY:Float;
	private var _startX:Float;
	private var _startY:Float;
	
	private var _shootSfx:Audio;
	private var _teleportSfx:Audio;
	private var _dieSfx:Audio;

	
	override private function added():Void 
	{
		super.added();
		_moveX = 0;
		_moveY = 0;
		_startX = transform.x;
		_startY = transform.y;
		_characterController = getComponent(CharacterController);
		_grid = getGameObjectByName("grid").getComponent(Grid);
		
		draw.flipped = flippedRender;
		
		_shootSfx = new Audio("Shoot", "sfx/Laser_Shoot3.wav");
		_teleportSfx = new Audio("Teleported", "sfx/Pickup_Coin.wav");
		_dieSfx = new Audio("Die", "sfx/Hit_Hurt5.wav");
	}
	
	override private function update():Void 
	{
		super.update();
		movement();
		
		var direction:Bullet.BulletDirection;
		if (Input.keyDown(Key.W) || Input.keyDown(Key.UP))
		{
			direction = Bullet.BulletDirection.TOP;
		}
		else
		{
			if (draw.flipped)
			{
				direction = Bullet.BulletDirection.LEFT;
			}
			else
			{
				direction = Bullet.BulletDirection.RIGHT;
			}
		}
		
		if (Input.keyPressed(Key.Z) || Input.keyPressed(Key.SPACEBAR))
		{
			shoot(direction);
		}
		else if (Input.keyPressed(Key.C))
		{
			if (bullet != null)
			{
				scene.removeGameObject(bullet);
				disableBullet();
			}
		}
	}
	
	private function movement():Void
	{
		if (_characterController.isGrounded) 
		{
			_moveY = 0;
		}
		
		if (_characterController.hitTop)
		{
			_moveY = 0;
		}
		
		_moveX = 0;
		if (Input.keyDown(Key.A) || Input.keyDown(Key.LEFT))
		{
			_moveX = -1;
			draw.flipped = true;
		}
		else if (Input.keyDown(Key.D) || Input.keyDown(Key.RIGHT))
		{
			_moveX = 1;
			draw.flipped = false;
		}
		
		_moveX *= WALKING_SPEED;
		_moveY += GRAVITY;
		
		if (_moveY > MAX_SPEED)
		{
			_moveY = MAX_SPEED;
		}
		
		transform.moveBy(_moveX * Time.deltaTime, _moveY * Time.deltaTime);
	}
	
	private function shoot(direction:Bullet.BulletDirection):Void
	{
		if (bullet == null)
		{
			var x:Float = transform.x + (draw.width * 0.5) - 2.5;
			var y:Float = transform.y;
			
			bullet = new GameObject("bullet", x, y);
			scene.addGameObject(bullet);
			bullet.addComponent(new BoxCollider(5, 5, true));
			bullet.addComponent(new Bullet(direction, this));
			bullet.addComponent(new Image("bullet", new BitmapData(5, 5)));
			
			_shootSfx.play();
		}
		else
		{
			var x:Float = bullet.transform.x - (draw.width * 0.5) + 2.5;
			var y:Float = bullet.transform.y;
			
			if (!_grid.hasGridCollision(x, y))
			{
				// So that player won't be teleported to the next grid
				if (x - _grid.getPoint(x) > 16)
				{
					x = 16 + _grid.getPoint(x);
				}
				
				if (y - _grid.getPoint(y) > 16)
				{
					y = 16 + _grid.getPoint(y);
				}
				
				transform.x = x;
				transform.y = y;
				scene.removeGameObject(bullet);
				
				if (bullet.getComponent(Bullet).bulletDirection == Bullet.BulletDirection.TOP)
				{
					_moveY = -100;
				}
				else
				{
					_moveY = 0;
				}
				_teleportSfx.play();
				disableBullet();
			}
			else
			{
				removeComponent(bullet);
				disableBullet();
			}
		}
	}
	
	public function die():Void
	{
		if (!enable)
		{
			return;
		}
		_dieSfx.play();
		teleportToRespawn();
		flippedRender = draw.flipped;
	}
	
	private function teleportToRespawn():Void
	{
		if (respawnPoint != null)
		{
			_startX = respawnPoint.transform.x + 8;
			_startY = respawnPoint.transform.y - 8;
		}
		transform.x = _startX;
		transform.y = _startY;
	}
	
	public function disableBullet():Void
	{
		bullet = null;
	}
	
	override private function removed():Void 
	{
		disableBullet();
		super.removed();
	}
	
	override private function destroyed():Void 
	{
		super.destroyed();
		_characterController = null;
		_grid = null;
	}
}