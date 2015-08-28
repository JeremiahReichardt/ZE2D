package;
import scenes.MainScene;
import scenes.SplashScene;
import ze.Engine;

/**
 * ...
 * @author Goh Zi He
 */
class Main extends Engine
{
	public function new()
	{
		super(new SplashScene());
	}
}