package;
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
		createGameObject("", new TSImage("Blue"));
		
		//Demo how layers are used
		createGameObject("", new TSImage("Red", 2), 100);
		
		for (i in 0 ... 10)
		{
			for (j in 0 ... 5)
			{
				var anim = new TSAnimation("Sprite");
				anim.addAnimation("idle", [0, 1, 2, 1, 0]);
				anim.play("idle", 8);
				anim.layer = 0;
				createGameObject("", anim, i * 80 + 5, j * 80 + 5);
			}
		}
	}
}