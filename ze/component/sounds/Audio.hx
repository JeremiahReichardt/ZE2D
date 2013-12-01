package ze.component.sounds;

import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import openfl.Assets;
import ze.component.core.Component;

/**
 * ...
 * @author Goh Zi He
 */

class Audio extends Component
{
	public var volume(get, null):Float;
	public var pan(get, null):Float;
	public var playing(default, null):Bool;
	
	private var _sound:Sound;
	private var _soundChannel:SoundChannel;
	private var _soundTransform:SoundTransform;
	private var _play:Bool;
	private var _loop:Bool;
	private var _position:Float;
	
	private static var _globalMuted:Bool;
	private static var _soundPool:Array<SoundTransform> = [];
	private static var _audioCache:Map<String, Sound> = new Map<String, Sound>();
	
	public function new(audioName:String, audioPath:String = "") 
	{
		super();
		_soundTransform = new SoundTransform();
		addToSoundPool(_soundTransform);
		
		_sound = _audioCache.get(audioName);
		if (_sound == null)
		{
			_sound = createAudio(audioName, audioPath);
		}
	}
	
	public static function createAudio(audioName:String, audioPath:String):Sound
	{
		var audio:Sound = null;
		if (!_audioCache.exists(audioName))
		{
			audio = Assets.getSound(audioPath);
			_audioCache.set(audioName, audio);
		}
		
		return audio;
	}
	
	public function play(volume:Float = 1, pan:Float = 0, loop:Bool = false):Void
	{
		if (_globalMuted)
		{
			_soundTransform.volume = 0;
		}
		else
		{
			_soundTransform.volume = volume;
		}
		_soundTransform.pan = pan;
		_loop = loop;
		_play = true;
		playing = true;
		_position = 0;
		resume();
	}
	
	public function resume():Void
	{
		_soundChannel = _sound.play(_position, 0, _soundTransform);
		_soundChannel.addEventListener(Event.SOUND_COMPLETE, soundComplete);
	}
	
	public function stop():Void
	{
		playing = false;
		if (_soundChannel != null)
		{
			_position = _soundChannel.position;
			
			_soundChannel.stop();
			_soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundComplete);
		}
	}
	
	private function soundComplete(e:Event):Void 
	{
		if (_loop)
		{
			play(_soundTransform.volume, _soundTransform.pan, _loop);
		}
		else
		{
			stop();
		}
	}
	
	/**
	 * Set the volume of the current audio, 0 for no volume and 1 for full volume
	 * @param	volume	0 is mute, 1 is full volume
	 */
	public function setVolume(volume:Int = 1):Void
	{
		_soundTransform.volume = volume;
	}
	
	override private function removed():Void 
	{
		removeFromSoundPool(_soundTransform);
		_sound = null;
		_soundChannel = null;
		_soundTransform = null;
		
		super.removed();
	}
	
	private function get_volume():Float
	{
		return _soundTransform.volume;
	}
	
	private function get_pan():Float
	{
		return _soundTransform.pan;
	}
	
	public static function toggleMute():Void
	{
		if (_globalMuted)
		{
			unMute();
		}
		else
		{
			mute();
		}
	}
	
	public static function mute():Void
	{
		_globalMuted = true;
		for (soundTransform in _soundPool)
		{
			soundTransform.volume = 0;
		}
	}
	
	public static function unMute():Void
	{
		_globalMuted = false;
		for (soundTransform in _soundPool)
		{
			soundTransform.volume = 1;
		}
	}
	
	private static function addToSoundPool(soundTransform:SoundTransform):Void
	{
		_soundPool.push(soundTransform);
	}
	
	private static function removeFromSoundPool(soundTransform:SoundTransform):Void
	{
		_soundPool.remove(soundTransform);
	}
}