package ze.object;

/**
 * ...
 * @author Goh Zi He
 */
class Object
{
	public var enable(default, default):Bool;
	private var engine(get, null):Engine;
	
	public function new() 
	{
		enable = true;
	}
	
	private function get_engine():Engine
	{
		return Engine.getEngine();
	}
	
	private function destroyed():Void 
	{
		enable = false;
	}
}