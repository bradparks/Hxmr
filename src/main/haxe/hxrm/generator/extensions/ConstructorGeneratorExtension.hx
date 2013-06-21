package hxrm.generator.extensions;

import hxrm.analyzer.NodeScope;
import haxe.macro.Expr;
import hxrm.generator.GeneratorContext;
import hxrm.generator.GeneratorScope;

class ConstructorGeneratorExtension extends GeneratorExtensionBase {

	override public function generate(context:HxmrContext, scope:GeneratorScope):Bool {
		if(scope.ctor == null) {
			generateCtor(context, scope);
		}
		
		return false;
	}

	function generateCtor(context:HxmrContext, scope:GeneratorScope)
	{
		var superCall = macro super();
		scope.ctorExprs = [superCall];
		
		var ctor = {
			name: "new",
			doc: "autogenerated constructor",
			access: [APublic],
			pos: scope.context.pos,
			kind: FFun({args:[], ret:null, expr:macro $b{scope.ctorExprs}, params:[]})
		}
		
		scope.ctor = ctor;
		scope.typeDefinition.fields.push(ctor);
	}


}
