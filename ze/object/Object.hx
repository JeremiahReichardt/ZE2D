package ze.object;

/**
 * ...
 * @author Goh Zi He
 */
class Object
{
	public var enable(default, default):Bool;
	
	public function new() 
	{
		enable = true;
	}
	
	public function destroyed():Void 
	{
	}
}