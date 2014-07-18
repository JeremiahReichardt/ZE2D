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
	
	private var first(get, set):Node;
	private var last(get, set):Node;
	
	public function new() 
	{
		super();
		last = first = this;
	}
	
	/**
	 * Don't call this directly unless you know what is happening,
	 * Use addGameObject/addComponent instead
	 * @param	node
	 */
	private function attachChild<T:Node>(node:T):T
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
	
	/**
	 * Don't call this directly unless you know what is happening
	 * Use removeGameObject/removeComponent instead
	 * @param	node
	 */
	private function detachChild(node:Node):Void
	{
		if (!node.enable)
		{
			return;
		}
		
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
		
		if (_child != null)
		{
			if (_child.last == node)
			{
				_child.last = prev;
			}
			else if (_child.first == node)
			{
				_child.first = next;
			}
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
		first = _parent._child;
		return _parent._child;
	}
	
	private function set_first(value:Node):Node
	{
		if (_next != null)
		{
			_next.first = value;
		}
		return value;
	}
	
	private function get_last():Node
	{
		if (_next == null)
		{
			last = this;
			return this;
		}
		else
		{
			return _next.last;
		}
	}
	
	private function set_last(value:Node):Node
	{
		if (_next != null)
		{
			_next.last = value;
		}
		return value;
	}
	
	public function added():Void
	{
	}
	
	public function update():Void
	{
	}
	
	public function removed():Void
	{
		enable = false;
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
	
	override public function destroyed():Void
	{
		_next = null;
		_previous = null;
		_parent = null;
		_child = null;
		first = null;
		last = null;
	}
}