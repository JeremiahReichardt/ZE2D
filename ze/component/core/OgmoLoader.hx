package ze.component.core;

import openfl.Assets;
import ze.component.core.Component;
import ze.object.GameObject;

/**
 * ...
 * @author Goh Zi He
 */
class OgmoLoader extends Component
{
	private var _levelDirectory:String;
	private var _levelXML:Xml;
	
	private var _current:Int;
	private var _layers:Array<String>;
	private var _entities:Array<Array<EntityProperties>>;
	
	public function new()
	{
		super();
		_layers = [];
		_entities = [];
	}
	
	public function setOEL(levelName:String):Void
	{
		var xmlText:String = Assets.getText(levelName);
		if (xmlText == null)
		{
			return;
		}
		
		var xml:Xml = Xml.parse(xmlText);
		_levelXML = xml.firstChild();
	}
	
	public function setLayer(layer:String):Void
	{
		for (i in 0 ... _layers.length)
		{
			if (_layers[i] == layer)
			{
				_current = i;
				return;
			}
		}
		
		_layers.push(layer);
	}
	
	public function setEntity(entityName:String, cls:Class<GameObject>):Void
	{
		if (_entities[_current] == null)
		{
			_entities[_current] = [];
		}
		else
		{
			for (e in _entities[_current])
			{
				if (e.name == entityName)
				{
					return;
				}
			}
		}
		_entities[_current].push(new EntityProperties(entityName, cls));
	}
	
	public function loadAll():Void
	{
		if (_levelXML == null)
		{
			trace("Run setOEL() first.");
			return;
		}
		
		for (layer in _layers)
		{
			for (x in _levelXML.elementsNamed(layer))
			{
				for (element in x.elements())
				{
					var nodeName:String = element.nodeName;
					for (entity in _entities[_current])
					{
						if (entity.name == nodeName)
						{
							var cls:Class<GameObject> = entity.cls;
							var params:Dynamic<Int> = cast {};
							for (attribute in element.attributes())
							{
								Reflect.setProperty(params, attribute, Std.parseInt(element.get(attribute)));
							}
							scene.addGameObject(Type.createInstance(cls, [params]));
						}
					}
				}
			}
		}
	}
}

class EntityProperties
{
	public var name:String;
	public var cls:Class<GameObject>;
	
	public function new(name:String, cls:Class<GameObject>)
	{
		this.name = name;
		this.cls = cls;
	}
}