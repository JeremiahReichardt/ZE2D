package objects;

import action.PlayerGun;
import action.PlayerMovement;
import flash.display.BitmapData;
import ze.component.physics.BoxCollider;
import ze.component.rendering.Image;
import ze.object.GameObject;

/**
 * ...
 * @author Goh Zi He
 */
class Player extends GameObject
{
	public function new() 
	{
		super("Player", 200, 200);
	}
	
	override private function added():Void 
	{
		super.added();
		addComponent(new Image("Player", new BitmapData(32, 32)));
		addComponent(new BoxCollider(32, 32));
		addComponent(new PlayerMovement());
		addComponent(new PlayerGun());
		
	}
}