package ze.object;

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
	
	private var enable(default, set):Bool;
	
	public function new() 
	{
		_i = this;
	}
	
	private function addNode<T:Node>(node:T):T
	{
		var last:Node = getLastNode();
		last._next = node;
		node._previous = last;
		node._parent = _parent;
		node.added();
		return node;
	}
	
	private function addChild<T:Node>(node:T):T
	{
		_child = node;
		node._parent = this;
		
		var first:Node = _child.getFirstNode();
		for (n in first)
		{
			n._parent = this;
		}
		node.added();
		return node;
	}
	
	private function removeNode(node:Node):Void
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
		
		node.removed();	
	}
	
	private function removeChild(node:Node):Void
	{
		node._parent = null;
		var first:Node = _child.getFirstNode();
		for (n in first)
		{
			cast(n, Node)._parent = null;
		}
		
		_child = null;
		node.removed();
	}
	
	public function getLastNode():Node
	{
		if (_next != null)
		{
			return _next.getLastNode();
		}
		else
		{
			return this;
		}
	}
	
	public function getFirstNode():Node
	{
		if (_previous != null)
		{
			return _previous.getFirstNode();
		}
		else
		{
			return this;
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
	
	private function cleanup():Void
	{
		_next = null;
		_previous = null;
		_parent = null;
		_child = null;
		_i = null;
		enable = false;
	}
	
	private function set_enable(value:Bool):Bool
	{
		enable = value;
		
		if (_child != null)
		{
			var first:Node = getFirstNode();
			for (node in first)
			{
				node.enable = true;
			}
		}
		return value;
	}
	
	private function removeNext():Void
	{
		removed();
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