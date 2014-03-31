package ze.util;

import openfl.Assets;
import ze.object.GameObject;
import ze.object.Scene;

/**
 * ...
 * @author Goh Zi He
 */
class OgmoLoader
{
	private var _levelDirectory:String;
	private var _levelXML:Xml;
	
	private var _current:Int;
	private var _layers:Array<String>;
	private var _entities:Array<Array<EntityProperties>>;
	
	private var _scene:Scene;
	
	public function new(scene:Scene)
	{
		_scene = scene;
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
		
		_current = _layers.length;
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
		
		_current = 0;
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
							_scene.addGameObject(Type.createInstance(cls, [params]));
						}
					}
				}
			}
			
			++_current;
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