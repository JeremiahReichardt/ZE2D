ZE2D
====

An openfl gameobject/component system game framework for Haxe. Inspired by FlashPunk, Unity.

###Purpose
Aims to create a simple and working proof of concept engine/framework for easy usage for creating games in flash/haxe/openfl context.

###How to use
1. Create Main.hx and inside the main function include, `new Engine(new MyScene());`, Engine will run MyScene automatically.
2. Create a MyScene.hx and extend from ze.object.Scene .
3. Create a MyGameObject.hx and extend from ze.object.GameObject .
4. Create a MyComponent.hx and extend from ze.component.core.Component .
5. To add a MyComponent to MyGameObject, in MyGameObject, include this in the added function, `addChild(new MyComponent())`.
6. Then in MyScene include `addChild(new MyGameObject())` in the added function.
7. To test if all is working, add an update function to MyComponent and include this inside,`trace("Hello, Welcome to ZE2D");`

###Quick Start
1. Download ze2d from haxelib.
2. For learning, look in test folder for examples on how to create a simple project.
3. Or unzip template.zip and start using it.

###Supports Ogmo Editor
Feels free to use the ogmo editor to create levels and import with OgmoLoader component.

    var _ogmoLoader:OgmoLoader = new OgmoLoader();
    _ogmoLoader.setOEL("level/LevelName.oel");
    _ogmoLoader.setLayer("Entities");
    _ogmoLoader.setEntity("Player", PlayerObject);
    _ogmoLoader.loadAll();
    
----

    class PlayerObject extends GameObject
    {
        //Custom Param here
    	public function new(params:Dynamic)
    	{
    		super();
    	}
    }