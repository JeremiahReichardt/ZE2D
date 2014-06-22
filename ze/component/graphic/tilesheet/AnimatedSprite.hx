package ze.component.graphic.tilesheet;
import haxe.ds.StringMap;
import ze.util.Time;

/**
 * ...
 * @author Goh Zi He
 */

class AnimatedSprite extends TilesheetObject
{
	public var currentFrame(default, null):Int;
	public var currentFrameLabel(default, null):String;
	public var playing(default, null):Bool;
	
	private var _timer:Int;
	private var _lastTime:Int;
	private var _animationData:AnimationData;
	private var _playOnce:Bool;
	
	override function added():Void 
	{
		super.added();
		_animationData = new AnimationData(_tileSheetLayer.getSpriteIndices(_name));
	}
	
	override private function update():Void
	{
		super.update();
		if (!playing)
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
			
			_tileID = _animationData.getFrame(currentFrame);
		}
	}
	
	public function play(label:String, fps:Int = 30, startFrame:Int = 0):AnimatedSprite
	{
		_animationData.setCurrentAnimation(label);
		_animationData.fps = fps;
		_lastTime = Time.currentTime;
		currentFrame = startFrame;
		currentFrameLabel = label;
		playing = true;
		return this;
	}
	
	public function playOnce(label:String, fps:Int = 30):AnimatedSprite
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
	
	public function addAnimationFromFrame(animationName:String, startFrame:Int = 0, endFrame:Int = 1):AnimatedSprite
	{
		var animationArray:Array<Int> = [];
		for (i in startFrame ... endFrame)
		{
			animationArray[i] = i;
		}
		_animationData.addAnimation(animationName, animationArray);
		return this;
	}
	
	public function addAnimation(animationName:String, animationArray:Array<Int>):AnimatedSprite
	{
		_tileID = _animationData.addAnimation(animationName, animationArray).getFrame(currentFrame);
		return this;
	}
	
	override private function destroyed():Void 
	{
		super.destroyed();
		
		_animationData.destroy();
		_animationData = null;
	}
}

class AnimationData
{
	public var totalFrames(get, null):Int;
	public var fps(default, default):Int;
	public var timePerFrame(get, null):Float;
	
	private var _animationData:Array<Int>;
	private var _animationFrames:Array<Int>;
	private var _animationLabel:StringMap<Array<Int>>;
	
	public function new(animationData:Array<Int>)
	{
		_animationData = animationData;
		_animationFrames = [];
		_animationLabel = new StringMap<Array<Int>>();
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
			trace("Warning: Animation label [" + animation + "] don't exist.");
			return;
		}
	}
	
	public function getFrame(currentFrame:Int):Int
	{
		return _animationData[_animationFrames[currentFrame]];
	}
	
	public function addAnimation(animationName:String, frames:Array<Int>):AnimationData
	{
		if (_animationLabel.exists(animationName))
		{
			return this;
		}
		_animationLabel.set(animationName, frames);
		return this;
	}
	
	/**
	 * Returns a new instance of AnimationData so that different gameObject will have independent animation
	 * if not animation will all be affected
	 * @return
	 */
	public function cloneAnimationData():AnimationData
	{
		var newAnimData:AnimationData = new AnimationData(_animationData);
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