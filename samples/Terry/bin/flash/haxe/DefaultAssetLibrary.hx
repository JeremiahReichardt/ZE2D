package;


import haxe.Timer;
import haxe.Unserializer;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.text.Font;
import openfl.media.Sound;
import openfl.net.URLRequest;
import openfl.utils.ByteArray;
import openfl.Assets;

#if (flash || js)
import openfl.display.Loader;
import openfl.events.Event;
import openfl.net.URLLoader;
#end

#if sys
import sys.FileSystem;
#end

#if ios
import openfl.utils.SystemPath;
#end


@:access(openfl.media.Sound)
class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("atlas/game.png", __ASSET__atlas_game_png);
		type.set ("atlas/game.png", AssetType.IMAGE);
		className.set ("atlas/game.xml", __ASSET__atlas_game_xml);
		type.set ("atlas/game.xml", AssetType.TEXT);
		className.set ("atlas/ui.png", __ASSET__atlas_ui_png);
		type.set ("atlas/ui.png", AssetType.IMAGE);
		className.set ("atlas/ui.xml", __ASSET__atlas_ui_xml);
		type.set ("atlas/ui.xml", AssetType.TEXT);
		className.set ("gfx/Bullet.png", __ASSET__gfx_bullet_png);
		type.set ("gfx/Bullet.png", AssetType.IMAGE);
		className.set ("gfx/Checker.png", __ASSET__gfx_checker_png);
		type.set ("gfx/Checker.png", AssetType.IMAGE);
		className.set ("gfx/Dialog.png", __ASSET__gfx_dialog_png);
		type.set ("gfx/Dialog.png", AssetType.IMAGE);
		className.set ("gfx/Exit.png", __ASSET__gfx_exit_png);
		type.set ("gfx/Exit.png", AssetType.IMAGE);
		className.set ("gfx/Font.png", __ASSET__gfx_font_png);
		type.set ("gfx/Font.png", AssetType.IMAGE);
		className.set ("gfx/HorizontalGate.png", __ASSET__gfx_horizontalgate_png);
		type.set ("gfx/HorizontalGate.png", AssetType.IMAGE);
		className.set ("gfx/Player.png", __ASSET__gfx_player_png);
		type.set ("gfx/Player.png", AssetType.IMAGE);
		className.set ("gfx/Respawn.png", __ASSET__gfx_respawn_png);
		type.set ("gfx/Respawn.png", AssetType.IMAGE);
		className.set ("gfx/Sign.png", __ASSET__gfx_sign_png);
		type.set ("gfx/Sign.png", AssetType.IMAGE);
		className.set ("gfx/Switch.png", __ASSET__gfx_switch_png);
		type.set ("gfx/Switch.png", AssetType.IMAGE);
		className.set ("gfx/VerticalGate.png", __ASSET__gfx_verticalgate_png);
		type.set ("gfx/VerticalGate.png", AssetType.IMAGE);
		className.set ("sfx/Hit_Hurt5.wav", __ASSET__sfx_hit_hurt5_wav);
		type.set ("sfx/Hit_Hurt5.wav", AssetType.SOUND);
		className.set ("sfx/Laser_Shoot3.wav", __ASSET__sfx_laser_shoot3_wav);
		type.set ("sfx/Laser_Shoot3.wav", AssetType.SOUND);
		className.set ("sfx/Pickup_Coin.wav", __ASSET__sfx_pickup_coin_wav);
		type.set ("sfx/Pickup_Coin.wav", AssetType.SOUND);
		className.set ("level/Puzzle 0.oel", __ASSET__level_puzzle_0_oel);
		type.set ("level/Puzzle 0.oel", AssetType.TEXT);
		className.set ("level/Puzzle 1.oel", __ASSET__level_puzzle_1_oel);
		type.set ("level/Puzzle 1.oel", AssetType.TEXT);
		className.set ("level/Puzzle 2.oel", __ASSET__level_puzzle_2_oel);
		type.set ("level/Puzzle 2.oel", AssetType.TEXT);
		className.set ("level/Puzzle 3.oel", __ASSET__level_puzzle_3_oel);
		type.set ("level/Puzzle 3.oel", AssetType.TEXT);
		className.set ("level/Puzzle 4.oel", __ASSET__level_puzzle_4_oel);
		type.set ("level/Puzzle 4.oel", AssetType.TEXT);
		className.set ("level/Puzzle 5.oel", __ASSET__level_puzzle_5_oel);
		type.set ("level/Puzzle 5.oel", AssetType.TEXT);
		className.set ("level/Puzzle.oep", __ASSET__level_puzzle_oep);
		type.set ("level/Puzzle.oep", AssetType.TEXT);
		className.set ("font/Font.fnt", __ASSET__font_font_fnt);
		type.set ("font/Font.fnt", AssetType.TEXT);
		className.set ("font/Font_0.png", __ASSET__font_font_0_png);
		type.set ("font/Font_0.png", AssetType.IMAGE);
		className.set ("font/GROBOLD.bmfc", __ASSET__font_grobold_bmfc);
		type.set ("font/GROBOLD.bmfc", AssetType.TEXT);
		className.set ("font/GROBOLD.ttf", __ASSET__font_grobold_ttf);
		type.set ("font/GROBOLD.ttf", AssetType.FONT);
		className.set ("font/Grobold.xml", __ASSET__font_grobold_xml);
		type.set ("font/Grobold.xml", AssetType.TEXT);
		
		
		#elseif html5
		
		var id;
		id = "atlas/game.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "atlas/game.xml";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "atlas/ui.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "atlas/ui.xml";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "gfx/Bullet.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/Checker.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/Dialog.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/Exit.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/Font.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/HorizontalGate.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/Player.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/Respawn.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/Sign.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/Switch.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/VerticalGate.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "sfx/Hit_Hurt5.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Laser_Shoot3.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Pickup_Coin.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "level/Puzzle 0.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "level/Puzzle 1.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "level/Puzzle 2.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "level/Puzzle 3.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "level/Puzzle 4.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "level/Puzzle 5.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "level/Puzzle.oep";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "font/Font.fnt";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "font/Font_0.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "font/GROBOLD.bmfc";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "font/GROBOLD.ttf";
		className.set (id, __ASSET__font_grobold_ttf);
		type.set (id, AssetType.FONT);
		id = "font/Grobold.xml";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		
		
		#else
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("atlas/game.png", __ASSET__atlas_game_png);
		type.set ("atlas/game.png", AssetType.IMAGE);
		
		className.set ("atlas/game.xml", __ASSET__atlas_game_xml);
		type.set ("atlas/game.xml", AssetType.TEXT);
		
		className.set ("atlas/ui.png", __ASSET__atlas_ui_png);
		type.set ("atlas/ui.png", AssetType.IMAGE);
		
		className.set ("atlas/ui.xml", __ASSET__atlas_ui_xml);
		type.set ("atlas/ui.xml", AssetType.TEXT);
		
		className.set ("gfx/Bullet.png", __ASSET__gfx_bullet_png);
		type.set ("gfx/Bullet.png", AssetType.IMAGE);
		
		className.set ("gfx/Checker.png", __ASSET__gfx_checker_png);
		type.set ("gfx/Checker.png", AssetType.IMAGE);
		
		className.set ("gfx/Dialog.png", __ASSET__gfx_dialog_png);
		type.set ("gfx/Dialog.png", AssetType.IMAGE);
		
		className.set ("gfx/Exit.png", __ASSET__gfx_exit_png);
		type.set ("gfx/Exit.png", AssetType.IMAGE);
		
		className.set ("gfx/Font.png", __ASSET__gfx_font_png);
		type.set ("gfx/Font.png", AssetType.IMAGE);
		
		className.set ("gfx/HorizontalGate.png", __ASSET__gfx_horizontalgate_png);
		type.set ("gfx/HorizontalGate.png", AssetType.IMAGE);
		
		className.set ("gfx/Player.png", __ASSET__gfx_player_png);
		type.set ("gfx/Player.png", AssetType.IMAGE);
		
		className.set ("gfx/Respawn.png", __ASSET__gfx_respawn_png);
		type.set ("gfx/Respawn.png", AssetType.IMAGE);
		
		className.set ("gfx/Sign.png", __ASSET__gfx_sign_png);
		type.set ("gfx/Sign.png", AssetType.IMAGE);
		
		className.set ("gfx/Switch.png", __ASSET__gfx_switch_png);
		type.set ("gfx/Switch.png", AssetType.IMAGE);
		
		className.set ("gfx/VerticalGate.png", __ASSET__gfx_verticalgate_png);
		type.set ("gfx/VerticalGate.png", AssetType.IMAGE);
		
		className.set ("sfx/Hit_Hurt5.wav", __ASSET__sfx_hit_hurt5_wav);
		type.set ("sfx/Hit_Hurt5.wav", AssetType.SOUND);
		
		className.set ("sfx/Laser_Shoot3.wav", __ASSET__sfx_laser_shoot3_wav);
		type.set ("sfx/Laser_Shoot3.wav", AssetType.SOUND);
		
		className.set ("sfx/Pickup_Coin.wav", __ASSET__sfx_pickup_coin_wav);
		type.set ("sfx/Pickup_Coin.wav", AssetType.SOUND);
		
		className.set ("level/Puzzle 0.oel", __ASSET__level_puzzle_0_oel);
		type.set ("level/Puzzle 0.oel", AssetType.TEXT);
		
		className.set ("level/Puzzle 1.oel", __ASSET__level_puzzle_1_oel);
		type.set ("level/Puzzle 1.oel", AssetType.TEXT);
		
		className.set ("level/Puzzle 2.oel", __ASSET__level_puzzle_2_oel);
		type.set ("level/Puzzle 2.oel", AssetType.TEXT);
		
		className.set ("level/Puzzle 3.oel", __ASSET__level_puzzle_3_oel);
		type.set ("level/Puzzle 3.oel", AssetType.TEXT);
		
		className.set ("level/Puzzle 4.oel", __ASSET__level_puzzle_4_oel);
		type.set ("level/Puzzle 4.oel", AssetType.TEXT);
		
		className.set ("level/Puzzle 5.oel", __ASSET__level_puzzle_5_oel);
		type.set ("level/Puzzle 5.oel", AssetType.TEXT);
		
		className.set ("level/Puzzle.oep", __ASSET__level_puzzle_oep);
		type.set ("level/Puzzle.oep", AssetType.TEXT);
		
		className.set ("font/Font.fnt", __ASSET__font_font_fnt);
		type.set ("font/Font.fnt", AssetType.TEXT);
		
		className.set ("font/Font_0.png", __ASSET__font_font_0_png);
		type.set ("font/Font_0.png", AssetType.IMAGE);
		
		className.set ("font/GROBOLD.bmfc", __ASSET__font_grobold_bmfc);
		type.set ("font/GROBOLD.bmfc", AssetType.TEXT);
		
		className.set ("font/GROBOLD.ttf", __ASSET__font_grobold_ttf);
		type.set ("font/GROBOLD.ttf", AssetType.FONT);
		
		className.set ("font/Grobold.xml", __ASSET__font_grobold_xml);
		type.set ("font/Grobold.xml", AssetType.TEXT);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = this.type.get (id);
		
		#if pixi
		
		if (assetType == IMAGE) {
			
			return true;
			
		} else {
			
			return false;
			
		}
		
		#end
		
		if (assetType != null) {
			
			if (assetType == type || ((type == SOUND || type == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && type == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (type == BINARY || type == null) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getBitmapData (id:String):BitmapData {
		
		#if pixi
		
		return BitmapData.fromImage (path.get (id));
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), BitmapData);
		
		#elseif openfl_html5
		
		return BitmapData.fromImage (ApplicationMain.images.get (path.get (id)));
		
		#elseif js
		
		return cast (ApplicationMain.loaders.get (path.get (id)).contentLoaderInfo.content, Bitmap).bitmapData;
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), BitmapData);
		else return BitmapData.load (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if (flash)
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);

		#elseif (js || openfl_html5 || pixi)
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}

		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if pixi
		
		return null;
		
		#elseif (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists(id)) {
			var fontClass = className.get(id);
			Font.registerFont(fontClass);
			return cast (Type.createInstance (fontClass, []), Font);
		} else return new Font (path.get (id));
		
		#end
		
	}
	
	
	public override function getMusic (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		var sound = new Sound ();
		sound.__buffer = true;
		sound.load (new URLRequest (path.get (id)));
		return sound; 
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}
	
	
	public override function getPath (id:String):String {
		
		#if ios
		
		return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		#else
		
		return path.get (id);
		
		#end
		
	}
	
	
	public override function getSound (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:AssetType):Bool {
		
		#if flash
		
		if (type != AssetType.MUSIC && type != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:AssetType):Array<String> {
		
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (type == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadBitmapData (id:String, handler:BitmapData -> Void):Void {
		
		#if pixi
		
		handler (getBitmapData (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBitmapData (id));
			
		}
		
		#else
		
		handler (getBitmapData (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if pixi
		
		handler (getBytes (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadFont (id:String, handler:Font -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getFont (id));
			
		//}
		
		#else
		
		handler (getFont (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, Type.createEnum (AssetType, asset.type));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	public override function loadMusic (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}
	
	
	public override function loadSound (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getSound (id));
			
		//}
		
		#else
		
		handler (getSound (id));
		
		#end
		
	}
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		#if js
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}
		
		#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		#end
		
	}
	
	
}


#if pixi
#elseif flash

@:keep class __ASSET__atlas_game_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__atlas_game_xml extends openfl.utils.ByteArray { }
@:keep class __ASSET__atlas_ui_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__atlas_ui_xml extends openfl.utils.ByteArray { }
@:keep class __ASSET__gfx_bullet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_checker_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_dialog_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_exit_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_font_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_horizontalgate_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_respawn_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_sign_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_switch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_verticalgate_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__sfx_hit_hurt5_wav extends openfl.media.Sound { }
@:keep class __ASSET__sfx_laser_shoot3_wav extends openfl.media.Sound { }
@:keep class __ASSET__sfx_pickup_coin_wav extends openfl.media.Sound { }
@:keep class __ASSET__level_puzzle_0_oel extends openfl.utils.ByteArray { }
@:keep class __ASSET__level_puzzle_1_oel extends openfl.utils.ByteArray { }
@:keep class __ASSET__level_puzzle_2_oel extends openfl.utils.ByteArray { }
@:keep class __ASSET__level_puzzle_3_oel extends openfl.utils.ByteArray { }
@:keep class __ASSET__level_puzzle_4_oel extends openfl.utils.ByteArray { }
@:keep class __ASSET__level_puzzle_5_oel extends openfl.utils.ByteArray { }
@:keep class __ASSET__level_puzzle_oep extends openfl.utils.ByteArray { }
@:keep class __ASSET__font_font_fnt extends openfl.utils.ByteArray { }
@:keep class __ASSET__font_font_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__font_grobold_bmfc extends openfl.utils.ByteArray { }
@:keep class __ASSET__font_grobold_ttf extends openfl.text.Font { }
@:keep class __ASSET__font_grobold_xml extends openfl.utils.ByteArray { }


#elseif html5





























@:keep class __ASSET__font_grobold_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "font/GROBOLD.ttf"; } #end }



#elseif (windows || mac || linux)


@:bitmap("assets/atlas/game.png") class __ASSET__atlas_game_png extends flash.display.BitmapData {}
@:file("assets/atlas/game.xml") class __ASSET__atlas_game_xml extends flash.utils.ByteArray {}
@:bitmap("assets/atlas/ui.png") class __ASSET__atlas_ui_png extends flash.display.BitmapData {}
@:file("assets/atlas/ui.xml") class __ASSET__atlas_ui_xml extends flash.utils.ByteArray {}
@:bitmap("assets/gfx/Bullet.png") class __ASSET__gfx_bullet_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/Checker.png") class __ASSET__gfx_checker_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/Dialog.png") class __ASSET__gfx_dialog_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/Exit.png") class __ASSET__gfx_exit_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/Font.png") class __ASSET__gfx_font_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/HorizontalGate.png") class __ASSET__gfx_horizontalgate_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/Player.png") class __ASSET__gfx_player_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/Respawn.png") class __ASSET__gfx_respawn_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/Sign.png") class __ASSET__gfx_sign_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/Switch.png") class __ASSET__gfx_switch_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/VerticalGate.png") class __ASSET__gfx_verticalgate_png extends flash.display.BitmapData {}
@:sound("assets/sfx/Hit_Hurt5.wav") class __ASSET__sfx_hit_hurt5_wav extends flash.media.Sound {}
@:sound("assets/sfx/Laser_Shoot3.wav") class __ASSET__sfx_laser_shoot3_wav extends flash.media.Sound {}
@:sound("assets/sfx/Pickup_Coin.wav") class __ASSET__sfx_pickup_coin_wav extends flash.media.Sound {}
@:file("assets/level/Puzzle 0.oel") class __ASSET__level_puzzle_0_oel extends flash.utils.ByteArray {}
@:file("assets/level/Puzzle 1.oel") class __ASSET__level_puzzle_1_oel extends flash.utils.ByteArray {}
@:file("assets/level/Puzzle 2.oel") class __ASSET__level_puzzle_2_oel extends flash.utils.ByteArray {}
@:file("assets/level/Puzzle 3.oel") class __ASSET__level_puzzle_3_oel extends flash.utils.ByteArray {}
@:file("assets/level/Puzzle 4.oel") class __ASSET__level_puzzle_4_oel extends flash.utils.ByteArray {}
@:file("assets/level/Puzzle 5.oel") class __ASSET__level_puzzle_5_oel extends flash.utils.ByteArray {}
@:file("assets/level/Puzzle.oep") class __ASSET__level_puzzle_oep extends flash.utils.ByteArray {}
@:file("assets/font/Font.fnt") class __ASSET__font_font_fnt extends flash.utils.ByteArray {}
@:bitmap("assets/font/Font_0.png") class __ASSET__font_font_0_png extends flash.display.BitmapData {}
@:file("assets/font/GROBOLD.bmfc") class __ASSET__font_grobold_bmfc extends flash.utils.ByteArray {}
@:font("assets/font/GROBOLD.ttf") class __ASSET__font_grobold_ttf extends flash.text.Font {}
@:file("assets/font/Grobold.xml") class __ASSET__font_grobold_xml extends flash.utils.ByteArray {}


#end
