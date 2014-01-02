package boxed.action.item;

import boxed.action.item.PickItem;
import boxed.action.player.CharacterController;
import boxed.action.player.CountDown;
import ze.component.physics.Collider;
import ze.component.sounds.Audio;
import ze.object.GameObject;

/**
 * ...
 * @author Goh Zi He
 */
class PickStar extends PickItem
{
	private var _pickStarSfx:Audio;
	private var _spawnStarSfx:Audio;
	private var _characterController:CharacterController;
	
	override private function added():Void 
	{
		super.added();
		_pickStarSfx = new Audio("hit star", "sfx/Pickup_Coin2.wav");
		_spawnStarSfx = new Audio("spawn star", "sfx/Powerup.wav");
		
		addComponent(_pickStarSfx);
		addComponent(_spawnStarSfx);
		
		_spawnStarSfx.play();
	}
	
	override private function onCollide(collider:Collider):Bool
	{
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
			
			_characterController = collider.getComponent(CharacterController);
			_characterController.haveStar = true;
			
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
		_characterController.haveStar = false;
	}
}