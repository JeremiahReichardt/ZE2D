package ze.object;

import ze.Engine;

/**
 * ...
 * @author Goh Zi He
 */
class Node
{
	private var _next:Node;
	private var _previous:Node;
	
	private var _parent:Node;
	private var _child:Node;
	
	private var enable(default, default):Bool;
	
	public function new() 
	{
		_i = this;
	}
	
	public function addChild<T:Node>(node:T):T
	{
		if (Std.is(node, Type.typeof(this)))
		{
			var last:Node = getLastNode();
			last._next = node;
			node._previous = last;
			node._parent = _parent;
		}
		else
		{
			if (_child == null)
			{
				_child = node;
			}
			else
			{
				var last:Node = _child.getLastNode();
				last._next = node;
				node._previous = last;
			}
			
			node._parent = this;
		}
		
		node.added();
		return node;
	}
	
	public function removeChild(node:Node):Void
	{
		var prev:Node = node._previous;
		var next:Node = node._next;
		
		if (prev != null)
		{
			prev._next = next;
		}
		
		if (next != null)
		{
			next._previous = prev;
		}
		
		if (!Std.is(node, Type.typeof(this)))
		{
			if (node == _child)
			{
				_child = next;
			}
		}
		
		node.removed();	
	}
	
	public function getLastNode():Node
	{
		var node:Node = this;
		while (true)
		{
			if (node._next == null)
			{
				return node;
			}
			node = node._next;
		}
	}
	
	public function getFirstNode():Node
	{
		var node:Node = this;
		while (true)
		{
			if (node._previous == null)
			{
				return node;
			}
			node = node._previous;
		}
	}
	
	private function added():Void
	{
	}
	
	private function update():Void
	{
	}
	
	private function removed():Void
	{
		
	}
	
	private function removeAll():Void
	{
		var node:Node = _next;
		while (node != null)
		{
			node.removed();
			node = node._next;
		}
		
		var node:Node = _previous;
		while (node != null)
		{
			node.removed();
			node = node._next;
		}
		
		removed();
	}
	
	private function destroyed():Void
	{
		enable = false;
		_next = null;
		_previous = null;
		_parent = null;
		_child = null;
		_i = null;
	}
	
	/**
	 * For iterator to use
	 */
	private var _i:Node;
	public function next():Node
	{
		var next:Node = _i;
		_i = _i._next;
		return next;
	}
	public function hasNext():Bool
	{
		if (_i == null)
		{
			_i = this;
			return false;
		}
		return true;
	}
}