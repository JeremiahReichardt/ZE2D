ZE2D[![GitHub license](https://img.shields.io/github/license/mashape/apistatus.svg)]()[![Build Status](https://travis-ci.org/zine92/ZE2D.png?branch=master)](https://travis-ci.org/zine92/ZE2D)
====

![alt text](ZE2D.png "ZE2D")

An [OpenFL](https://github.com/openfl/openfl) entity/component system game framework for [Haxe](http://haxe.org/).

# Purpose
Aims to create a simple and working proof of concept engine for easy usage for creating games in flash/haxe/openfl context.

# What works currently?
* Component Entity System?
* Rendering - Tilesheet(layered)/DisplayList(non-layered).
* Basic Physics - AABB and Grid based.
* Playing audio.
* Interactive debug mode(Can pause game and uses mouse to drag game object around).

# Tutorials.
* Hello, World!
* Adding and creating sprites.
  * Adding a blank sprite.
  * Adding a image sprite.
  * Adding a animated sprite.
* Removing sprites.
* Handling inputs.
* Collision detection.

# Hello, World!
Create a blank haxe file named hello.hx.

```
package;
import ze.component.graphic.displaylist.Text;
import ze.util.Color;

// Main class
class Main extends ze.Engine
{
    public function new()
    {
        super(new MyScene());
    }
}

// Scene class, can be put in a separate file
class MyScene extends ze.object.Scene
{
    override public function added():Void
    {
        super.added();

        createGameObject("Hello World Object", new Text("Hello World!", Color.RED), 100, 100);
    }

    override public function update():Void
    {
        super.update();
        // Things to keep running here.
    }
}
```

# Adding and creating sprites.
There are multiple ways to create sprites and add them onto the scene. There are two ways in which we can add objects into the scene. The two methods are `addGameObject` and `createGameObject`. `createGameObject` is very easy to use, as seen above in the Hello World example. Next I will show how to add a blank sprite.

## Adding a blank sprite.
This example will show you how to create a white square and add it to the scene. Inside the added function of the scene, copy and paste this line.

```
// Arguments are name, component(s)(Optional), position
createGameObject("Square Object", new ze.component.graphic.displaylist.Blank(32, 32), 300, 250);
```

This will create a new 32x32 white square at x position 300 and y position 250. Another way to add the same object will be to use the `addGameObject` function.

```
var obj = new ze.object.GameObject("Square", 300, 250);
addGameObject(obj);
obj.addComponent(new ze.component.graphic.displaylist.Blank(32, 32));
```

This does the same thing as above. If you realized, inside the `createGameObject` function, this is essentially what it is doing. Things to note when calling `addGameObject` is to ensure that it is called inside the `added` function of the scene and it must always be called before adding any component to the game object. This ensures that all game object initialization is done properly before initializing any other components. How about adding sprites with images?

## Adding a image sprite.
Adding sprites with images is very simple, just add this line.
```
// Where Assets/gfx/Sprite.png is where you store the sprites
createGameObject("Sprite", new ze.component.graphic.displaylist.Image("Sprite", "gfx/Sprite.png"), 100, 100);
```

Only thing to take note is the path of the image.

## Adding an animated sprite.
Animated sprites are actually 1 single image, but we split it into smaller section which we call it a frame and we can specify which part of the image is which animation and when we play the animation, we can set which parts to play.

```
// Similar to image but need to add the frames for the animation("idle") and set it to play the ("idle") animation.
createGameObject("Sprite", new Animation("Animated", "gfx/Animated.png", 32, 32).addAnimationFromFrame("idle", 0, 10).play("idle"), 100, 100);
```

Things to take note is, when adding animation, be sure to specify the animation frames so that we can specify what animation to play from the sprite. Now that we have learn to add our sprites to the screen, we still have to make it move.

# Removing sprites.
To remove sprite, just do `removeGameObject`.

```
removeGameObject(object);
```

# Handling inputs.
Before we implement the input handling, we need to prepare a few things, firstly, we need to add a class variable on top to hold our created game object so that we can manipulate it. Your scene class should look something like this.

```
class MyScene extends ze.object.Scene
{
    // Added a new variable to hold our created object
    private var object:GameObject;

    override public function added():Void
    {
        super.added();

        // Assign object to the created object
        object = createGameObject("Square Object", new Blank(32, 32), 300, 250);
    }

    override public function update():Void
    {
        super.update();
        // Update codes goes below
    }
}
```

Next, we can add this line to the update function.

```
object.transform.setPos(ze.util.Input.mouseX, ze.util.Input.mouseY);
```

This will make the object follow the mouse's position. (Transform is actually a component of the game object.) Next, we will make something more interesting, we will make our object shoot bullets when a key is pressed. Before that, we need to add some variables for our bullet. Add the following to the class variable.

```
private var bullet:GameObject;
private var xDir:Float;
private var yDir:Float;
```

Next, add the following lines below the mouse code in the update function.

```
// Mouse update sprite position here

// Make sure the bullet is valid.
if (bullet == null)
{
    // Check if spacebar is pressed.
    if (ze.util.Input.keyPressed(ze.util.Key.SPACEBAR))
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
```

This code will create a new bullet when spacebar is pressed for the first time, once a bullet have been created, it will move the bullet instead of creating more bullets and it will check if the bullet is within the screen and if not, it will be removed. Now that the sprite is able to move and shoot, we can implement an enemy in the next section.

# Collision detection.
To be able to detect collision, we rely on the collider components to check for collision. Before we jump into the collision part, we need to add an enemy variable to the MyScene class.

```
private var enemy:GameObject;
```

And in the added function, we will create the enemy and add a collider component to our square object(player) and our enemy. (Make sure to add this after the creation of object.)

```
// Creation of object
// Add a box collider to square object, but note the last param is true, meaning to
// say this collider will trigger an event if any collision occur.
var boxCollider = new ze.component.physics.BoxCollider(32, 32, true);
object.addComponent(boxCollider);

// After the component is added, register the collider event.
boxCollider.registerCallback(onEnter);

// Create an enemy at random position within the screen width and height
enemy = createGameObject("Enemy", new Blank(32, 32, ze.util.Color.RED), Math.random() * screen.width, Math.random() * screen.height);

// Likewise, adding a box collider for enemy but no trigger
enemy.addComponent(new ze.component.physics.BoxCollider(32, 32));
```

What we have done is added a new object and added 2 box collider component to both objects and set one of those box collider to be triggered. Next, we register the event of the collision to a function named onEnter. (Note: we have not implemented onEnter yet, thats why we are going to create a function named onEnter.)

```
private function onEnter(collider:ze.component.physics.Collider):Void
{
    // Because the trigger is set on the square object, whatever it collided with, will be the collider that is passed in.
    removeGameObject(collider.gameObject);
}
```

That's the end of the short tutorials, this tutorial can be found in the samples folder under the project Simple tutorial. There are a few more examples in the samples folder, a few are games. Go ahead and make some awesome games, and I hope that this framework is of some use.
