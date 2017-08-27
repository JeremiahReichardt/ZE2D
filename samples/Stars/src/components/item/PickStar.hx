package components.item;
import components.item.PickItem;
import components.player.CountDown;
import components.player.PlayerController;
import ze.component.physics.Collider;
import ze.component.sounds.Audio;
import ze.util.Input;
import ze.util.Key;

/**
 * ...
 * @author Goh Zi He
 */
class PickStar extends PickItem
{
	private var _pickStarSfx:Audio;
	private var _spawnStarSfx:Audio;
	private var _player:PlayerController;
	
	override public function added():Void 
	{
		super.added();
		_pickStarSfx = new Audio("hit star", "sfx/Pickup_Coin2.wav");
		_spawnStarSfx = new Audio("spawn star", "sfx/Powerup.wav");
		
		addComponent(_pickStarSfx);
		addComponent(_spawnStarSfx);
		
		_spawnStarSfx.play();
	}
  
  override public function update():Void 
  {
    super.update();
    
    if (Input.keyPressed(Key.Y))
    {
      scene.removeGameObject(gameObject);
    }
  }
	
	override private function onCollide(collider:Collider):Bool
	{
		//if (collider.gameObject.name == "collisionbox")
		//{
			//gameObject.kill();
			//_itemManager.spawnStar();
		//}
		
		if (super.onCollide(collider))
		{
			// Play sound
			_pickStarSfx.play();
			
			// Ask Item manager to spawn a star when time is up
			var countDown:CountDown = collider.getComponent(CountDown);
			countDown.duration = 2000;
			countDown.onCompleted = completed;
			countDown.onEnd = end;
			countDown.startCountDown();
			
			_player = collider.getComponent(PlayerController);
			_player.haveStar = true;
			
			// destroy itself
			scene.removeGameObject(gameObject);
		}
		
		return false;
	}
	
	private function completed():Void
	{
		// Add score
		end();
	}
	
	private function end():Void
	{
		_itemManager.spawnStar();
		_player.haveStar = false;
	}
}