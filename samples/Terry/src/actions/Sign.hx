package actions;
import ze.component.core.Component;
import ze.component.graphic.tilesheet.Sprite;
import ze.component.graphic.tilesheet.Text;
import ze.component.physics.Collider;
import ze.object.GameObject;

/**
 * ...
 * @author Goh Zi He
 */
class Sign extends Component
{
	private var _dialog:GameObject;
	private var _text:Text;
	private var _background:Sprite;
	
	public function new()
	{
		super();
	}
	
	override private function added():Void 
	{
		super.added();
		_dialog = new GameObject("dialog", 100, 250);
		scene.addGameObject(_dialog);
		
		var _dialogText:GameObject = new GameObject("dialogText", 130, 300);
		scene.addGameObject(_dialogText);
		
		_text = new Text("Grobold");
		_dialogText.addComponent(_text);
		
		_background = new Sprite("Dialog");
		_dialog.addComponent(_background);
		
		collider.registerCallback(hitSign, exitSign);
		hideDialog();
	}
	
	private function hitSign(collider:Collider):Void
	{
		if (collider.gameObject.name == "player")
		{
			showDialog();
		}
	}
	
	private function exitSign(collider:Collider):Void
	{
		if (collider.gameObject.name == "player")
		{
			hideDialog();
		}
	}
	
	public function addText(text:String):Void
	{
		_text.text = text;
	}
	
	public function showDialog():Void
	{
		_background.visible = _text.visible = true;
	}
	
	public function hideDialog():Void
	{
		_background.visible = _text.visible = false;
	}
}