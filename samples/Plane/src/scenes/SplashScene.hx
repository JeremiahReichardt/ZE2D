package scenes;
import ze.component.graphic.displaylist.SplashImage;
import ze.object.Scene;

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
		
		logo = new SplashImage("Splash");
		createGameObject("Splash logo", logo, screen.midX - logo.halfWidth, screen.midY - logo.halfHeight);
		
		logo.fade().onComplete(done);
	}
	
	private function done(_,_):Void
	{
		engine.addScene(new MainScene());
	}
}