package puzzle.prefab;

import flash.display.BitmapData;
import puzzle.actions.MouseSelectMovement;
import puzzle.actions.Player;
import ze.component.core.CharacterController;
import ze.component.physics.BoxCollider;
import ze.component.rendering.Image;
import ze.object.GameObject;
import ze.util.Color;

/**
 * ...
 * @author Goh Zi He
 */
class PlayerObject extends GameObject
{
	public function new(params:Dynamic<Int>)
	{
		super("player", params.x, params.y);
	}
	
	override private function added():Void 
	{
		super.added();
		
		var image:Image = new Image("player", new BitmapData(16, 16, true, Color.WHITE));
		image.layer = 1;
		
		addComponent(image);
		addComponent(new BoxCollider(16, 16));
		addComponent(new CharacterController());
		addComponent(new Player());
		addComponent(new MouseSelectMovement());
	}
}