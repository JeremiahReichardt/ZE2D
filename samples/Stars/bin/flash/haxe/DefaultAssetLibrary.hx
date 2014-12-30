package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Preloader;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Font;
import lime.graphics.Image;
import lime.utils.ByteArray;
import lime.utils.UInt8Array;
import lime.Assets;

#if (sys || nodejs)
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


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
		
		#if openfl
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		#end
		
		#if (windows || mac || linux)
		
		/*var useManifest = false;
		
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
		*/
		var useManifest = true;
		
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
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && requestedType == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return AudioBuffer.fromFile (path.get (id));
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
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
		
		//return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		//else 
		return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Dynamic /*Font*/ {
		
		// TODO: Complete Lime Font API
		
		#if openfl
		#if (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), openfl.text.Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			openfl.text.Font.registerFont (fontClass);
			return cast (Type.createInstance (fontClass, []), openfl.text.Font);
			
		} else {
			
			return new openfl.text.Font (path.get (id));
			
		}
		
		#end
		#end
		
		return null;
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		return Image.fromFile (path.get (id));
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
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
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String, handler:AudioBuffer -> Void):Void {
		
		#if (flash || js)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getAudioBuffer (id));
			
		//}
		
		#else
		
		handler (getAudioBuffer (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if flash
		
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
	
	
	public override function loadImage (id:String, handler:Image -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				handler (Image.fromBitmapData (bitmapData));
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getImage (id));
			
		}
		
		#else
		
		handler (getImage (id));
		
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
								type.set (asset.id, cast (asset.type, AssetType));
								
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
	
	
	/*public override function loadMusic (id:String, handler:Dynamic -> Void):Void {
		
		#if (flash || js)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}*/
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		//#if html5
		
		/*if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}*/
		
		//#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		//#end
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__atlas_sprites_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__atlas_sprites_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__gfx_checker_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_playbtn_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_quitbtn_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_star_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__sfx_hit_hurt7_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__sfx_jump5_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__sfx_pickup_coin2_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__sfx_powerup_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__level_game_oep extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__level_level_1_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__level_level_2_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__level_level_3_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__level_level_4_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__level_level_5_oel extends flash.utils.ByteArray { }


#elseif html5

#if openfl


















#end

#else

#if openfl

#end

#if (windows || mac || linux)

//
//@:bitmap("assets/atlas/sprites.png") class __ASSET__atlas_sprites_png extends openfl.display.BitmapData {}
//@:file("assets/atlas/sprites.xml") class __ASSET__atlas_sprites_xml extends lime.utils.ByteArray {}
//@:bitmap("assets/gfx/Checker.png") class __ASSET__gfx_checker_png extends openfl.display.BitmapData {}
//@:bitmap("assets/gfx/PlayBtn.png") class __ASSET__gfx_playbtn_png extends openfl.display.BitmapData {}
//@:bitmap("assets/gfx/Player.png") class __ASSET__gfx_player_png extends openfl.display.BitmapData {}
//@:bitmap("assets/gfx/QuitBtn.png") class __ASSET__gfx_quitbtn_png extends openfl.display.BitmapData {}
//@:bitmap("assets/gfx/Star.png") class __ASSET__gfx_star_png extends openfl.display.BitmapData {}
//@:sound("assets/sfx/Hit_Hurt7.wav") class __ASSET__sfx_hit_hurt7_wav extends openfl.media.Sound {}
//@:sound("assets/sfx/Jump5.wav") class __ASSET__sfx_jump5_wav extends openfl.media.Sound {}
//@:sound("assets/sfx/Pickup_Coin2.wav") class __ASSET__sfx_pickup_coin2_wav extends openfl.media.Sound {}
//@:sound("assets/sfx/Powerup.wav") class __ASSET__sfx_powerup_wav extends openfl.media.Sound {}
//@:file("assets/level/Game.oep") class __ASSET__level_game_oep extends lime.utils.ByteArray {}
//@:file("assets/level/Level 1.oel") class __ASSET__level_level_1_oel extends lime.utils.ByteArray {}
//@:file("assets/level/Level 2.oel") class __ASSET__level_level_2_oel extends lime.utils.ByteArray {}
//@:file("assets/level/Level 3.oel") class __ASSET__level_level_3_oel extends lime.utils.ByteArray {}
//@:file("assets/level/Level 4.oel") class __ASSET__level_level_4_oel extends lime.utils.ByteArray {}
//@:file("assets/level/Level 5.oel") class __ASSET__level_level_5_oel extends lime.utils.ByteArray {}
//
//

#end

#end
#end

