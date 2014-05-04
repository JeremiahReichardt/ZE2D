package puzzle.actions;
import ze.component.core.Component;
import ze.component.physics.Collider;
import ze.component.tilesheet.AnimatedSprite;
import ze.object.GameObject;

/**
 * ...
 * @author Goh Zi He
 */
class Switch extends Component
{
	private var _switchIndex:Int;
	private var _gate:GameObject;
	
	public function new(switchIndex:Int)
	{
		super();
		_switchIndex = switchIndex;
	}
	
	override private function added():Void 
	{
		super.added();
		collider.registerCallback(hitSwitch);
	}
	
	private function hitSwitch(collider:Collider):Void
	{
		_gate = getGameObjectByName("gate" + _switchIndex);
		
		if (_gate != null)
		{
			if (collider.gameObject.name == "player")
			{
				scene.removeGameObject(_gate);
				_gate = null;
				
				var animation:AnimatedSprite = cast (graphic, AnimatedSprite);
				if (animation.currentFrameLabel != "idle")
				{
					animation.playOnce("idle", 2);
				}
			}
		}
	}
}