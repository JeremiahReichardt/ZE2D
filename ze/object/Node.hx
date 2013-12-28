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
		last = first = this;
		enable = true;
	}
	
	private function addChild<T:Node>(node:T):T
	{
		if (Std.is(node, Type.typeof(this)))
		{
			var last:Node = last;
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
				var last:Node = _child.last;
				last._next = node;
				node._previous = last;
			}
			
			node._parent = this;
		}
		
		node.added();
		return node;
	}
	
	private function removeChild(node:Node):Void
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
	
	
	var first(get, null):Node;
	var last(get, null):Node;
	
	function get_first():Node
	{
		if (first != null && first._previous != null)
		{
			if (_previous != null)
			{
				first = _previous.get_first();
			}
		}
		return first;
	}
	
	function get_last():Node
	{
		if (last != null && last._next != null)
		{
			if (_next != null)
			{
				last = _next.get_last();
			}
		}
		return last;
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
	}
}