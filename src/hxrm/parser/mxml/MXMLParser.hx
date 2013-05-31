package hxrm.parser.mxml;

import hxrm.parser.Tools;

using StringTools;

class MXMLParser
{
	public function new() {
	}
	
	public function parse(data:String):Null<MXMLNode> {
		
		var xml = null;
		try {
			xml = Xml.parse(data);
		} catch (e:Dynamic) {
			throw new ParserError(UNKNOWN_DATA_FORMAT, { to : 0 , from : 0 });
		}
		
		return parseRootNode(xml);
	}
	
	function parseRootNode(node : Xml):Null<MXMLNode>  {
		var firstElement = node.firstElement();
		
		if (firstElement == null) {
			throw new ParserError(EMPTY_DATA, { to : 0 , from : 0 });
		}
		
		return parseNode(firstElement);
	}

	function parseNode(xmlNode : Xml):Null<MXMLNode>  {
	
		var n = new MXMLNode();
		n.name = MXMLQNameUtils.fromQualifiedString(xmlNode.nodeName);

		parseAttributes(xmlNode, n);
		parseChildren(xmlNode, n);

		return n;
	}
	
	function parseChildren(xmlNode:Xml, n:MXMLNode) {
		for (c in xmlNode.elements()) {
			var child = parseNode(c);
			child.parentNode = n;
			n.children.push(child);
		}
	}
	
	function parseAttributes(xmlNode:Xml, n:MXMLNode) {
		for (attributeName in xmlNode.attributes()) {
			
			var attributeQName = MXMLQNameUtils.fromQualifiedString(attributeName);
			var value = xmlNode.get(attributeName);
			
			switch [attributeQName.namespace, attributeQName.localPart] {
				case [ "*", "xmlns" ]:
					n.namespaces[attributeQName.namespace] = value;
				case [ "xmlns", _ ]:
					n.namespaces[attributeQName.localPart] = value;
				case _:
					n.attributes.set(attributeQName, value);
			}
		}
	}
	
	public function cleanCache():Void {
		// чистим кеши всякой всячины
	}
}