package scene;

import action.PlayerGun;
import flash.display.BitmapData;
import object.Bullet;
import object.Player;
import ze.component.rendering.Image;
import ze.object.GameObject;
import ze.object.Scene;
import ze.util.Input;
import ze.util.Key;

/**
 * ...
 * @author Goh Zi He
 */
class GameScene extends Scene
{
	public function new() 
	{
		super();
	}
	
	override private function added():Void 
	{
		super.added();
		
		var player:Player = new Player();
		addGameObject(player);
		//removeGameObject(player);
	}
	
	override private function update():Void 
	{
		super.update();
	}
}