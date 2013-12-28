package puzzle.actions;

import puzzle.scene.MainScene;
import ze.component.core.Component;
import ze.component.physics.Collider;

/**
 * ...
 * @author Goh Zi He
 */
class Exit extends Component
{
	override private function added():Void 
	{
		super.added();
		collider.registerCallback(hitExit);
	}
	
	private function hitExit(collider:Collider):Void 
	{
		cast(scene, MainScene).nextLevel();
	}
}