package entities;
import ze.component.physics.BoxCollider;
import ze.component.rendering.Blank;
import ze.object.GameObject;
import ze.util.Ops;

/**
 * ...
 * @author Goh Zi He
 */
class Wall extends GameObject
{
	private static inline var spacing:Int = 256;
	private static inline var width:Int = 32;
	private static inline var minHeight:Int = 32;
	private var _topWall:GameObject;
	private var _bottomWall:GameObject;
	
	public function new(x:Float)
	{
		super("wall", x);
	}
	
	override private function added():Void 
	{
		super.added();
		// Use screen height(800) - spacing (256) = 544
		// use 544 - minHeight(32) = 512
		var bottomHeight:Int = Ops.randomInt(544, 1);
		var topHeight:Int = 512 - bottomHeight + minHeight;
		
		_topWall = new GameObject("topWall", transform.x, 0);
		_topWall.addComponent(new Blank(width, topHeight));
		_topWall.addComponent(new BoxCollider(width, topHeight));
		_topWall.transform.attachTo(transform);
		scene.addGameObject(_topWall);
		
		_bottomWall = new GameObject("bottomWall", transform.x, 800 - bottomHeight);
		_bottomWall.addComponent(new Blank(width, bottomHeight));
		_bottomWall.addComponent(new BoxCollider(width, bottomHeight));
		_bottomWall.transform.attachTo(transform);
		scene.addGameObject(_bottomWall);
	}
	
	override private function update():Void 
	{
		super.update();
		transform.moveBy(-5);
	}
	
	override private function removed():Void 
	{
		super.removed();
		scene.removeGameObject(_topWall);
		scene.removeGameObject(_bottomWall);
		_topWall = null;
		_bottomWall = null;
	}
}