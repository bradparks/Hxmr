package hxrm.analyzer.extensions;

import hxrm.parser.mxml.MXMLNode;
import hxrm.parser.mxml.MXMLQNameUtils;

class ScriptBlockExtension extends NodeAnalyzerExtensionBase {

	override public function analyze(scope:NodeScope, node:MXMLNode):Bool {
		for (childNode in node.children) {
				matchChild(scope, childNode);
		}
		return false;
	}

	function matchChild(scope:NodeScope, child:MXMLNode):Void {

		if(child.name.localPart != "Script"){
			return;
		}
		
		// TODO remove hardcoded URL
		if(MXMLQNameUtils.resolveNamespaceValue(child, child.name.namespace) != "http://haxe.org/hxmr/") {
			return;
		}

		trace("Script block!");
	}

}
