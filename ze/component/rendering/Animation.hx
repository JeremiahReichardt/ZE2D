package ze.component.rendering;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import openfl.Assets;
import ze.util.Time;

/**
 * ...
 * @author Goh Zi He
 */

class Animation extends Graphic
{
	public var currentFrame(default, null):Int;
	public var currentFrameLabel(default, null):String;
	public var playing(default, null):Bool;
	
	private var _timer:Float;
	private var _elapsed:Float;
	private var _lastTime:Int;
	private var _animationData:AnimationData;
	private var _playOnce:Bool;
	
	private static var _animationCache:Map<String, AnimationData> = new Map<String, AnimationData>();
	
	public function new(imageLabel:String, imagePath:String = "", animationWidth:Int = 1, animationHeight:Int = 1) 
	{
		super();
		_timer = 0;
		playing = true;
		
		var animationData:AnimationData = _animationCache.get(imageLabel);
		if (animationData == null)
		{
			animationData = createAnimation(imageLabel, imagePath, animationWidth, animationHeight);
		}
		
		_animationData = animationData.cloneAnimationData();
		setBitmapData(animationData.getCurrentFrame(currentFrame));
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
			setBitmapData(_animationData.getCurrentFrame(currentFrame));
		}
	}
	
	public function play(label:String, fps:Int = 30, startFrame:Int = 0):Animation
	{
		_animationData.setCurrentAnimation(label);
		_animationData.fps = fps;
		_lastTime = Time.currentTime;
		currentFrame = startFrame;
		currentFrameLabel = label;
		playing = true;
		return this;
	}
	
	public function playOnce(label:String, fps:Int = 30):Animation
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
	
	public function addAnimation(animationName:String, animation:Array<Int>):Animation
	{
		_animationData.addAnimation(animationName, animation);
		return this;
	}
	
	public static function createAnimation(imageLabel:String, imagePath:String, animationWidth:Int, animationHeight:Int):AnimationData
	{
		// Get the name of the image and then cache it so all the same animations can use it
		if (_animationCache.exists(imagePath))
		{
			trace("Animation already existed, removing first animation");
			_animationCache.remove(imagePath);
		}
		
		var bitmap:Bitmap = new Bitmap(Assets.getBitmapData(imagePath));
		var row:Int = Math.floor(bitmap.width / animationWidth);
		var column:Int = Math.floor(bitmap.height / animationHeight);
		var bitmapDataArray:Array<BitmapData> = [];
		var animationData:AnimationData;
		
		for (i in 0 ... row)
		{
			for (j in 0 ... column)
			{
				var bitmapData:BitmapData = new BitmapData(animationWidth, animationHeight);
				var sourceRect:Rectangle = new Rectangle(i * animationWidth, j * animationHeight, animationWidth, animationHeight);
				var destPoint:Point = new Point(0, 0);
				
				bitmapData.copyPixels(bitmap.bitmapData, sourceRect, destPoint);
				bitmapDataArray.push(bitmapData);
			}
		}
		
		animationData = new AnimationData(bitmapDataArray);
		_animationCache.set(imageLabel, animationData);
		
		return animationData;
	}
	
	override private function removed():Void 
	{
		//_animationData = null;
		super.removed();
	}
}

class AnimationData
{
	public var totalFrames(get, null):Int;
	public var fps(default, default):Int;
	public var timePerFrame(get, null):Float;
	
	private var _animationData:Array<BitmapData>;
	private var _animationFrames:Array<Int>;
	private var _animationLabel:Map<String, Array<Int>>;
	
	public function new(animationData:Array<BitmapData>)
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
			trace("Warning: Animation label [" + animation + "] don't exist, using random animation.");
			for (anim in _animationLabel.iterator())
			{
				_animationFrames = anim;
			}
		}
	}
	
	public function getCurrentFrame(currentFrame:Int):BitmapData
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
}