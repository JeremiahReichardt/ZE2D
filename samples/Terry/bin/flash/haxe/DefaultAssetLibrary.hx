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
		className.set ("font/GROBOLD.eot", __ASSET__font_grobold_eot);
		type.set ("font/GROBOLD.eot", AssetType.BINARY);
		className.set ("font/GROBOLD.svg", __ASSET__font_grobold_svg);
		type.set ("font/GROBOLD.svg", AssetType.TEXT);
		className.set ("font/GROBOLD.ttf", __ASSET__font_grobold_ttf);
		type.set ("font/GROBOLD.ttf", AssetType.FONT);
		className.set ("font/GROBOLD.woff", __ASSET__font_grobold_woff);
		type.set ("font/GROBOLD.woff", AssetType.BINARY);
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
		id = "font/GROBOLD.eot";
		path.set (id, id);
		
		type.set (id, AssetType.BINARY);
		id = "font/GROBOLD.svg";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "font/GROBOLD.ttf";
		className.set (id, __ASSET__font_grobold_ttf);
		
		type.set (id, AssetType.FONT);
		id = "font/GROBOLD.woff";
		path.set (id, id);
		
		type.set (id, AssetType.BINARY);
		id = "font/Grobold.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		
		
		#else
		
		#if openfl
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		openfl.text.Font.registerFont (__ASSET__font_grobold_ttf);
		
		
		
		#end
		
		#if (windows || mac || linux)
		
		/*var useManifest = false;
		
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
		
		className.set ("font/GROBOLD.eot", __ASSET__font_grobold_eot);
		type.set ("font/GROBOLD.eot", AssetType.BINARY);
		
		className.set ("font/GROBOLD.svg", __ASSET__font_grobold_svg);
		type.set ("font/GROBOLD.svg", AssetType.TEXT);
		
		className.set ("font/GROBOLD.ttf", __ASSET__font_grobold_ttf);
		type.set ("font/GROBOLD.ttf", AssetType.FONT);
		
		className.set ("font/GROBOLD.woff", __ASSET__font_grobold_woff);
		type.set ("font/GROBOLD.woff", AssetType.BINARY);
		
		className.set ("font/Grobold.xml", __ASSET__font_grobold_xml);
		type.set ("font/Grobold.xml", AssetType.TEXT);
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

@:keep @:bind #if display private #end class __ASSET__atlas_game_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__atlas_game_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__atlas_ui_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__atlas_ui_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__gfx_bullet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_checker_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_dialog_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_exit_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_font_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_horizontalgate_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_respawn_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_sign_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_switch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__gfx_verticalgate_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__sfx_hit_hurt5_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__sfx_laser_shoot3_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__sfx_pickup_coin_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__level_puzzle_0_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__level_puzzle_1_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__level_puzzle_2_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__level_puzzle_3_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__level_puzzle_4_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__level_puzzle_5_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__level_puzzle_oep extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__font_font_fnt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__font_font_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__font_grobold_bmfc extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__font_grobold_eot extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__font_grobold_svg extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__font_grobold_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__font_grobold_woff extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__font_grobold_xml extends flash.utils.ByteArray { }


#elseif html5

#if openfl






























@:keep #if display private #end class __ASSET__font_grobold_ttf extends openfl.text.Font { public function new () { super (); fontName = "font/GROBOLD.ttf"; } } 



#end

#else

#if openfl
class __ASSET__font_grobold_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "font/GROBOLD.ttf"; fontName = "GROBOLD"; }}

#end

#if (windows || mac || linux)

//
//@:bitmap("assets/atlas/game.png") class __ASSET__atlas_game_png extends openfl.display.BitmapData {}
//@:file("assets/atlas/game.xml") class __ASSET__atlas_game_xml extends lime.utils.ByteArray {}
//@:bitmap("assets/atlas/ui.png") class __ASSET__atlas_ui_png extends openfl.display.BitmapData {}
//@:file("assets/atlas/ui.xml") class __ASSET__atlas_ui_xml extends lime.utils.ByteArray {}
//@:bitmap("assets/gfx/Bullet.png") class __ASSET__gfx_bullet_png extends openfl.display.BitmapData {}
//@:bitmap("assets/gfx/Checker.png") class __ASSET__gfx_checker_png extends openfl.display.BitmapData {}
//@:bitmap("assets/gfx/Dialog.png") class __ASSET__gfx_dialog_png extends openfl.display.BitmapData {}
//@:bitmap("assets/gfx/Exit.png") class __ASSET__gfx_exit_png extends openfl.display.BitmapData {}
//@:bitmap("assets/gfx/Font.png") class __ASSET__gfx_font_png extends openfl.display.BitmapData {}
//@:bitmap("assets/gfx/HorizontalGate.png") class __ASSET__gfx_horizontalgate_png extends openfl.display.BitmapData {}
//@:bitmap("assets/gfx/Player.png") class __ASSET__gfx_player_png extends openfl.display.BitmapData {}
//@:bitmap("assets/gfx/Respawn.png") class __ASSET__gfx_respawn_png extends openfl.display.BitmapData {}
//@:bitmap("assets/gfx/Sign.png") class __ASSET__gfx_sign_png extends openfl.display.BitmapData {}
//@:bitmap("assets/gfx/Switch.png") class __ASSET__gfx_switch_png extends openfl.display.BitmapData {}
//@:bitmap("assets/gfx/VerticalGate.png") class __ASSET__gfx_verticalgate_png extends openfl.display.BitmapData {}
//@:sound("assets/sfx/Hit_Hurt5.wav") class __ASSET__sfx_hit_hurt5_wav extends openfl.media.Sound {}
//@:sound("assets/sfx/Laser_Shoot3.wav") class __ASSET__sfx_laser_shoot3_wav extends openfl.media.Sound {}
//@:sound("assets/sfx/Pickup_Coin.wav") class __ASSET__sfx_pickup_coin_wav extends openfl.media.Sound {}
//@:file("assets/level/Puzzle 0.oel") class __ASSET__level_puzzle_0_oel extends lime.utils.ByteArray {}
//@:file("assets/level/Puzzle 1.oel") class __ASSET__level_puzzle_1_oel extends lime.utils.ByteArray {}
//@:file("assets/level/Puzzle 2.oel") class __ASSET__level_puzzle_2_oel extends lime.utils.ByteArray {}
//@:file("assets/level/Puzzle 3.oel") class __ASSET__level_puzzle_3_oel extends lime.utils.ByteArray {}
//@:file("assets/level/Puzzle 4.oel") class __ASSET__level_puzzle_4_oel extends lime.utils.ByteArray {}
//@:file("assets/level/Puzzle 5.oel") class __ASSET__level_puzzle_5_oel extends lime.utils.ByteArray {}
//@:file("assets/level/Puzzle.oep") class __ASSET__level_puzzle_oep extends lime.utils.ByteArray {}
//@:file("assets/font/Font.fnt") class __ASSET__font_font_fnt extends lime.utils.ByteArray {}
//@:bitmap("assets/font/Font_0.png") class __ASSET__font_font_0_png extends openfl.display.BitmapData {}
//@:file("assets/font/GROBOLD.bmfc") class __ASSET__font_grobold_bmfc extends lime.utils.ByteArray {}
//@:file("assets/font/GROBOLD.eot") class __ASSET__font_grobold_eot extends lime.utils.ByteArray {}
//@:file("assets/font/GROBOLD.svg") class __ASSET__font_grobold_svg extends lime.utils.ByteArray {}
//@:font("assets/font/GROBOLD.ttf") class __ASSET__font_grobold_ttf extends openfl.text.Font {}
//@:file("assets/font/GROBOLD.woff") class __ASSET__font_grobold_woff extends lime.utils.ByteArray {}
//@:file("assets/font/Grobold.xml") class __ASSET__font_grobold_xml extends lime.utils.ByteArray {}
//
//

#end

#end
#end

