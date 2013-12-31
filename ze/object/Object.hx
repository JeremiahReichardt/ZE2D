package ze.object;

import ze.object.Node;

/**
 * ...
 * @author Goh Zi He
 */
class Object extends Node
{
	public var enable(default, default):Bool;
	private var engine(get, null):Engine;
	
	public function new() 
	{
		super();
		enable = true;
	}
	
	private function get_engine():Engine
	{
		return Engine.getEngine();
	}
	
	override private function destroyed():Void 
	{
		super.destroyed();
		enable = false;
	}
}