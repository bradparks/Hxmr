package hxrm.analyzer.extensions;
import hxrm.parser.mxml.MXMLNode;
import hxrm.parser.mxml.MXMLQName;

class PropertiesExtension extends NodeAnalyzerExtensionBase {

	override public function matchAttribute(scope:NodeScope, attributeQName:MXMLQName, value:String):Void {
	
		if(attributeQName.namespace == scope.context.node.name.namespace || attributeQName.namespace == MXMLQName.ASTERISK) {
			trace('${attributeQName.localPart} = $value');
			
			if(scope.initializers.exists(attributeQName.localPart)) {
				trace("duplicate property assign!");
				throw "duplicate property assign!";
			}
			
			scope.initializers.set(attributeQName.localPart, value);
		}
		else {
			super.matchAttribute(scope, attributeQName, value);
		}
	}
}