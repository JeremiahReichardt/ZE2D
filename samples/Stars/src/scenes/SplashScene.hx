package scenes;
import ze.component.graphic.displaylist.SplashImage;
import ze.object.Scene;
import ze.util.Input;

/**
 * A simple fade in, fade out type of splash screen, add as many logo as you need.
 * @author Goh Zi He
 */
class SplashScene extends Scene
{
	private var logo:SplashImage;
	
	override public function added():Void 
	{
		super.added();
		
		logo = new SplashImage("Splash", "gfx/Splash.png");
		createGameObject("Splash logo", logo, screen.midX - logo.halfWidth, screen.midY - logo.halfHeight);
		
		logo.fade().onComplete(done);
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (Input.anyKeyPressed() || Input.leftMousePressed())
		{
			done();
		}
	}
	
	private function done(f:Float = 0, e:FadeEvent = null):Void
	{
		engine.addScene(new MainScene());
	}
}