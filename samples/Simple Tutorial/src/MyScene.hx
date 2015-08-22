package;
import ze.component.graphic.displaylist.Blank;
import ze.component.graphic.displaylist.Text;
import ze.component.physics.BoxCollider;
import ze.component.physics.Collider;
import ze.object.GameObject;
import ze.object.Scene;
import ze.util.Color;
import ze.util.Input;
import ze.util.Key;

/**
 * ...
 * @author Goh Zi He
 */

class MyScene extends Scene
{
	private var object:GameObject;
	private var bullet:GameObject;
	private var enemy:GameObject;
	private var xDir:Float;
	private var yDir:Float;

    override public function added():Void
    {
        super.added();
		
        createGameObject("Hello World Object", new Text("Hello World!", Color.RED), 100, 100);
		
		// Arguments are name, component(s)(Optional), position
		object = createGameObject("Square Object", new Blank(32, 32), 300, 250);
		
		// Add a box collider to square object, but note the last param is true, meaning to
		// say this collider will trigger an event if any collision occur.
		var boxCollider = new BoxCollider(32, 32, true);
		object.addComponent(boxCollider);
		
		// After the component is added, register the collider event.
		boxCollider.registerCallback(onEnter);
		
		// Create an enemy at random position within the screen width and height
		enemy = createGameObject("Enemy", new Blank(32, 32, Color.RED), Math.random() * screen.width, Math.random() * screen.height);
		
		// Likewise, adding a box collider for enemy but no trigger
		enemy.addComponent(new BoxCollider(32, 32));
    }

    override public function update():Void
    {
        super.update();
		
        // Things to keep running here.
		object.transform.setPos(Input.mouseX, Input.mouseY);
		
		// Make sure the bullet is valid.
		if (bullet == null)
		{
			// Check if spacebar is pressed.
			if (Input.keyPressed(Key.SPACEBAR))
			{
				// Assign bullet to the newly created bullet
				bullet = createGameObject("Bullet", new Blank(16, 16, Color.GREEN), object.transform.x,  object.transform.y);
				
				// Randomly create a bullet travel direction.
				xDir = Math.random() - 0.5;
				yDir = Math.random() - 0.5;
			  }
		}
		else
		{
			// When bullet is valid, move the bullet.
			if (bullet.transform.x < screen.right && 
				bullet.transform.x > screen.left &&
				bullet.transform.y < screen.bottom &&
				bullet.transform.y > screen.top)
			{
				bullet.transform.moveBy(xDir * 30.0, yDir * 30.0);
			}
			else
			{
				// Otherwise, remove the bullet when it goes out of screen.
				removeGameObject(bullet);
				bullet = null;
			}
		}
    }
	
	private function onEnter(collider:Collider):Void
	{
		// Because the trigger is set on the square object, whatever it collided with, will be the collider that is passed in.
		removeGameObject(collider.gameObject);
	}
}