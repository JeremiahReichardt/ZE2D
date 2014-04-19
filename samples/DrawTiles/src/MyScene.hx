package;
import ze.component.debug.GDebug;
import ze.component.rendering.TSAnimation;
import ze.component.rendering.TSImage;
import ze.object.Scene;
import ze.util.SpriteLoader;

/**
 * ...
 * @author Goh Zi He
 */
class MyScene extends Scene
{
	override function added():Void
	{
		super.added();
		
		//SpriteLoader.loadFromTexturePacker("atlas/atlas.xml");
		SpriteLoader.loadFromShoeBox("atlas/sheet.xml");
		createGameObject("blue", new TSImage("Blue"), 50, 50);
		
		//Demo how layers are used
		var red:TSImage = new TSImage("Red");
		red.layer = 2;
		createGameObject("red", red, 130, 50);
		
		for (i in 0 ... 10)
		{
			for (j in 0 ... 5)
			{
				var anim = new TSAnimation("Sprite");
				anim.addAnimation("idle", [0, 1, 2, 1, 0]);
				anim.play("idle", 8);
				anim.layer = 0;
				createGameObject("", anim, i * 80 + 30, j * 80 + 50);
			}
		}
		
		createGameObject("GDebug", new GDebug());
	}
}