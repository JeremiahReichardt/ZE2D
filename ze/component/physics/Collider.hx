package ze.component.physics;
import openfl.display.Shape;
import ze.component.core.Component;
import ze.util.MathUtil;

/**
 * ...
 * @author Goh Zi He
 */

class Collider extends Component
{
	public var offsetX:Float;
	public var offsetY:Float;
	public var x(default, null):Float;
	public var y(default, null):Float;
	public var width(default, null):Float;
	public var height(default, null):Float;
	public var isTrigger(default, null):Bool;
	
	private var _debugShape:Shape;
	private var enableDebugShape(default, set):Bool;
	
	private var _colliderList:Array<Collider>;
	private var _enterCallback:Collider -> Void;
	private var _exitCallback:Collider -> Void;
	private var _stayCallback:Collider -> Void;
	
	private static var allColliders:Array<Collider> = [];
	
	private function new(trigger:Bool = false)
	{
		super();
		_colliderList = [];
		isTrigger = trigger;
		x = 0;
		y = 0;
		offsetX = 0;
		offsetY = 0;
	}
	
	override public function added():Void 
	{
		super.added();
		allColliders.push(this);
		
		setPos(transform.x + offsetX, transform.y + offsetY);
	}
	
	override public function update():Void 
	{
		super.update();
		x = transform.x + offsetX;
		y = transform.y + offsetY;
		
		if (enableDebugShape)
		{
			drawDebugShape();
		}
		
		if (isTrigger)
		{
			for (collider in allColliders)
			{
				if (collider == this)
				{
					continue;
				}
				
				if (hitTest(collider))
				{
					if (addColliders(collider))
					{
						onCollisionEnter(collider);
					}
					else
					{
						onCollisionStay(collider);
					}
				}
				else
				{
					for (cl in _colliderList)
					{
						if (cl == collider)
						{
							_colliderList.remove(collider);
							onCollisionExit(collider);
						}
					}
				}
			}
		}
	}
	
	private function addColliders(collider:Collider):Bool
	{
		for (c in _colliderList)
		{
			if (c == collider)
			{
				return false;
			}
		}
		_colliderList.push(collider);
		return true;
	}
	
	public function registerCallback(enterCallBack:Collider -> Void = null, exitCallBack:Collider -> Void = null, stayCallBack:Collider -> Void = null):Void
	{
		if (!isTrigger)
		{
			trace("This collider is not a trigger and will not be able to registered");
			return;
		}
		_enterCallback = enterCallBack;
		_exitCallback = exitCallBack;
		_stayCallback = stayCallBack;
	}
	
	private function onCollisionEnter(colliderInfo:Collider):Void
	{
		if (_enterCallback != null)
		{
			_enterCallback(colliderInfo);
		}
	}
	
	private function onCollisionStay(colliderInfo:Collider):Void
	{
		if (_stayCallback != null)
		{
			_stayCallback(colliderInfo);
		}
	}
	
	private function onCollisionExit(colliderInfo:Collider):Void
	{
		if (_exitCallback != null)
		{
			_exitCallback(colliderInfo);
		}
	}
	
	public function checkCollisionWith():Collider
	{
		for (otherCollider in allColliders)
		{
			if (otherCollider.isTrigger || otherCollider == this)
			{
				continue;
			}
			
			if (hitTest(otherCollider))
			{
				return otherCollider;
			}
		}
		return null;
	}
	
	private function hitTest(collider:Collider):Bool
	{
		var colliderA:BoxCollider = cast (this, BoxCollider);
		var colliderB:BoxCollider = cast (collider, BoxCollider);
		if (colliderA != null && colliderB != null)
		{
			if (colliderA.right <= colliderB.left) return false;
			if (colliderA.bottom <= colliderB.top) return false;
			if (colliderA.left >= colliderB.right) return false;
			if (colliderA.top >= colliderB.bottom) return false;
			return true;
		}
		else if (Std.is(this, CircleCollider) && Std.is(collider, CircleCollider))
		{
			var colliderA:CircleCollider = cast (this, CircleCollider);
			var colliderB:CircleCollider = cast (collider, CircleCollider);
			if (MathUtil.distance(x, y, collider.x, collider.y) >= colliderA.radius + colliderB.radius) return false;
		}
		else if (Std.is(this, BoxCollider) && Std.is(collider, GridCollider))
		{
			var gridCollider:GridCollider = cast (collider, GridCollider);
			return (gridCollider.getGridAt(x, y) == GridCollider.COLLISION_LAYER);
		}
		else if (Std.is(this, GridCollider) && Std.is(collider, BoxCollider))
		{
			var gridCollider:GridCollider = cast (this, GridCollider);
			return (gridCollider.getGridAt(collider.x, collider.y) == GridCollider.COLLISION_LAYER);
		}
		return false;
	}
	
	public function setPos(x:Float, y:Float):Void
	{
		this.x = x;
		this.y = y;
	}
	
	override public function removed():Void 
	{
		super.removed();
		enableDebugShape = false;
		allColliders.remove(this);
	}
	
	override public function destroyed():Void 
	{
		super.destroyed();
		_enterCallback = null;
		_exitCallback = null;
		_stayCallback = null;
		_colliderList = null;
		_debugShape = null;
	}
	
	private function drawDebugShape():Void
	{
	}
	
	private function set_enableDebugShape(value:Bool):Bool
	{
		if (_debugShape == null)
		{
			_debugShape = new Shape();
			if (_debugShape.parent == null)
			{
				scene.engine.addChild(_debugShape);
			}
		}
		_debugShape.visible = enableDebugShape = value;
		return value;
	}
	
	private function get_x():Float
	{
		return transform.x + offsetX;
	}
	
	private function get_y():Float
	{
		return transform.x + offsetY;
	}
	
	public static function toggleAllDebugShape(enable:Bool = true):Void
	{
		for (collider in allColliders)
		{
			collider.enableDebugShape = enable;
			collider.drawDebugShape();
		}
	}
}