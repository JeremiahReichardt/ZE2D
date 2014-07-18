package scenes;
import entities.AlienSpawner;
import entities.Plane;
import openfl.display.BitmapData;
import openfl.ui.Mouse;
import ze.component.graphic.displaylist.Image;
import ze.component.graphic.displaylist.Text;
import ze.object.GameObject;
import ze.object.Scene;
import ze.util.Color;
import ze.util.Input;

/**
 * ...
 * @author Goh Zi He
 */
class MainScene extends Scene
{
	private var _lives:Int;
	private var _hearts:Array<GameObject>;
	private var _overLay:GameObject;
	private var _replayText:GameObject;
	private var _scoreText:GameObject;
	private var _score:Int;
	
	override public function added():Void
	{
		super.added();
		_hearts = [];
		_score = 0;
		
		_scoreText = new GameObject("Score", screen.width - 100, 10);
		addGameObject(_scoreText);
		_scoreText.addComponent(new Text("0", Color.WHITE));
		
		for (i in 0 ... 3)
		{
			var heart:GameObject = new GameObject("Heart", i * 20 + 10, 10);
			addGameObject(heart);
			heart.addComponent(new Image("Heart", "gfx/Heart.png"));
			_hearts.push(heart);
		}
		
		_overLay = new GameObject("Overlay");
		addGameObject(_overLay);
		_overLay.addComponent(new Image("Overlay", new BitmapData(Std.int(screen.width), Std.int(screen.height), true, Color.GREY)));
		
		_replayText = new GameObject("Replay", 250, 440);
		addGameObject(_replayText);
		_replayText.addComponent(new Text("Click to replay", Color.BLACK));
		
		addGameObject(new Plane());
		addGameObject(new AlienSpawner());
		
		startGame();
	}
	
	private function startGame():Void
	{
		_lives = 3;
		_score = 0;
		
		for (i in 0 ... _lives)
		{
			_hearts[i].graphic.visible = true;
		}
		
		for (gameObject in getGameObjectsByName("Alien"))
		{
			removeGameObject(gameObject);
		}
		_overLay.graphic.visible = false;
		_replayText.graphic.visible = false;
		cast(_scoreText.graphic, Text).setText(Std.string(_score));
		
		Mouse.hide();
		enable = true;
	}
	
	private function endGame():Void
	{
		enable = false;
		_overLay.graphic.visible = true;
		_replayText.graphic.visible = true;
		
		_score = 0;
		cast(_scoreText.graphic, Text).setText(Std.string(_score));
		Mouse.show();
	}
	
	override public function update():Void 
	{
		super.update();
		if (!enable && (Input.leftMousePressed()))
		{
			startGame();
		}
	}
	
	public function loseHealth():Void
	{
		--_lives;
		_hearts[_lives].graphic.visible = false;
		
		if (_lives == 0)
		{
			endGame();
			return;
		}
	}
	
	public function addScore():Void
	{
		_score += 10;
		cast(_scoreText.graphic, Text).setText(Std.string(_score));
	}
}