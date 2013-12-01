package ze.component.physics;

import ze.component.core.Component;
import ze.util.Color;

/**
 * How to add Collision to Component, remember to use registerCallback() to register the various
 * functions
 * @author Goh Zi He
 */

class Collider extends Component
{
	public var isTrigger(default, null):Bool;
	public var x(default, default):Float;
	public var y(default, default):Float;
	public var width(default, null):Float;
	public var height(default, null):Float;
	
	private var _colliderList:Array<Collider>;
	private var _enterCallback:Collider -> Void;
	private var _exitCallback:Collider -> Void;
	private var _stayCallback:Collider -> Void;
	
	private static inline var NOCOLLISION:Int = Color.GREEN;
	private static inline var COLLISION:Int = Color.RED;
	
	private static var allColliders:Array<Collider> = [];
	
	private function new(width:Float, height:Float, trigger:Bool = false)
	{
		super();
		_colliderList = [];
		isTrigger = trigger;
		
		x = 0;
		y = 0;
		this.width = width;
		this.height = height;
	}
	
	override private function added():Void 
	{
		super.added();
		allColliders.push(this);
	}
	
	override private function update():Void 
	{
		super.update();
		
		x = transform.x;
		y = transform.y;
		
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
	
	override private function removed():Void 
	{
		allColliders.remove(this);
		_enterCallback = null;
		_exitCallback = null;
		_stayCallback = null;
		super.removed();
	}
	
	public function hitTest(otherCollider:Collider):Bool
	{
		if (x + width > otherCollider.x)
		{
			if (x < otherCollider.x + otherCollider.width)
			{
				if (y + height > otherCollider.y)
				{
					if (y < otherCollider.y + otherCollider.height)
					{
						return true;
					}
				}
			}
		}
		return false;
	}
	
	public function set(x:Float, y:Float, width:Float, height:Float):Void
	{
		setPos(x, y);
		setSize(width, height);
	}
	
	public function setPos(x:Float, y:Float):Void
	{
		this.x = x;
		this.y = y;
	}
	
	public function setSize(width:Float, height:Float):Void
	{
		this.width = width;
		this.height = height;
	}
}