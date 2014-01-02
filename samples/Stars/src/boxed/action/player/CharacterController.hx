package boxed.action.player;

import ze.component.core.Component;
import ze.component.physics.Collider;
import ze.component.sounds.Audio;
import ze.util.Input;
import ze.util.Key;
import ze.util.Time;

/**
 * ...
 * @author Goh Zi He
 */
class CharacterController extends Component
{
	public var currentPlayerIndex(default, null):Int;
	
	public var haveStar:Bool;
	
	private static inline var GRAVITY:Float = 50;
	public static inline var JUMP_HEIGHT:Float = 500;
	public static inline var WALKING_SPEED:Float = 200;
	private static inline var MAX_SPEED:Float = 1000;
	
	private var _gravity:Float;
	
	private var _isGrounded:Bool;
	private var _hitTop:Bool;
	
	private var _moveX:Float;
	private var _moveY:Float;
	
	private var _keyLeft:Int;
	private var _keyRight:Int;
	private var _keyJump:Int;
	private var _jump:Int;
	
	private var _jumpSfx:Audio;
	private var _touchPlayerSfx:Audio;
	
	public function new(playerIndex:Int)
	{
		super();
		currentPlayerIndex = playerIndex;
		switch(playerIndex)
		{
			case 0:
				_keyLeft = Key.A;
				_keyRight = Key.D;
				_keyJump = Key.W;
				
			case 1:
				_keyLeft = Key.LEFT;
				_keyRight = Key.RIGHT;
				_keyJump = Key.UP;
		}
	}
	
	override private function added():Void 
	{
		super.added();
		_moveX = 0;
		_moveY = 0;
		_gravity = GRAVITY;
		
		_jumpSfx = new Audio("jump sfx", "sfx/Jump5.wav");
		_touchPlayerSfx = new Audio("touch player sfx", "sfx/Hit_Hurt7.wav");
		addComponent(_jumpSfx);
		addComponent(_touchPlayerSfx);
		
		collider.registerCallback(hitPlayer);
	}
	
	override private function update():Void 
	{
		super.update();
		collider.set(transform.x, transform.y + 1, render.width, render.height);
		_isGrounded = (collider.checkCollisionWith() != null);
		
		if (_isGrounded) 
		{
			_moveY = 0;
			_jump = 0;
		}
		else
		{
			_gravity = GRAVITY;
			if (_moveY > 0)
			{
				if (Input.keyDown(_keyLeft))
				{
					collider.set(transform.x - 1, transform.y, render.width, render.height);
					if (collider.checkCollisionWith() != null)
					{
						_gravity = 0;
						_jump = 0;
					}
				}
				else if (Input.keyDown(_keyRight))
				{
					collider.set(transform.x + 1, transform.y, render.width, render.height);
					if (collider.checkCollisionWith() != null)
					{
						_gravity = 0;
						_jump = 0;
					}
				}
			}
		}
		
		if (Input.keyPressed(_keyJump) && _jump < 2)
		{
			_moveY = -JUMP_HEIGHT;
			++_jump;
			_jumpSfx.play(0.2);
		}
		
		collider.set(transform.x, transform.y - 1, render.width, render.height);
		_hitTop = collider.checkCollisionWith() != null;
		
		if (_hitTop)
		{
			_moveY = 0;
		}
		
		_moveX = 0;
		if (Input.keyDown(_keyLeft))
		{
			_moveX = -1;
			render.flipped = true;
		}
		else if (Input.keyDown(_keyRight))
		{
			_moveX = 1;
			render.flipped = false;
		}
		
		_moveX *= WALKING_SPEED;
		_moveY += _gravity;
		
		if (_moveY > MAX_SPEED)
		{
			_moveY = MAX_SPEED;
		}
		
		transform.moveBy(_moveX * Time.deltaTime, _moveY * Time.deltaTime);
		
		if (transform.y > scene.screen.bottom)
		{
			transform.y = scene.screen.top;
		}
		else if (transform.y + render.height < scene.screen.top)
		{
			transform.y = scene.screen.bottom - render.height;
		}
		else if (transform.x > scene.screen.right)
		{
			transform.x = scene.screen.left;
			transform.y -= 5;
		}
		else if (transform.x + render.width < scene.screen.left)
		{
			transform.x = scene.screen.right - render.width;
			transform.y -= 5;
		}
	}
	
	private function hitPlayer(collider:Collider):Void
	{
		if (collider.gameObject.name == "player")
		{
			if (haveStar)
			{
				_touchPlayerSfx.play();
				getComponent(CountDown).stopCountDown();
				haveStar = false;
			}
		}
	}
	
	override private function removed():Void 
	{
		super.removed();
		
		_touchPlayerSfx = null;
		_jumpSfx = null;
	}
}