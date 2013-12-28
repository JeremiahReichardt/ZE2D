package scenes;

import action.PlayerGun;
import flash.display.BitmapData;
import objects.Bullet;
import objects.Player;
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
	}
}