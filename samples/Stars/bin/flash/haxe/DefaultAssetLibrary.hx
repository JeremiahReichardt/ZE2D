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
		
		className.set ("atlas/sprites.png", __ASSET__atlas_sprites_png);
		type.set ("atlas/sprites.png", AssetType.IMAGE);
		className.set ("atlas/sprites.xml", __ASSET__atlas_sprites_xml);
		type.set ("atlas/sprites.xml", AssetType.TEXT);
		className.set ("gfx/Checker.png", __ASSET__gfx_checker_png);
		type.set ("gfx/Checker.png", AssetType.IMAGE);
		className.set ("gfx/PlayBtn.png", __ASSET__gfx_playbtn_png);
		type.set ("gfx/PlayBtn.png", AssetType.IMAGE);
		className.set ("gfx/Player.png", __ASSET__gfx_player_png);
		type.set ("gfx/Player.png", AssetType.IMAGE);
		className.set ("gfx/QuitBtn.png", __ASSET__gfx_quitbtn_png);
		type.set ("gfx/QuitBtn.png", AssetType.IMAGE);
		className.set ("gfx/Star.png", __ASSET__gfx_star_png);
		type.set ("gfx/Star.png", AssetType.IMAGE);
		className.set ("sfx/Hit_Hurt7.wav", __ASSET__sfx_hit_hurt7_wav);
		type.set ("sfx/Hit_Hurt7.wav", AssetType.SOUND);
		className.set ("sfx/Jump5.wav", __ASSET__sfx_jump5_wav);
		type.set ("sfx/Jump5.wav", AssetType.SOUND);
		className.set ("sfx/Pickup_Coin2.wav", __ASSET__sfx_pickup_coin2_wav);
		type.set ("sfx/Pickup_Coin2.wav", AssetType.SOUND);
		className.set ("sfx/Powerup.wav", __ASSET__sfx_powerup_wav);
		type.set ("sfx/Powerup.wav", AssetType.SOUND);
		className.set ("level/Game.oep", __ASSET__level_game_oep);
		type.set ("level/Game.oep", AssetType.TEXT);
		className.set ("level/Level 1.oel", __ASSET__level_level_1_oel);
		type.set ("level/Level 1.oel", AssetType.TEXT);
		className.set ("level/Level 2.oel", __ASSET__level_level_2_oel);
		type.set ("level/Level 2.oel", AssetType.TEXT);
		className.set ("level/Level 3.oel", __ASSET__level_level_3_oel);
		type.set ("level/Level 3.oel", AssetType.TEXT);
		className.set ("level/Level 4.oel", __ASSET__level_level_4_oel);
		type.set ("level/Level 4.oel", AssetType.TEXT);
		className.set ("level/Level 5.oel", __ASSET__level_level_5_oel);
		type.set ("level/Level 5.oel", AssetType.TEXT);
		
		
		#elseif html5
		
		var id;
		id = "atlas/sprites.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "atlas/sprites.xml";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "gfx/Checker.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/PlayBtn.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/Player.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/QuitBtn.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "gfx/Star.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "sfx/Hit_Hurt7.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Jump5.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Pickup_Coin2.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "sfx/Powerup.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "level/Game.oep";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "level/Level 1.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "level/Level 2.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "level/Level 3.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "level/Level 4.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "level/Level 5.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		
		
		#else
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("atlas/sprites.png", __ASSET__atlas_sprites_png);
		type.set ("atlas/sprites.png", AssetType.IMAGE);
		
		className.set ("atlas/sprites.xml", __ASSET__atlas_sprites_xml);
		type.set ("atlas/sprites.xml", AssetType.TEXT);
		
		className.set ("gfx/Checker.png", __ASSET__gfx_checker_png);
		type.set ("gfx/Checker.png", AssetType.IMAGE);
		
		className.set ("gfx/PlayBtn.png", __ASSET__gfx_playbtn_png);
		type.set ("gfx/PlayBtn.png", AssetType.IMAGE);
		
		className.set ("gfx/Player.png", __ASSET__gfx_player_png);
		type.set ("gfx/Player.png", AssetType.IMAGE);
		
		className.set ("gfx/QuitBtn.png", __ASSET__gfx_quitbtn_png);
		type.set ("gfx/QuitBtn.png", AssetType.IMAGE);
		
		className.set ("gfx/Star.png", __ASSET__gfx_star_png);
		type.set ("gfx/Star.png", AssetType.IMAGE);
		
		className.set ("sfx/Hit_Hurt7.wav", __ASSET__sfx_hit_hurt7_wav);
		type.set ("sfx/Hit_Hurt7.wav", AssetType.SOUND);
		
		className.set ("sfx/Jump5.wav", __ASSET__sfx_jump5_wav);
		type.set ("sfx/Jump5.wav", AssetType.SOUND);
		
		className.set ("sfx/Pickup_Coin2.wav", __ASSET__sfx_pickup_coin2_wav);
		type.set ("sfx/Pickup_Coin2.wav", AssetType.SOUND);
		
		className.set ("sfx/Powerup.wav", __ASSET__sfx_powerup_wav);
		type.set ("sfx/Powerup.wav", AssetType.SOUND);
		
		className.set ("level/Game.oep", __ASSET__level_game_oep);
		type.set ("level/Game.oep", AssetType.TEXT);
		
		className.set ("level/Level 1.oel", __ASSET__level_level_1_oel);
		type.set ("level/Level 1.oel", AssetType.TEXT);
		
		className.set ("level/Level 2.oel", __ASSET__level_level_2_oel);
		type.set ("level/Level 2.oel", AssetType.TEXT);
		
		className.set ("level/Level 3.oel", __ASSET__level_level_3_oel);
		type.set ("level/Level 3.oel", AssetType.TEXT);
		
		className.set ("level/Level 4.oel", __ASSET__level_level_4_oel);
		type.set ("level/Level 4.oel", AssetType.TEXT);
		
		className.set ("level/Level 5.oel", __ASSET__level_level_5_oel);
		type.set ("level/Level 5.oel", AssetType.TEXT);
		
		
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

