package hxrm.analyzer;

import hxrm.utils.QNameUtils;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import hxrm.parser.mxml.MXMLNode;
import hxrm.parser.QName;

using StringTools;
using haxe.macro.Tools;

class NodeScope {

	public var namespaces:Map < String, Array<String> > ;

	public var typeParams:Array<QName>;

	public var type:Type;
	public var classType:ClassType;

	public var fields:Array<ClassField>;
	public var statics:Array<ClassField>;

	public var parentScope:NodeScope;

	public function new() {
	}

	public function getType(typeQName:QName):Type {
		var type = null;
		try {
			type = Context.getType(typeQName.toHaxeTypeId());
		} catch (e:Dynamic) {
			trace(e);
			throw "can't find type: " + typeQName;
		}
		return type;
	}

	public function resolveClassPath(q:QName):QName {

		if (!namespaces.exists(q.namespace)) throw "unknow namespace";
		var resolvedNamespaceParts : Array<String> = namespaces[q.namespace];

		// <flash.display.Sprite /> support
		var localQName : QName = QNameUtils.fromHaxeTypeId(q.localPart);
		
		resolvedNamespaceParts.concat(QNameUtils.splitNamespace(localQName.namespace));
		
		return new QName(QNameUtils.joinNamespaceParts(resolvedNamespaceParts), localQName.localPart);
	}

	public function copyFrom(s:NodeScope):Void {
		for (nsName in s.namespaces.keys()) {
			namespaces[nsName] = s.namespaces[nsName];
		}
	}
}