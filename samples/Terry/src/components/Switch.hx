package components;
import ze.component.core.Component;
import ze.component.graphic.tilesheet.TileAnimation;
import ze.component.physics.Collider;
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
	
	override public function added():Void 
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
				
				var animation:TileAnimation = cast (graphic, TileAnimation);
				if (animation.currentFrameLabel != "idle")
				{
					animation.playOnce("idle", 2);
				}
			}
		}
	}
}