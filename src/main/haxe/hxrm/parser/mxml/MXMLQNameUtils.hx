package hxrm.parser.mxml;
import StringTools;
import StringTools;
import hxrm.parser.mxml.MXMLNode;
class MXMLQNameUtils {
	public static function fromQualifiedString(s: String) : MXMLQName {
		var parts = StringTools.trim(s).split(MXMLQName.QUALIFIED_ID_GLUE);
		return if (parts.length == 1) {
			new MXMLQName(MXMLQName.ASTERISK, parts[0]);
		} else {
			new MXMLQName(parts[0], parts[1]);
		}
	}

	inline public static function resolveNamespaceValue(node : MXMLNode, namespacePrefix : String) : String {
		return node.namespaces.get(StringTools.trim(namespacePrefix));
	}
}
