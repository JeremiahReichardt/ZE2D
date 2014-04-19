package scenes;

import objects.Player;
import ze.component.debug.GDebug;
import ze.object.GameObject;
import ze.object.Scene;

/**
 * ...
 * @author Goh Zi He
 */
class GameScene extends Scene
{
	override private function added():Void
	{
		super.added();
		
		var player:Player = new Player();
		addGameObject(player);
		
		var gDebug:GDebug = new GDebug();
		gDebug.registerCallBack(showSelectedXY);
		createGameObject("GDebug", gDebug);
	}
	
	private function showSelectedXY(gameObject:GameObject):Void
	{
		trace("X: " + gameObject.transform.x, " Y: " + gameObject.transform.y);
	}
}