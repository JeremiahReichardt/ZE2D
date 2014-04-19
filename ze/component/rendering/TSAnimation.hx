package ze.component.rendering;
import ze.component.core.Component;
import ze.util.Time;

/**
 * ...
 * @author Goh Zi He
 */

class TSAnimation extends TSGraphic
{
	public var currentFrame(default, null):Int;
	public var currentFrameLabel(default, null):String;
	public var playing(default, null):Bool;
	
	private var _timer:Int;
	private var _lastTime:Int;
	private var _animationData:TSAnimationData;
	private var _playOnce:Bool;
	
	private var _tileIndices:Array<Int>;
	
	private static var _animationCache:Map<String, TSAnimationData> = new Map<String, TSAnimationData>();
	
	public function new(label:String) 
	{
		super();
		
		var animationData:TSAnimationData = _animationCache.get(label);
		if (animationData == null)
		{
			_tileIndices = scene.screenTileSheet.getTileIndices(label);
			animationData = createAnimation(label, _tileIndices);
		}
		
		_animationData = animationData.cloneAnimationData();
		_tileIndex = _animationData.getFrame(currentFrame);
	}
	
	override private function update():Void 
	{
		super.update();
		
		if (!playing || !visible)
		{
			return;
		}
		
		_timer += (Time.currentTime - _lastTime);
		if (_timer >= _animationData.timePerFrame)
		{
			_timer = 0;
			++currentFrame;
			_lastTime = Time.currentTime;
			
			if (currentFrame >= _animationData.totalFrames)
			{
				if (_playOnce)
				{
					playing = _playOnce = false;
					currentFrame = _animationData.totalFrames - 1;
				}
				else
				{
					// In case current frame overshot by a few frames, we get the difference and set it back
					currentFrame = (_animationData.totalFrames - currentFrame);
				}
			}
		}
		
		_tileIndex = _animationData.getFrame(currentFrame);
	}
	
	public function play(label:String, fps:Int = 30, startFrame:Int = 0):TSAnimation
	{
		_animationData.setCurrentAnimation(label);
		_animationData.fps = fps;
		_lastTime = Time.currentTime;
		currentFrame = startFrame;
		currentFrameLabel = label;
		playing = true;
		return this;
	}
	
	public function playOnce(label:String, fps:Int = 30):TSAnimation
	{
		_playOnce = true;
		return play(label, fps);
	}
	
	public function playLast(fps:Int = 30):Void
	{
		play(currentFrameLabel, fps);
	}
	
	/**
	 * Not only stops playing, set the play head to first frame
	 */
	public function stop():Void
	{
		playing = false;
		currentFrame = 0;
	}
	
	/**
	 * Only pause playing temporary
	 */
	public function pause():Void
	{
		playing = false;
	}
	
	public function resume():Void
	{
		playing = true;
	}
	
	public function addAnimationFromFrame(animationName:String, startFrame:Int = 0, endFrame:Int = 1):TSAnimation
	{
		var animationArray:Array<Int> = [];
		for (i in startFrame ... endFrame)
		{
			animationArray[i] = i;
		}
		_animationData.addAnimation(animationName, animationArray);
		return this;
	}
	
	public function addAnimation(animationName:String, animationArray:Array<Int>):TSAnimation
	{
		_animationData.addAnimation(animationName, animationArray);
		return this;
	}
	
	private static function createAnimation(label:String, tileIndices:Array<Int>):TSAnimationData
	{	
		var animationData:TSAnimationData = new TSAnimationData(tileIndices);
		_animationCache.set(label, animationData);
		
		return animationData;
	}
	
	override private function destroyed():Void 
	{
		super.destroyed();
		
		_animationData.destroy();
		_animationData = null;
	}
}

class TSAnimationData
{
	public var totalFrames(get, null):Int;
	public var fps(default, default):Int;
	public var timePerFrame(get, null):Float;
	
	private var _animationData:Array<Int>;
	private var _animationFrames:Array<Int>;
	private var _animationLabel:Map<String, Array<Int>>;
	
	public function new(animationData:Array<Int>)
	{
		_animationData = animationData;
		_animationFrames = [];
		_animationLabel = new Map<String, Array<Int>>();
	}
	
	private function get_timePerFrame():Float
	{
		return 1000 / fps;
	}
	
	private function get_totalFrames():Int
	{
		return _animationFrames.length;
	}
	
	public function setCurrentAnimation(animation:String):Void
	{
		if (_animationLabel.exists(animation))
		{
			_animationFrames = _animationLabel.get(animation);
		}
		else
		{
			trace("Warning: TSAnimation label [" + animation + "] don't exist, using random animation.");
			for (anim in _animationLabel.iterator())
			{
				_animationFrames = anim;
			}
		}
	}
	
	public function getFrame(currentFrame:Int):Int
	{
		return _animationData[_animationFrames[currentFrame]];
	}
	
	public function addAnimation(animationName:String, frames:Array<Int>):TSAnimationData
	{
		if (_animationLabel.exists(animationName))
		{
			return this;
		}
		_animationLabel.set(animationName, frames);
		return this;
	}
	
	public function cloneAnimationData():TSAnimationData
	{
		var newAnimData:TSAnimationData = new TSAnimationData(_animationData);
		newAnimData._animationLabel = _animationLabel;
		return newAnimData;
	}
	
	public function destroy():Void
	{
		_animationData = null;
		_animationFrames = null;
		_animationLabel = null;
	}
}