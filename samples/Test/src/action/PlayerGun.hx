package action;

import objects.Bullet;
import ze.component.core.Component;
import ze.component.sounds.Audio;
import ze.util.Input;

/**
 * ...
 * @author Goh Zi He
 */
class PlayerGun extends Component
{
	private var _laserAudio:Audio;
	
	override private function added():Void 
	{
		super.added();
		
		_laserAudio = new Audio("Laser", "sfx/Laser_Shoot3.wav");
	}
	
	override private function update():Void 
	{
		super.update();
		
		if (Input.leftMousePressed())
		{
			_laserAudio.play();
			
			var dirX:Float = Input.mouseX - transform.x;
			var dirY:Float = Input.mouseY - transform.y;
			var magnitude:Float = Math.sqrt((dirX * dirX) + (dirY * dirY));
			
			var bullet:Bullet = new Bullet(transform.x + 16 , transform.y + 16, dirX / magnitude, dirY / magnitude);
			scene.addGameObject(bullet);
		}
	}
}