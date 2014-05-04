package puzzle.actions;
import ze.component.core.Component;
import ze.component.physics.Collider;
//import ze.component.rendering.Text;
import ze.component.tilesheet.Sprite;
import ze.object.GameObject;

/**
 * ...
 * @author Goh Zi He
 */
class Sign extends Component
{
	private var _dialog:GameObject;
	//private var _text:Text;
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
		
		//_text = new Text("");
		//_text.offsetX = 30;
		//_text.offsetY = 30;
		//_text.layer = 1;
		//_dialog.addComponent(_text);
		
		_background = new Sprite("Dialog");
		_background.layer = 2;
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
		//_text.setText(text);
	}
	
	public function showDialog():Void
	{
		_background.visible = true;
		//_background.visible = _text.visible = true;
	}
	
	public function hideDialog():Void
	{
		_background.visible = false;
		//_background.visible = _text.visible = false;
	}
}