import lime.Assets;
#if !macro


class ApplicationMain {
	
	
	public static var config:lime.app.Config;
	public static var preloader:openfl.display.Preloader;
	
	private static var app:lime.app.Application;
	
	
	public static function create ():Void {
		
		app = new openfl.display.Application ();
		app.create (config);
		
		var display = new NMEPreloader ();
		
		preloader = new openfl.display.Preloader (display);
		preloader.onComplete = init;
		preloader.create (config);
		
		#if js
		var urls = [];
		var types = [];
		
		
		urls.push ("atlas/game.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("atlas/game.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("atlas/ui.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("atlas/ui.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("gfx/Bullet.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("gfx/Checker.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("gfx/Dialog.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("gfx/Exit.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("gfx/Font.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("gfx/HorizontalGate.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("gfx/Player.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("gfx/Respawn.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("gfx/Sign.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("gfx/Switch.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("gfx/VerticalGate.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("sfx/Hit_Hurt5.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("sfx/Laser_Shoot3.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("sfx/Pickup_Coin.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("level/Puzzle 0.oel");
		types.push (AssetType.TEXT);
		
		
		urls.push ("level/Puzzle 1.oel");
		types.push (AssetType.TEXT);
		
		
		urls.push ("level/Puzzle 2.oel");
		types.push (AssetType.TEXT);
		
		
		urls.push ("level/Puzzle 3.oel");
		types.push (AssetType.TEXT);
		
		
		urls.push ("level/Puzzle 4.oel");
		types.push (AssetType.TEXT);
		
		
		urls.push ("level/Puzzle 5.oel");
		types.push (AssetType.TEXT);
		
		
		urls.push ("level/Puzzle.oep");
		types.push (AssetType.TEXT);
		
		
		urls.push ("font/Font.fnt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("font/Font_0.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("font/GROBOLD.bmfc");
		types.push (AssetType.TEXT);
		
		
		urls.push ("font/GROBOLD.eot");
		types.push (AssetType.BINARY);
		
		
		urls.push ("font/GROBOLD.svg");
		types.push (AssetType.TEXT);
		
		
		urls.push ("font/GROBOLD.ttf");
		types.push (AssetType.FONT);
		
		
		urls.push ("font/GROBOLD.woff");
		types.push (AssetType.BINARY);
		
		
		urls.push ("font/Grobold.xml");
		types.push (AssetType.TEXT);
		
		
		
		preloader.load (urls, types);
		#end
		
		var result = app.exec ();
		
		#if sys
		Sys.exit (result);
		#end
		
	}
	
	
	public static function init ():Void {
		
		var loaded = 0;
		var total = 0;
		var library_onLoad = function (__) {
			
			loaded++;
			
			if (loaded == total) {
				
				start ();
				
			}
			
		}
		
		preloader = null;
		
		
		
		if (loaded == total) {
			
			start ();
			
		}
		
	}
	
	
	public static function main () {
		
		config = {
			
			antialiasing: Std.int (0),
			background: Std.int (0),
			borderless: false,
			depthBuffer: false,
			fps: Std.int (30),
			fullscreen: false,
			height: Std.int (800),
			orientation: "",
			resizable: true,
			stencilBuffer: false,
			title: "MyApplication",
			vsync: false,
			width: Std.int (800),
			
		}
		
		#if js
		#if munit
		flash.Lib.embed (null, 800, 800, "000000");
		#end
		#else
		create ();
		#end
		
	}
	
	
	public static function start ():Void {
		
		openfl.Lib.current.stage.align = openfl.display.StageAlign.TOP_LEFT;
		openfl.Lib.current.stage.scaleMode = openfl.display.StageScaleMode.NO_SCALE;
		
		var hasMain = false;
		
		for (methodName in Type.getClassFields (Main)) {
			
			if (methodName == "main") {
				
				hasMain = true;
				break;
				
			}
			
		}
		
		if (hasMain) {
			
			Reflect.callMethod (Main, Reflect.field (Main, "main"), []);
			
		} else {
			
			var instance:DocumentClass = Type.createInstance (DocumentClass, []);
			
			if (Std.is (instance, openfl.display.DisplayObject)) {
				
				openfl.Lib.current.addChild (cast instance);
				
			}
			
		}
		
		openfl.Lib.current.stage.dispatchEvent (new openfl.events.Event (openfl.events.Event.RESIZE, false, false));
		
	}
	
	
	#if neko
	@:noCompletion public static function __init__ () {
		
		var loader = new neko.vm.Loader (untyped $loader);
		loader.addPath (haxe.io.Path.directory (Sys.executablePath ()));
		loader.addPath ("./");
		loader.addPath ("@executable_path/");
		
	}
	#end
	
	
}


#if flash @:build(DocumentClass.buildFlash())
#else @:build(DocumentClass.build()) #end
@:keep class DocumentClass extends Main {}


#else


import haxe.macro.Context;
import haxe.macro.Expr;


class DocumentClass {
	
	
	macro public static function build ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				
				var method = macro {
					
					this.stage = flash.Lib.current.stage;
					super ();
					dispatchEvent (new openfl.events.Event (openfl.events.Event.ADDED_TO_STAGE, false, false));
					
				}
				
				fields.push ({ name: "new", access: [ APublic ], kind: FFun({ args: [], expr: method, params: [], ret: macro :Void }), pos: Context.currentPos () });
				
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
	macro public static function buildFlash ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				var method = macro {
					return flash.Lib.current.stage;
				}
				
				fields.push ({ name: "get_stage", access: [ APrivate ], meta: [ { name: ":getter", params: [ macro stage ], pos: Context.currentPos() } ], kind: FFun({ args: [], expr: method, params: [], ret: macro :flash.display.Stage }), pos: Context.currentPos() });
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
}


#end