@:keep class __ASSET__atlas_sprites_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__atlas_sprites_xml extends openfl.utils.ByteArray { }
@:keep class __ASSET__gfx_checker_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_playbtn_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_quitbtn_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__gfx_star_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__sfx_hit_hurt7_wav extends openfl.media.Sound { }
@:keep class __ASSET__sfx_jump5_wav extends openfl.media.Sound { }
@:keep class __ASSET__sfx_pickup_coin2_wav extends openfl.media.Sound { }
@:keep class __ASSET__sfx_powerup_wav extends openfl.media.Sound { }
@:keep class __ASSET__level_game_oep extends openfl.utils.ByteArray { }
@:keep class __ASSET__level_level_1_oel extends openfl.utils.ByteArray { }
@:keep class __ASSET__level_level_2_oel extends openfl.utils.ByteArray { }
@:keep class __ASSET__level_level_3_oel extends openfl.utils.ByteArray { }
@:keep class __ASSET__level_level_4_oel extends openfl.utils.ByteArray { }
@:keep class __ASSET__level_level_5_oel extends openfl.utils.ByteArray { }


#elseif html5




















#elseif (windows || mac || linux)


@:bitmap("assets/atlas/sprites.png") class __ASSET__atlas_sprites_png extends flash.display.BitmapData {}
@:file("assets/atlas/sprites.xml") class __ASSET__atlas_sprites_xml extends flash.utils.ByteArray {}
@:bitmap("assets/gfx/Checker.png") class __ASSET__gfx_checker_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/PlayBtn.png") class __ASSET__gfx_playbtn_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/Player.png") class __ASSET__gfx_player_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/QuitBtn.png") class __ASSET__gfx_quitbtn_png extends flash.display.BitmapData {}
@:bitmap("assets/gfx/Star.png") class __ASSET__gfx_star_png extends flash.display.BitmapData {}
@:sound("assets/sfx/Hit_Hurt7.wav") class __ASSET__sfx_hit_hurt7_wav extends flash.media.Sound {}
@:sound("assets/sfx/Jump5.wav") class __ASSET__sfx_jump5_wav extends flash.media.Sound {}
@:sound("assets/sfx/Pickup_Coin2.wav") class __ASSET__sfx_pickup_coin2_wav extends flash.media.Sound {}
@:sound("assets/sfx/Powerup.wav") class __ASSET__sfx_powerup_wav extends flash.media.Sound {}
@:file("assets/level/Game.oep") class __ASSET__level_game_oep extends flash.utils.ByteArray {}
@:file("assets/level/Level 1.oel") class __ASSET__level_level_1_oel extends flash.utils.ByteArray {}
@:file("assets/level/Level 2.oel") class __ASSET__level_level_2_oel extends flash.utils.ByteArray {}
@:file("assets/level/Level 3.oel") class __ASSET__level_level_3_oel extends flash.utils.ByteArray {}
@:file("assets/level/Level 4.oel") class __ASSET__level_level_4_oel extends flash.utils.ByteArray {}
@:file("assets/level/Level 5.oel") class __ASSET__level_level_5_oel extends flash.utils.ByteArray {}


#end
