ZE2D
====

An openfl gameobject/component system game framework for Haxe.

###Purpose

Aims to create a simple and working proof of concept engine/framework for easy usage for creating games in flash/haxe/openfl context.

###How to use?
1. Download library from haxelib, install openfl as well.
2. Create main file(sample in ze2d) with`new Engine(new YourSceneClass());`.
3. Extend Scene class with your scene.
4. Extend GameObject class with your gameobject.
5. Extend Component class with your custom components.
6. To add your components to gameobject, type this into your added() function`add(new MyComponent());`of your newly created gameobject class.
7. And in your newly created scene file, type this into your added() function`add(new MyGameObject());`
8. To test if your stuffs is added correctly, you can go to your created component and add this`override private function update():Void {super.update(); trace("Hello, World!!")}`
