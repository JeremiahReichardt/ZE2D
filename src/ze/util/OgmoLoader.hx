package ze.util;

import openfl.Assets;
import ze.object.Prefab;
import ze.object.Scene;

/**
 * A template for loading files from Ogmo
 * @author Goh Zi He
 */
class OgmoLoader
{
	private static var _levelDirectory:String;
	private static var _levelXML:Xml;
	
	public static var scene:Scene;
	
	private static inline var EXTENSION:String = ".oel";
	
	public static function loadOEL(levelName:String):Void
	{
		var xmlText:String = Assets.getText(levelName + EXTENSION);
		if (xmlText == null)
		{
			return;
		}
		
		var xml:Xml = Xml.parse(xmlText);
		_levelXML = xml.firstChild();
	}
	
	public static function loadEntity(layerName:String, entityName:String, cls:Class<Prefab>):Void
	{
		if (_levelXML == null)
		{
			trace("Run OgmoLoader.loadOEL() first.");
			return;
		}
		
		for (x in _levelXML.elementsNamed(layerName))
		{
			for (element in x.elements())
			{
				if (element.nodeName == entityName)
				{
					var params:Dynamic<Int> = cast {};
					for (attribute in element.attributes())
					{
						Reflect.setProperty(params, attribute, Std.parseInt(element.get(attribute)));
					}
					Type.createInstance(cls, [params, scene]);
				}
			}
		}
	}
}