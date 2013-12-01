package ze.object;

import ze.Engine;

/**
 * ...
 * @author Goh Zi He
 */
class Object
{
	private var engine(default, null):Engine;
	private var enable(default, set):Bool;
	private var name(default, default):String;
	
	private var _objects:Array<Object>;
	
	private var _toRemove:Bool;
	private var _toAdd:Bool;
	private var _toRemoveFromList:Bool;
	
	public function new() 
	{
		_objects = [];
		
		enable = true;
	}
	
	private function added():Void
	{
		engine = Engine.getEngine();
		_toAdd = false;
	}
	
	private function update():Void
	{
		removeRec(_objects);
		removeRecList(_objects);
		
		for (object in _objects)
		{
			if (object._toAdd) 
			{
				object.added();
			}
		}
		
		for (object in _objects)
		{
			if (object.enable) 
			{
				object.update();
			}
		}
	}
	
	private function removeRec(objects:Array<Object>):Void
	{
		var i:Int = objects.length - 1;
		while (i > 0)
		{
			var object:Object = objects[i];
			if (object._toRemove)
			{
				if (object._objects != null && object._objects.length > 0)
				{
					removeRec(object._objects);
				}
				object.removed();
			}
			--i;
		}
	}
	
	private function removeRecList(objects:Array<Object>):Void
	{
		var i:Int = objects.length - 1;
		while (i > 0)
		{
			var object:Object = objects[i];
			if (object._toRemove)
			{
				if (object._objects != null && object._objects.length > 0)
				{
					removeRec(object._objects);
				}
				objects.remove(object);
			}
			--i;
		}
	}
	
	private function removed():Void
	{
		_objects = null;
		_toRemove = false;
		_toRemoveFromList = true;
		engine = null;
	}
	
	public function add<T:Object>(object:T):T
	{
		if (Std.is(object, Object))
		{
			_objects.push(object);
			object._toAdd = true;
		}
		return object;
	}
	
	public function remove(object:Object):Void
	{
		object.enable = false;
		object._toRemove = true;
	}
	
	private function set_enable(value:Bool):Bool
	{
		enable = value;
		
		if (_objects != null)
		{
			for (object in _objects)
			{
				if (object != null)
				{
					object.enable = value;
				}
			}
		}
		
		return value;
	}
}