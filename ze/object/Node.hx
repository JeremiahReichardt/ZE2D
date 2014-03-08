package ze.object;

import ze.Engine;

/**
 * ...
 * @author Goh Zi He
 */
class Node extends Object
{
	private var _next:Node;
	private var _previous:Node;
	
	private var _parent:Node;
	private var _child:Node;
	
	private var first(get, null):Node;
	private var last(get, null):Node;
	
	public function new() 
	{
		super();
		last = first = this;
	}
	
	private function addChild<T:Node>(node:T):T
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
	
	private function get_first():Node
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
	
	private function get_last():Node
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
	
	override private function destroyed():Void
	{
		_next = null;
		_previous = null;
		_parent = null;
		_child = null;
		first = null;
		last = null;
	}
}